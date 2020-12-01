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

--This is a decoder BCD to 7 segments
--Return the 7 segments bit string necessary to show the BCD number in the display
--Receive as input the binary number, in natural BCD (4 bits)

entity decoder_bcd_7s is
    Port ( binary_num : in STD_LOGIC_VECTOR (3 downto 0); --BCD number to show
           bcd_7s_value : out STD_LOGIC_VECTOR (6 downto 0)); --7 segments combination
end decoder_bcd_7s;

architecture Behavioral of decoder_bcd_7s is
  
begin
    --This decoder only allows 0-9 values. The rest of combinations will shows an E (error) on the display
    with binary_num select
        bcd_7s_value <= "1111110" when "0000", --0
            "0110000" when "0001", --1
            "1101101" when "0010", --2
            "1111001" when "0011", --3
            "0110011" when "0100", --4
            "1011011" when "0101", --5
            "1011111" when "0110", --6
            "1110000" when "0111", --7
            "1111111" when "1000", --8
            "1111011" when "1001", --9
            "1001111" when others; --E (error), for non BCD values
end Behavioral;
