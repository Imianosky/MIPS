-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Shift_Left_26_to_28.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Shift_Left_26_to_28 is

  port(i_A  :  in  std_logic_vector(25 downto 0);
       o_R  :  out std_logic_vector(27 downto 0));
       
end Shift_Left_26_to_28;

architecture arch1 of Shift_Left_26_to_28 is
begin

  o_R(27 downto 2) <= i_A(25 downto 0);
  o_R(1  downto 0) <= "00";
  
end arch1;