-- Listing 4.13
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity disp_mux is
   port(
      clk: in std_logic;
      in3, in2, in1, in0: in std_logic_vector(6 downto 0);
      point: in std_logic;
      colon: in std_logic;
      an: out std_logic_vector(3 downto 0);
      sseg: out std_logic_vector(7 downto 0)
   );
end disp_mux ;

architecture arch of disp_mux is
   -- refreshing rate around 800 Hz (50MHz/2^16)
   constant N: integer:= 18;
   signal q_reg: unsigned(N-1 downto 0);
   signal sel: std_logic_vector(1 downto 0);
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
                an <= "1110";
                sseg <= '1' & not in3;
             when "01" =>
                an <= "1101";
                sseg <= '1' & not in2;
             when "10" =>
                an <= "1011";
                sseg <= not colon & not in1;
             when others =>
                an <= "0111";
                sseg <= not point & not in0;
          end case;
      end if;
   end process;
end arch;