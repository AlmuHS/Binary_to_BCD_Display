-- Listing 4.13
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--This is a code to control a multiplexed BCD panel, with 4 display, 
--based in the code from http://www.forofpga.es/viewtopic.php?p=893#p893

--In a multiplexed panel, only a display can be shown as a time.
--The display to enable will be selected by "an" signal, and the segments to turn on will be set in "sseg" signal.

--To show values in all displays, the controller will iterate between all BCD display each few clock cicles.
--To do this, it's necessary to know the value to show in its display. These values will be set in "in*" signals, one for each display.

--The panel is connected using low-level logic, so the inputs must be inverted before connect

entity disp_mux is
   port(
      clk: in std_logic; --clk, needed for synchronization
      in3, in2, in1, in0: in std_logic_vector(6 downto 0); --7 segment inputs for each digit
      point: in std_logic; --enable the point of the first digit, to simulate the decimal point
      colon: in std_logic; --enable the point of the second digit, to simulate decimal colon
      an: out std_logic_vector(3 downto 0); --digit selector
      sseg: out std_logic_vector(7 downto 0) --7 segments output, to show in the digit selected by "an"
   );
end disp_mux ;

architecture arch of disp_mux is
   -- refreshing rate around 800 Hz (50MHz/2^16)
   constant N: integer:= 18;
   signal q_reg: unsigned(N-1 downto 0);
   signal sel: std_logic_vector(1 downto 0); --signal to select the digit to enable
begin
   -- register
   process(clk)
   begin
      if (rising_edge(clk)) then
        q_reg <= q_reg+1;
      end if;
   end process;

   -- 2 MSBs of counter to control 4-to-1 multiplexing
   -- and to generate active-low enable signal
   sel <= std_logic_vector(q_reg(N-1 downto N-2));
   process(clk, sel,in3,colon,point)
   begin
      if rising_edge(clk) then
          case sel is
             when "00" =>
                an <= "1110"; --display3
                sseg <= '1' & not in3;
             when "01" =>
                an <= "1101"; --display2
                sseg <= '1' & not in2;
             when "10" =>
                an <= "1011"; --display1
                sseg <= not colon & not in1;
             when others =>
                an <= "0111"; --display0
                sseg <= not point & not in0;
          end case;
      end if;
   end process;
end arch;