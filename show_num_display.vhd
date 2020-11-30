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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity show_num_display is
    Port ( num : in STD_LOGIC_VECTOR (13 downto 0);
           clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           sseg : out STD_LOGIC_VECTOR (7 downto 0));
end show_num_display;


architecture Behavioral of show_num_display is

    component decoder_bcd_7s is
        Port ( binary_num : in STD_LOGIC_VECTOR (3 downto 0);
               bcd_7s_value : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

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
    
    
    function to_bcd ( bin : std_logic_vector(13 downto 0) ) return std_logic_vector is
        variable i : integer:=0;
        variable bcd : std_logic_vector(15 downto 0) := (others => '0'); --4 bits/display
        variable bint : std_logic_vector(13 downto 0) := bin; --The number of bits needed to fill 4 BCD display (max value 9999)
        
    begin
        for i in 0 to 13 loop  -- repeating 13 times.
            bcd(15 downto 1) := bcd(14 downto 0);  --shifting the bits.
            bcd(0) := bint(13);
            bint(13 downto 1) := bint(12 downto 0);
            bint(0) :='0';
            
            if(i < 7 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
                bcd(3 downto 0) := bcd(3 downto 0) + "0011";
            end if;
            
            if(i < 7 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
                bcd(7 downto 4) := bcd(7 downto 4) + "0011";
            end if;
            
            if(i < 7 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
                bcd(11 downto 8) := bcd(11 downto 8) + "0011";
            end if;
            
            if(i < 7 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
                bcd(15 downto 12) := bcd(15 downto 12) + "0011";
            end if;
        end loop;
        return bcd;
    end to_bcd;
    
    signal in3, in2, in1, in0: std_logic_vector(6 downto 0);
    signal bcd_num_full: std_logic_vector(15 downto 0);
    signal bcd_num1, bcd_num2, bcd_num3, bcd_num4: std_logic_vector(3 downto 0);
begin

    decoder3: decoder_bcd_7s port map(binary_num => bcd_num4,
                                     bcd_7s_value => in3);
                                     
    decoder2: decoder_bcd_7s port map(binary_num => bcd_num3,
                                     bcd_7s_value => in2);
                                     
    decoder1: decoder_bcd_7s port map(binary_num => bcd_num2,
                                     bcd_7s_value => in1);
                                     
    decoder0: decoder_bcd_7s port map(binary_num => bcd_num1,
                                     bcd_7s_value => in0);
                                 
    display: disp_mux port map(clk => clk,
                               in3 => in3,
                               in2 => in2,
                               in1 => in1,
                               in0 => in0,
                               point => '0',
                               colon => '0',
                               an => an,
                               sseg => sseg);
   

    bcd_num_full <= to_bcd(num);

    process(clk)
    begin
        if rising_edge(clk) then
          bcd_num1 <= bcd_num_full(15 downto 12); 
          bcd_num2 <= bcd_num_full(11 downto 8);
          bcd_num3 <= bcd_num_full(7 downto 4);
          bcd_num4 <= bcd_num_full(3 downto 0);
        end if;
    end process;

end Behavioral;
