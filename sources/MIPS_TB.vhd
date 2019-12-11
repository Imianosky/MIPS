library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MIPS_TB is

  
end MIPS_TB;

architecture arch_1 of MIPS_TB is

  component Top_MIPS iS
    port(i_Clk      :  in std_logic;
         i_Rst      :  in std_logic);
	end component;
	
	signal w_Clk   : std_logic := '1';
	signal w_Rst   : std_logic := '0';
  
  constant c_CLKF : integer := 100e6; -- 100 MHz (CLOCK FREQUENCY)
  constant c_CLKP : time    := 1000 ms / c_CLKF; -- clock period / clock period

begin
  w_CLK <= not w_CLK after c_CLKP / 2;
  u_0: Top_MIPS
    port map (i_Clk    => w_Clk,
              i_Rst    => w_Rst);
			
	
end arch_1;	