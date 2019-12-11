-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: ALU_Op.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity ALU_Op is 

  port(i_Funct : in  std_logic_vector(5 downto 0);
       i_ALUOp : in  std_logic_vector(1 downto 0);
       o_ALUOp : out std_logic_vector(3 downto 0));
    
end ALU_Op;

architecture arch1 of ALU_Op is

begin 

  o_ALUOp <= "0010" when i_ALUOp  = "00" or (i_ALUOp = "10" and i_Funct(3 downto 0) = "0000") else
					
             "0110" when i_ALUOp  = "01" or (i_ALUOp = "10" and i_Funct(3 downto 0) = "0010") else
					
             "0000" when (i_ALUOp = "10" and i_Funct(3 downto 0) = "0100") else
					
             "0001" when (i_ALUOp = "10" and i_Funct(3 downto 0) = "0101") else
					
             "0111";

end arch1;
