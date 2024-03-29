-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: PC.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity PC is
  generic (p_SIZE : natural :=  32);

  port(i_Rst     : in  std_logic; 
       i_Clk     : in  std_logic;
       i_nextPC  : in  std_logic_vector(p_SIZE-1 downto 0);
       o_PC      : out std_logic_vector(p_SIZE-1 downto 0));
end PC;

architecture arch1 of PC is

  signal w_Q: std_logic_vector(p_SIZE-1 downto 0):= x"00400000";

begin
  process (i_RST,i_CLK)
  begin
    if(i_RST	= '1') then
    
      w_Q <= x"00000000"; 
    
    elsif (rising_edge(i_CLK)) then
    
			w_Q <= i_nextPC;
      
    end if;
  end process;
  
  o_PC <= w_Q;
  
end arch1;