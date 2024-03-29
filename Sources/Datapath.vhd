library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Datapath is
  generic (p_SIZE : integer :=  32);

  port(i_Clk      : in  std_logic;
       i_Rst      : in  std_logic;
       i_RegDst   : in  std_logic;
       i_Jump     : in  std_logic;
       i_Branch   : in  std_logic;
       i_MemToReg : in  std_logic;
       i_MemWrite : in  std_logic;
       i_ALUSrc   : in  std_logic;
       i_RegWrite : in  std_logic;
       i_ALUOp    : in  std_logic_vector(3 downto 0);              
       o_OP       : out std_logic_vector(5 downto 0);
       o_Funct    : out std_logic_vector(5 downto 0);
       o_Data_Mem : out std_logic_vector(31 downto 0));
       
       
end Datapath;

architecture arch1 of Datapath is

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMPONENTS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  component Add is
    generic (p_SIZE : integer := 32);
	  port(i_A  : in  std_logic_vector(p_SIZE-1 downto 0);
         i_B  : in  std_logic_vector(p_SIZE-1 downto 0);
         o_R  : out std_logic_vector(p_SIZE-1 downto 0));
  end component;
  
  component PC is 
    generic (p_SIZE : natural :=  32);
    port(i_Rst     : in  std_logic; 
         i_Clk     : in  std_logic;
         i_nextPC  : in  std_logic_vector(p_SIZE-1 downto 0);
         o_PC      : out std_logic_vector(p_SIZE-1 downto 0));
  end component;
  
  component Shift_Left_2_32bits is
    port(i_A  : in  std_logic_vector(31 downto 0);
         o_R  : out std_logic_vector(31 downto 0));
       
  end component;
  
  component Shift_Left_26_to_28 is
    port(i_A  : in  std_logic_vector(25 downto 0);
         o_R  : out std_logic_vector(27 downto 0));
       
  end component;
  
  component mux2x1_32bits is
    generic (p_WIDTH : natural := 32);                                -- data width
    port (i_SEL  : in  std_logic;	                                    -- selector
          i_DIN0 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 1
          i_DIN1 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 2
          o_DOUT : out std_logic_vector (p_WIDTH-1 downto 0));        -- data output
	 
  end component; 
  
  component mux2x1_5bits is
    generic (p_WIDTH : natural := 5);                                 -- data width
    port (i_SEL  : in  std_logic;	                                    -- selector
          i_DIN0 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 1
          i_DIN1 : in  std_logic_vector (p_WIDTH-1 downto 0);         -- data input 2
          o_DOUT : out std_logic_vector (p_WIDTH-1 downto 0));        -- data output
     
  end component;
  
  component ALU is 
    port(i_A  : in  std_logic_vector(31 downto 0);
         i_B  : in  std_logic_vector(31 downto 0);
         i_Op : in  std_logic_vector(3 downto 0);
         o_S  : out std_logic_vector(31 downto 0);
         o_Z  : out std_logic);                                                    -- Controle de desvio
    
  end component;
  
  component Data_Memory is
    port(i_Clk       : in std_logic;
         i_Enable    : in std_logic;  
         i_Addr      : in  std_logic_vector(31 downto 0);
         i_Din       : in  std_logic_vector(31 downto 0);
         o_Dout      : out std_logic_vector(31 downto 0));
   
  end component;
  
  component Register_File is
    port(i_Clk       : in  std_logic;
         i_Enable    : in  std_logic;
         i_Rst       : in  std_logic;   
         i_Addr_rd_1 : in  std_logic_vector(4  downto 0);
         i_Addr_rd_2 : in  std_logic_vector(4  downto 0); 
         i_Addr_wr   : in  std_logic_vector(4  downto 0);
         i_Din       : in  std_logic_vector(31 downto 0);
         o_Dout_1    : out std_logic_vector(31 downto 0);
         o_Dout_2    : out std_logic_vector(31 downto 0));
         
  end component;
    
  component Sign_Extend_16_to_32 is
    port(i_A   : in  std_logic_vector(15 downto 0);
         o_R   : out std_logic_vector(31 downto 0));

  end component;
  
  component Instruction_Memory is 
    generic (p_SIZE : natural :=  32);
    port(i_PC_Addr 	: in std_logic_vector(p_SIZE-1 downto 0);
         i_Clk 			: in std_logic;
         o_Inst	    : out std_logic_vector(p_SIZE-1 downto 0));
  end component;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WIRES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  signal w_Next_PC                : std_logic_vector(31 downto 0);
  signal w_PC                     : std_logic_vector(31 downto 0);
  signal w_Inst                   : std_logic_vector(31 downto 0);                                     --atribuir o valor ao o_Op
  signal w_Opcode                 : std_logic_vector(5  downto 0);
  signal w_RS                     : std_logic_vector(4  downto 0);
  signal w_RT                     : std_logic_vector(4  downto 0);
  signal w_RD                     : std_logic_vector(4  downto 0);
  signal w_Immediate              : std_logic_vector(15 downto 0);
  signal w_Offset                 : std_logic_vector(25 downto 0);
  signal w_Funct                  : std_logic_vector(5  downto 0);                                  
  signal w_PC_plus_4              : std_logic_vector(31 downto 0);
  signal w_Address_Jump           : std_logic_vector(31 downto 0);
  signal w_SL_Offset              : std_logic_vector(27 downto 0);
  signal w_PC_Conc_Offset         : std_logic_vector(31 downto 0);
  signal w_Mux_RT                 : std_logic_vector(4  downto 0);
  
  
  signal w_ALU_Z          : std_logic;
  signal w_Verif_Branch   : std_logic;
  signal w_Data1          : std_logic_vector(31 downto 0);
  signal w_Data2          : std_logic_vector(31 downto 0);
  signal w_Immediate_Ext  : std_logic_vector(31 downto 0);
  signal w_Mux_ALU_B      : std_logic_vector(31 downto 0);
  signal w_ALU_Result     : std_logic_vector(31 downto 0);
  signal w_Data_Mem       : std_logic_vector(31 downto 0);
  signal w_Mux_RF         : std_logic_vector(31 downto 0);
  signal w_SL_Immediate   : std_logic_vector(31 downto 0);
  signal w_Addr_Jump      : std_logic_vector(31 downto 0);
  signal w_Mux_Next_PC    : std_logic_vector(31 downto 0);  

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin

  w_Opcode                      <= w_Inst(31 downto 26);	
  w_RS    	                    <= w_Inst(25 downto 21);
  w_RT 		 	                    <= w_Inst(20 downto 16);
  w_RD 		 	                    <= w_Inst(15 downto 11);
  w_Funct                       <= w_Inst(5  downto 0);
  w_Immediate                   <= w_Inst(15 downto 0);
  w_Offset                      <= w_Inst(25 downto 0);
  w_verif_Branch                <= w_ALU_Z and i_Branch;
  w_Address_Jump(31 downto 28)  <= w_PC_plus_4(31 downto 28);
  w_Address_Jump(27 downto 0)   <= w_SL_Offset(27 downto 0);
  
  u_PC : PC port map(i_Rst     =>  i_Rst,
                     i_Clk     =>  i_Clk,
                     i_nextPC  =>  w_Next_PC,
                     o_PC      =>  w_PC);
  
  u_Add_PC_Plus_4 : Add port map(i_A  => w_PC,
                                 i_B  => x"00000004",
                                 o_R  => w_PC_plus_4);
  
  u_Shift_Left_2_32bits : Shift_Left_2_32bits port map(i_A  => w_Immediate_Ext,
                                                       o_R  => w_SL_Immediate);

  
  u_Shift_Left_26_to_28 : Shift_Left_26_to_28 port map(i_A  => w_Offset,
                                                       o_R  => w_SL_Offset);
  
  u_Mux1_Next_PC : Mux2x1_32bits port map(i_SEL  => w_verif_Branch,
                                          i_DIN1 => w_Addr_Jump,
                                          i_DIN0 => w_PC_plus_4, 
                                          o_DOUT => w_Mux_Next_PC);
                                          
  u_Mux2_Next_PC : Mux2x1_32bits port map(i_SEL  => i_Jump,
                                          i_DIN1 => w_Address_Jump,
                                          i_DIN0 => w_Mux_Next_PC, 
                                          o_DOUT => w_next_PC);    
       
  u_Add_Addr_Jump : Add port map(i_A  => w_PC_plus_4,
                                 i_B  => w_SL_Immediate,
                                 o_R  => w_Addr_Jump);    
                              
  u_Mux_ALU_B : Mux2x1_32bits port map(i_SEL  => i_ALUSrc,
                                       i_DIN1 => w_Immediate_Ext,
                                       i_DIN0 => w_Data2, 
                                       o_DOUT => w_Mux_ALU_B);
  
  u_ALU : ALU port map(i_A  => w_Data1,
                       i_B  => w_Mux_ALU_B,
                       i_Op => i_ALUOp,
                       o_S  => w_ALU_Result,
                       o_Z  => w_ALU_Z);  
  
  u_Mux_Addr_Wr : Mux2x1_5bits port map(i_SEL  => i_RegDst,
                                        i_DIN0 => w_RT,
                                        i_DIN1 => w_RD,
                                        o_DOUT => w_Mux_RT);
  
  u_Mux_Register_File : Mux2x1_32bits port map(i_SEL  => i_MemToReg,
                                               i_DIN1 => w_Data_Mem,
                                               i_DIN0 => w_ALU_Result, 
                                               o_DOUT => w_Mux_RF);
                                           
  u_Sign_Extend : Sign_Extend_16_to_32 port map(i_A   => w_Immediate,
                                                o_R   => w_Immediate_Ext);
  
  u_Data_Memory : Data_Memory port map(i_Clk       => i_Clk,
                                       i_Enable    => i_MemWrite,                                           
                                       i_Addr      => w_ALU_Result,
                                       i_Din       => w_Data2,
                                       o_Dout      => w_Data_Mem);  
  
  u_Register_File : Register_File port map(i_Clk       => i_Clk,
                                           i_Enable    => i_RegWrite,
                                           i_Rst       => i_Rst,
                                           i_Addr_rd_1 => w_RS,
                                           i_Addr_rd_2 => w_RT,
                                           i_Addr_wr   => w_Mux_RT,
                                           i_Din       => w_Mux_RF,
                                           o_Dout_1    => w_Data1,
                                           o_Dout_2    => w_Data2);     
  
  u_Instruction_Memory : Instruction_Memory port map(i_PC_Addr 	=> w_PC,
                                                     i_Clk 			=> i_Clk,
                                                     o_Inst	    => w_Inst);
  o_Funct    <= w_Funct;
  o_OP       <= w_Opcode;
  o_Data_Mem <= w_Data_Mem;
  
  
end arch1;