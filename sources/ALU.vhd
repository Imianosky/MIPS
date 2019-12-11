-----------------------------------------------------------------------------------------------------------------------------------------------

-- Project: MIPS
-- Authors: Carolina Imianosky and Julia Disner
-- Date: 09/12/2019
-- File: ALU.vhd

-----------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is 

  port(i_A  : in  std_logic_vector(31 downto 0);
       i_B  : in  std_logic_vector(31 downto 0);
       i_Op : in  std_logic_vector(3 downto 0);
       o_S  : out std_logic_vector(31 downto 0);
       o_Z  : out std_logic);                                                    -- Controle de desvio
  
end ALU;

architecture arch1 of ALU is

  signal w_Result : std_logic_vector(31 downto 0);
  
begin
  process (i_A,i_B,i_Op)
  begin
	 
    case i_Op is
     
		  when "0000" =>                                      -- AND 
		    w_Result <= i_A AND i_B;
		  
		  when "0001" =>                                      -- OR 
		    w_Result <= i_A OR i_B;
			 
		  when "0010" =>                                      -- ADD 
		    w_Result <= i_A + i_B;
		  
		  when "0110" =>                                      -- SUB 
		    w_Result <= i_A - i_B;
        
		  when "0111" =>                                      -- SLT 
		    if i_A < i_B then 
          w_Result <= X"00000001";
        else 
          w_Result <= X"00000000";
        end if;
      
      when "1100" =>                                      -- NOR 
        w_Result <= i_A nor i_B;
      
		  when others =>                                      -- Set 0 to w_Result to set the value of Zero output later 
		    w_Result <= x"00000000";
        
		end case;
  end process;
  o_S <= w_Result;
  o_Z <= '1' when w_Result = x"00000000" else '0';                                
end arch1;
