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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_clk is
    Port ( clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           sseg : out STD_LOGIC_VECTOR (7 downto 0)
           );
end counter_clk;

architecture Behavioral of counter_clk is

    signal counter: unsigned(13 downto 0) := (others => '0');
    signal num: std_logic_vector(13 downto 0) := (others => '0');
    signal clk_counter: integer := 0;
    
    component show_num_display is
    Port ( num : in STD_LOGIC_VECTOR (13 downto 0);
           clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           sseg : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin

    num_display: show_num_display port map(num => num,
                                           clk => clk,
                                           an => an,
                                           sseg => sseg);
    process(clk)
    begin
        if rising_edge(clk) then
            clk_counter <= clk_counter + 1;
            
            if clk_counter = 25000000 then
                counter <= counter + 1;
                clk_counter <= 0;
            end if;
            
            num <= std_logic_vector(counter);
        end if;
      
    end process;

    

end Behavioral;
