-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MDC 
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 06/11/2019
-- File: mux2x1_5bits.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all; 
 
entity mux2x1_5bits is

  generic (p_WIDTH : natural := 5);                                 -- data width
  
  port (i_SEL  : in  std_logic;	                                    -- selector
	      i_DIN0 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 1
	      i_DIN1 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 2
	      o_DOUT : out std_logic_vector (p_WIDTH-1 downto 0));        -- data output
	 
end mux2x1_5bits;
 
architecture arch_1 of mux2x1_5bits is

begin
    o_DOUT <= i_DIN0 when i_SEL = '0' else							 -- when selector is zero
	            i_DIN1;														         -- when selector is one
				  
end arch_1;
   	