-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Add.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;

entity Add is
generic (p_SIZE : integer :=  32);
	port(i_A   : in  std_logic_vector(p_SIZE-1 downto 0);
       i_B   : in  std_logic_vector(p_SIZE-1 downto 0);
       o_R   : out std_logic_vector(p_SIZE-1 downto 0));
end Add;

architecture arch1 of Add is
begin

		o_R <= i_A + i_B;
    
end arch1;