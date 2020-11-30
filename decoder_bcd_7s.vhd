----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2020 18:57:13
-- Design Name: 
-- Module Name: decoder_bcd_7s - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_bcd_7s is
    Port ( binary_num : in STD_LOGIC_VECTOR (3 downto 0);
           bcd_7s_value : out STD_LOGIC_VECTOR (6 downto 0));
end decoder_bcd_7s;

architecture Behavioral of decoder_bcd_7s is
  
begin
    with binary_num select
        bcd_7s_value <= "1111110" when "0000",
            "0110000" when "0001",
            "1101101" when "0010", 
            "1111001" when "0011",
            "0110011" when "0100",
            "1011011" when "0101",
            "1011111" when "0110",
            "1110000" when "0111",
            "1111111" when "1000",
            "1111011" when "1001",
            "1001111" when others;
end Behavioral;
