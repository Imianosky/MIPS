-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Shift_Left_2_32bits.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Shift_Left_2_32bits is

  port(i_A  :  in  std_logic_vector(31 downto 0);
       o_R  :  out std_logic_vector(31 downto 0));
       
end Shift_Left_2_32bits;

architecture arch1 of Shift_Left_2_32bits is
begin

  o_R(31 downto 2) <= i_A(29 downto 0);
  o_R(1  downto 0) <= "00";
  
end arch1;