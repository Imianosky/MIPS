-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Sign_Extend_16_to_32.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;

entity Sign_Extend_16_to_32 is
	
  port(i_A   : in  std_logic_vector(15 downto 0);
       o_R   : out std_logic_vector(31 downto 0));

end Sign_Extend_16_to_32;

architecture arch1 of Sign_Extend_16_to_32 is
begin

  o_R(15 downto 0)  <= i_A (15 downto 0);
  o_R(31 downto 16) <= (others => '0');
    
end arch1;