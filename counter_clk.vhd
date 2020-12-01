----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2020 22:27:15
-- Design Name: 
-- Module Name: counter_clk - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Counter designed for QMTech Artix 7 SDRAM Board. Show a counter over a BCD 4 digits display.
-- This board includes a 50 MHz clock. This counter is increased each half second, to be faster.

-- The counter is connected to show num display, which translate the binary number to BCD, and show It in the display

-- The 'an' and 'sseg' values are not set directly in this module. Their values will be set by the display module
-- The counter value is not output directly. Instead, It will be pass as input to the display module.
entity counter_clk is
    Port ( clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           sseg : out STD_LOGIC_VECTOR (7 downto 0)
           );
end counter_clk;

architecture Behavioral of counter_clk is

    --The counter is set in a unsigned signal to be easier to increase It.
    signal counter: unsigned(13 downto 0) := (others => '0');
    
    --The signal num copy the value of the counter, in std_logic_vector format, for passing It to display module 
    signal num: std_logic_vector(13 downto 0) := (others => '0');
    
    --This is a auxiliary counter to divide the clock frequency counting its tics
    signal clk_counter: integer := 0;
    
    -- Instance of display module
    component show_num_display is
    Port ( num : in STD_LOGIC_VECTOR (13 downto 0);
           clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           sseg : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin

    --Connect to BCD display.
    num_display: show_num_display port map(num => num, --current value of the counter
                                           clk => clk, --clk, needed for synchronization with the display
                                           an => an, --The an value will be fill by this module
                                         sseg => sseg); --The sseg value will be fill by this module
    --Counter sequential block
    counter_sequence: process(clk)
    begin
        if rising_edge(clk) then
        
            --increase the clock's tic counter
            clk_counter <= clk_counter + 1;
            
            --due to the clock frecuency is 50 MHz, half second will be 25MHz ~25000000 cicles
            if clk_counter = 25000000 then
                --if the clock reach half second, increase the counter
                counter <= counter + 1;
                
                --restart the clock tic's counter, to count a new half second
                clk_counter <= 0;
            end if;
            
            --Copy the counter value in the num signal for passing to display module
            num <= std_logic_vector(counter);
        end if;
      
    end process;

    

end Behavioral;
