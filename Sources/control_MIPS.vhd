-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: Control_MIPS.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Control_MIPS is	

  port(i_OPCode    : in std_logic_vector(5 downto 0);
       o_RegDst    : out std_logic;
	     o_Jump      : out std_logic;
	     o_Branch    : out std_logic;
       o_MemWrite  : out std_logic;
	     o_MemToReg  : out std_logic;
	     o_ALUSrc    : out std_logic;
	     o_RegWrite  : out std_logic;
	     o_ALUOp     : out std_logic_vector(1 downto 0));
  
end control_MIPS;

architecture arch1 of control_MIPS is 

begin 

  o_RegDst   <= '1' when i_OPCode = "000000" else '0';
  o_Branch   <= '1' when i_OPCode = "000100" else '0';
--  o_MemRead  <= '1' when i_OPCode = "100011" else '0';
  o_MemWrite <= '1' when i_OPCode = "101011" else '0';
  o_MemToReg <= '1' when i_OPCode = "100011" else '0';
  o_ALUSrc   <= '1' when i_OPCode = "100011" or i_OPCode = "101011" or i_OPCode = "001000" else '0';
  o_RegWrite <= '1' when i_OPCode = "100011" or i_OPCode = "000000" or i_OPCode = "001000" else '0';
  o_Jump     <= '1' when i_OPCode = "000010" else '0';
  o_ALUOp(1) <= '1' when i_OPCode = "000000" else '0';
  o_ALUOp(0) <= '1' when i_OPCode = "000100" else '0';
  
  
end arch1;