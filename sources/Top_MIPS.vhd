library ieee;
use ieee.std_logic_1164.all;


entity Top_MIPS is

  port(i_Clk      :  in std_logic;
       i_Rst      :  in std_logic;
       o_Data     :  out std_logic_vector(31 downto 0));
  
end entity Top_MIPS ;

architecture arch1 of Top_MIPS is

  signal w_Opcode    : std_logic_vector(5 downto 0);
  signal w_Funct     : std_logic_vector(5 downto 0);
  signal w_ALUOp_in  : std_logic_vector(1 downto 0);
  signal w_ALUOp_out : std_logic_vector(3 downto 0);
  signal w_Data_Mem  : std_logic_vector(31 downto 0);
  signal w_RegDst    : std_logic;
  signal w_ALUSrc    : std_logic;
  signal w_MemtoReg  : std_logic;
  signal w_RegWrite  : std_logic;
  signal w_MemWrite  : std_logic;
  signal w_Jump      : std_logic;
  signal w_Branch    : std_logic;

  component control_MIPS is 
    port(i_OPCode    : in std_logic_vector(5 downto 0);
         o_RegDst    : out std_logic;
         o_Jump      : out std_logic;
         o_Branch    : out std_logic;
         o_MemWrite  : out std_logic;
         o_MemToReg  : out std_logic;
         o_ALUSrc    : out std_logic;
         o_RegWrite  : out std_logic;
         o_ALUOp     : out std_logic_vector(1 downto 0));
  end component;
  
  component Datapath is 
    generic (p_SIZE : integer :=  32);
    port(i_Clk      : in  std_logic;
         i_Rst      : in  std_logic;
         i_RegDst   : in  std_logic;
         i_Jump     : in  std_logic;
         i_Branch   : in  std_logic;
  --     i_MemRead  : in  std_logic;
         i_MemToReg : in  std_logic;
         i_MemWrite : in  std_logic;
         i_ALUSrc   : in  std_logic;
         i_RegWrite : in  std_logic;
         i_ALUOp    : in  std_logic_vector(3 downto 0);              
         o_OP       : out std_logic_vector(5 downto 0);
         o_Funct    : out std_logic_vector(5 downto 0);
         o_Data_Mem : out std_logic_vector(31 downto 0));
  end component;

  component ALU_Op is
    port(i_Funct : in  std_logic_vector(5 downto 0);
         i_ALUOp : in  std_logic_vector(1 downto 0);
         o_ALUOp : out std_logic_vector(3 downto 0));
  end component;
  
begin
  u_Control: control_MIPS
    port map(i_OPCode    => w_Opcode,
             o_RegDst    => w_RegDst,
             o_Jump      => w_Jump,
             o_Branch    => w_Branch,
             o_MemWrite  => w_MemWrite,
             o_MemToReg  => w_MemtoReg,
             o_ALUSrc    => w_ALUSrc,
             o_RegWrite  => w_RegWrite,
             o_ALUOp     => w_ALUOp_in);
    
    
  u_Datapath: Datapath 
    port map (i_Clk      => i_Clk,
              i_Rst      => i_Rst,
              i_RegDst   => w_RegDst,
              i_Jump     => w_Jump,
              i_Branch   => w_Branch,
              i_MemToReg => w_MemtoReg,
              i_MemWrite => w_MemWrite,
              i_ALUSrc   => w_ALUSrc,
              i_RegWrite => w_RegWrite,
              i_ALUOp    => w_ALUOp_out,            
              o_OP       => w_Opcode,
              o_Funct    => w_Funct,
              o_Data_Mem => w_Data_Mem);
              
  u_ALU_Op : ALU_Op
    port map(i_Funct => w_Funct,
             i_ALUOp => w_ALUOp_in,
             o_ALUOp => w_ALUOp_out);
             
  o_Data <= w_Data_Mem;
            
end arch1;