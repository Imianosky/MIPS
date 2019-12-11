library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Intruction_Memory is

generic (p_SIZE : natural :=  32);
  port(i_PC_Addr 	: in std_logic_vector(p_SIZE-1 downto 0);
       i_Clk 			: in std_logic;
       o_Inst	    : out std_logic_vector(p_SIZE-1 downto 0));
       
end Intruction_Memory;

architecture arch1 of Intruction_Memory is
signal w_Addr : integer;
signal w_AUX  : std_logic_vector(31 downto 0);

type t_Mem is array(p_SIZE-1 downto 0) of std_logic_vector(p_SIZE-1 downto 0);
signal w_Mem : t_Mem := (others=>(others=>'0'));
signal w_PC_Addr : std_logic_vector(4 downto 0);

begin
  w_PC_Addr <= i_PC_ADDR(4 downto 0);
  --ADD, ADDI, SUB:
  --w_Mem(0)<= x"22310004";--addi $s1, $s1, 4
  --w_Mem(1)<= x"22520003";--addi $s2, $s2, 3
  --w_Mem(2)<= x"22730002";--addi $s3, $s3, 2
  --w_Mem(3)<= x"22940001";--addi $s4, $s4, 1
  --w_Mem(4)<= x"02324020";--add $t0, $s1, $s2
  --w_Mem(5)<= x"02744820";--add $t1, $s3, $s4
  --w_Mem(6)<= x"01098022";--sub $s0, $t0, $t1
  
  -- BEQ:
  w_Mem(0) <= x"21290001"; --add $t1, $t1, 1
  w_Mem(1) <= x"20010001"; --beq $t1,1,main
  w_Mem(2) <= x"1029fffd"; 
  w_Mem(3) <= x"200a0002"; --add $t2, $0, 2
  
  -- JUMP: 
  --w_Mem(0) <= x"20100001"; --add $s0, $0, 1
  --w_Mem(1) <= x"08100003"; --j L
  --w_Mem(2) <= x"20100002"; --add $s0, $0, 2
  --w_Mem(3) <= x"20100003"; --add $s0, $0, 3
  
  --SW e LW
  --w_Mem(0) <= x"20090002"; -- addi $t1, $0, 2
  --w_Mem(1) <= x"AC090000"; -- sw $t1, 0($0)
  --w_Mem(2) <= x"8C080000"; -- lw $t0, 0($0)

  --w_AUX <= "00" & i_PC_ADDR(31 downto 2);
  --w_Addr <= (to_integer(unsigned(w_AUX)));
  process (i_Clk)
  begin
	  if(rising_edge(i_Clk)) then
		  o_Inst <= w_Mem(to_integer(unsigned(w_PC_Addr)/4));
		end if;
  end process;
end arch1;