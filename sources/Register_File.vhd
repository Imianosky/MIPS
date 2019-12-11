-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Register_File.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Register_File is

  port(i_Clk       : in  std_logic;
       i_Enable    : in  std_logic;
       i_Rst       : in  std_logic;   
       i_Addr_rd_1 : in  std_logic_vector(4  downto 0);
       i_Addr_rd_2 : in  std_logic_vector(4  downto 0); 
       i_Addr_wr   : in  std_logic_vector(4  downto 0);
       i_Din       : in  std_logic_vector(31 downto 0);
       o_Dout_1    : out std_logic_vector(31 downto 0);
       o_Dout_2    : out std_logic_vector(31 downto 0));
       
end Register_File;

architecture arch1 of Register_File is

--Condicao para o registrador 0

type t_Registers is array(31 downto 0) of std_logic_vector (31 downto 0);
signal w_Register_File : t_Registers := (others=>(others=>'0'));

begin 
  process (i_Clk, i_Enable, i_Rst)
  begin
    if (i_Rst = '1') then                                                                   -- Reset/Clear
    
	    w_Register_File <= (others=>(others=>'0'));
      
	  elsif(rising_edge(i_CLK))then
		  if (i_Enable='1') then                                                                -- Check if the Enable input is enabled 
      
		    w_Register_File(to_integer(unsigned(i_Addr_wr))) <= i_Din;                          -- Write the data to the register 
        
		  end if;
	 end if;
  end process;
  
  o_Dout_1 <= w_Register_File(to_integer(unsigned(i_Addr_rd_1)));                           -- Set the values to the outputs
  o_Dout_2 <= w_Register_File(to_integer(unsigned(i_Addr_rd_2)));

end arch1;
  