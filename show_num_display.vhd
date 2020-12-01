----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2020 19:32:59
-- Design Name: 
-- Module Name: show_num_display - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL; 

--This module shows a binary number on a 4 digits BCD panel
--It receives a 14 bits binary number (to represent the maximum value, 9999, on the panel).

--The module translate the binary combination to 4 BCD combination and, using a BCD decoder as intermediary,
--pass each number to the BCD panel to be show in its displays.

--Each BCD combination is passed to a BCD-7s decoder, which return the 7 segments combination for passing
--to the display controller

entity show_num_display is
    Port ( num: in std_logic_vector(13 downto 0); --binary number to be shown in the BCD panel
           clk : in STD_LOGIC; --clk, for synchronization with the BCD panel
           an: out std_logic_vector(3 downto 0); --display selector, for BCD panel controller
           sseg : out STD_LOGIC_VECTOR (7 downto 0)); --7 segments output, for BCD panel controller
end show_num_display;


architecture Behavioral of show_num_display is

    --BCD to 7 segments decoder
    component decoder_bcd_7s is
        Port ( binary_num : in STD_LOGIC_VECTOR (3 downto 0);
               bcd_7s_value : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    --BCD panel controller
    component disp_mux is
       port(
          clk: in std_logic;
          in3, in2, in1, in0: in std_logic_vector(6 downto 0);
          point: in std_logic;
          colon: in std_logic;
          an: out std_logic_vector(3 downto 0);
          sseg: out std_logic_vector(7 downto 0)
       );
    end component;
    
    
    --Function to translate the binary combination into 4 BCD combinations (4 bits each),
    --using Double Dabble algorithm
    --Receives as input the binary combination to translate (14 bits, to fill all the displays)
    --Returns a 16 bit vector, with 4 bits for each BCD combination
    
    --Based in code snippets from https://vhdlguru.blogspot.com/2010/04/8-bit-binary-to-bcd-converter-double.html
    --and https://stackoverflow.com/questions/39548841/16bit-to-bcd-conversion
    
    function to_bcd ( bin : std_logic_vector(13 downto 0) ) return std_logic_vector is        
        variable bcd:   std_logic_vector (15 downto 0); --bcd vector, with 4 bits for each display
        variable bint:  std_logic_vector (13 downto 0); --auxiliary vector, to copy the input and operate with It
        
    begin
        bcd := (others => '0');      -- ADDED for EVERY CONVERSION
        bint := bin(13 downto 0); -- ADDED for EVERY CONVERSION
    
        for i in 0 to 13 loop
        
            --bit shifting. Copy the bint MSB in the bcd LSB
            bcd(15 downto 0) := bcd(14 downto 0) & bint(13);
            bint(13 downto 0) := bint(12 downto 0) & '0';

            if i < 13 and bcd(3 downto 0) > "0100" then
                bcd(3 downto 0) := 
                    std_logic_vector (unsigned(bcd(3 downto 0)) + 3);
            end if;
            if i < 13 and bcd(7 downto 4) > "0100" then
                bcd(7 downto 4) := 
                    std_logic_vector(unsigned(bcd(7 downto 4)) + 3);
            end if;
            if i < 13 and bcd(11 downto 8) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(11 downto 8)) + 3);
            end if;
            if i < 13 and bcd(15 downto 12) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(15 downto 12)) + 3);
            end if;
            
        end loop;
        return std_logic_vector(bcd(15 downto 0));
    end to_bcd;
    
    --7 segments inputs for each display, for the BCD panel controller
    signal in3, in2, in1, in0: std_logic_vector(6 downto 0);
    
    --bcd_combinations_vector, returned by the Binary-BCD translator
    signal bcd_num_full: std_logic_vector(15 downto 0);
    
    --bcd combinations for each display, for the BCD-7s decoder
    signal bcd_num1, bcd_num2, bcd_num3, bcd_num4: std_logic_vector(3 downto 0);
    
    --full binary number. Copy of the num input, with the 14-bit binary input
    --defined for ease modifications of some bit ranges, for invert the buttons range
    --CURRENTLY WITHOUT USE
    signal num_full: std_logic_vector(13 downto 0) := num;
begin

    --The buttons of ZXDOS using low-level logic, so it's necessary to invert their inputs
--    num_full(13 downto 8) <= not num(13 downto 8);
--    num_full(7 downto 0) <= num(7 downto 0);

    --7 segment decoder for display 3. Receives as input the first BCD combination, 
    --calculate by the Double Dabble algorithm. Output the 7 segment combination for the display.
    decoder3: decoder_bcd_7s port map(binary_num => bcd_num4,
                                     bcd_7s_value => in3);
    
    --7 segment decoder for display 2.                                  
    decoder2: decoder_bcd_7s port map(binary_num => bcd_num3,
                                     bcd_7s_value => in2);
    
    --7 segment decoder for display 1                                 
    decoder1: decoder_bcd_7s port map(binary_num => bcd_num2,
                                     bcd_7s_value => in1);
    
    
    --7 segment decoder for display 0                             
    decoder0: decoder_bcd_7s port map(binary_num => bcd_num1,
                                     bcd_7s_value => in0);
    
    --BCD panel controller                             
    display: disp_mux port map(clk => clk, --clk
                               in3 => in3, --7 segment combination for display 3
                               in2 => in2, --7 segment combination for display 2
                               in1 => in1, --7 segment combination for display 1
                               in0 => in0, --7 segment combination for display 0
                               point => '0', --point (disabled)
                               colon => '0', --colon (disabled)
                               an => an, --display selector (set by the controller)
                               sseg => sseg); --7 segment input for display selected (set by the controller)
    
    --This process calls to "to_bcd()" function to get the BCD combination for the binary input
    --After this, assign the values to BCD signals, as inputs for the BCD-7s decoder
    
    --To avoid desynchronization problems, the binary-BCD translation, and the BCD input assignation
    --will be done in synchronous mode.
    process(clk)
    begin
        if rising_edge(clk) then
          bcd_num_full <= to_bcd(num_full); --call to binary-BCD translator
          bcd_num1 <= bcd_num_full(15 downto 12); --assignation for BCD display 1
          bcd_num2 <= bcd_num_full(11 downto 8); --assignation for BCD display 2
          bcd_num3 <= bcd_num_full(7 downto 4); --assignation for BCD display 3
          bcd_num4 <= bcd_num_full(3 downto 0); --assignation for BCD display 4
        end if;
    end process;

end Behavioral;
