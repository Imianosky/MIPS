-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Data_Memory.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Data_Memory is

  port(i_Clk       : in std_logic;
       i_Enable    : in std_logic;  
       i_Addr      : in  std_logic_vector(31 downto 0);
       i_Din       : in  std_logic_vector(31 downto 0);
       o_Dout      : out std_logic_vector(31 downto 0));
 
end Data_Memory;


architecture arch1 of Data_Memory is 
 
  type t_Memory is array(255 downto 0) of std_logic_vector(31 downto 0);
  signal w_Memory : t_Memory := (others=>(others=>'0'));
  signal w_Addr : std_logic_vector(7 downto 0);
  
begin

  w_Addr <= i_Addr(7 downto 0);
  process (i_CLK, i_Enable)
  begin
    if(rising_edge(i_Clk)) then
		  if (i_Enable = '1') then
        w_Memory(to_integer(unsigned(w_Addr))/4) <= i_Din;
	    end if;
		end if;
  end process;
  o_Dout <= w_Memory(to_integer(unsigned(w_Addr)));

end arch1;  

  
  