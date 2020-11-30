#========================================================
# clock
#========================================================
#NET "clk"       LOC="N11"  | IOSTANDARD=LVCMOS33;
#create_clock -period 10 -name virtclk #disable for combinational logic
create_clock -name clk50mhz -period 20.000 [get_ports clk]; #clk50MHz
set_property PACKAGE_PIN N11 [get_ports clk];
set_property IOSTANDARD LVCMOS33 [get_ports clk];

#========================================================
# voltage and ground
#========================================================
set_property CFGBVS VCCO [current_design];
set_property CONFIG_VOLTAGE 3.3 [current_design];

#========================================================
# buttons & switches
#========================================================
# 6 push buttons FIXED
#set_property -dict { PACKAGE_PIN B7   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[0] }]; #up right

#set_property -dict { PACKAGE_PIN G4   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[1] }]; #down right
##NET "bot<1>"    LOC="G4"   | IOSTANDARD=LVCMOS33 | PULLUP; #down right

#set_property -dict { PACKAGE_PIN J4   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[2] }]; #1 left 
##NET "bot<2>"    LOC="J4"  | IOSTANDARD=LVCMOS33 | PULLUP; #1 left

#set_property -dict { PACKAGE_PIN A7   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[3] }]; #2 left
##NET "bot<3>"    LOC="A7"  | IOSTANDARD=LVCMOS33 | PULLUP; #2 left

#set_property -dict { PACKAGE_PIN B5  IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[4] }]; #3 left
##NET "bot<4>"    LOC="B5"  | IOSTANDARD=LVCMOS33 | PULLUP; #3 left

#set_property -dict { PACKAGE_PIN K5   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[5] }]; #4 left
##NET "bot<5>"    LOC="K5"  | IOSTANDARD=LVCMOS33 | PULLUP; #4 left

## 8 slide switches FIXED
#set_property -dict { PACKAGE_PIN B2   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[6] }];
##NET "sw<0>"     LOC="B2"  | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN A2   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[7] }];
##NET "sw<1>"     LOC="A2"  | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN C2   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[8] }];
##NET "sw<2>"     LOC="C2"  | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN C4   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[9] }];
##NET "sw<3>"     LOC="C4"   | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN A3   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[10] }];
##NET "sw<4>"     LOC="A3"   | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN A4   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[11] }];
##NET "sw<5>"     LOC="A4"   | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN D5   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[12] }];
##NET "sw<6>"     LOC="D5"   | IOSTANDARD=LVCMOS33 | PULLUP;

#set_property -dict { PACKAGE_PIN C6   IOSTANDARD LVCMOS33 PULLUP TRUE} [get_ports { num[13] }];
#NET "sw<7>"     LOC="C6"   | IOSTANDARD=LVCMOS33 | PULLUP;

#========================================================
# 4-digit time-multiplexed 7-segment LED display
#========================================================
# digit enable FIXED
set_property PACKAGE_PIN F3 [get_ports {an[3]}];			
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}];
#NET "an<0>"     LOC="F3"   | IOSTANDARD=LVCMOS33;

set_property PACKAGE_PIN D1 [get_ports {an[2]}];			
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}];
#NET "an<1>"     LOC="D1"   | IOSTANDARD=LVCMOS33;

set_property PACKAGE_PIN C1 [get_ports {an[1]}];				
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}];
#NET "an<2>"     LOC="C1"   | IOSTANDARD=LVCMOS33;

set_property PACKAGE_PIN F2 [get_ports {an[0]}];					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}];
#NET "an<3>"     LOC="F2"   | IOSTANDARD=LVCMOS33;

# 7-segment led segments  FIXED
set_property PACKAGE_PIN E3 [get_ports {sseg[7]}]; #decimal point				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[7]}];
#NET "sseg<7>"   LOC="E3"   | IOSTANDARD=LVCMOS33; # decimal point

set_property PACKAGE_PIN E2 [get_ports {sseg[6]}]; #segment a				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[6]}];
#NET "sseg<6>"   LOC="E2"   | IOSTANDARD=LVCMOS33; # segment a

set_property PACKAGE_PIN D3 [get_ports {sseg[5]}]; #segment b				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[5]}];
#NET "sseg<5>"   LOC="D3"   | IOSTANDARD=LVCMOS33; # segment b

set_property PACKAGE_PIN E5 [get_ports {sseg[4]}]; #segment c				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[4]}];
#NET "sseg<4>"   LOC="E5"   | IOSTANDARD=LVCMOS33; # segment c

set_property PACKAGE_PIN E1 [get_ports {sseg[3]}]; #segment d				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[3]}];
#NET "sseg<3>"   LOC="E1"   | IOSTANDARD=LVCMOS33; # segment d

set_property PACKAGE_PIN F5 [get_ports {sseg[2]}]; #segment e				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[2]}];
#NET "sseg<2>"   LOC="F5"   | IOSTANDARD=LVCMOS33; # segment e

set_property PACKAGE_PIN B1 [get_ports {sseg[1]}]; #segment f				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[1]}];
#NET "sseg<1>"   LOC="B1"   | IOSTANDARD=LVCMOS33; # segment f

set_property PACKAGE_PIN F4 [get_ports {sseg[0]}]; #segment g				
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[0]}];
#NET "sseg<0>"   LOC="F4"   | IOSTANDARD=LVCMOS33; # segment g

#========================================================
# 8 discrete led
#========================================================
#set_property PACKAGE_PIN B4 [get_ports led1];
#set_property IOSTANDARD LVCMOS33 [get_ports led1];
#NET "led<1>"    LOC="A5"   | IOSTANDARD=LVCMOS33;
#NET "led<2>"    LOC="D6"   | IOSTANDARD=LVCMOS33;
#NET "led<3>"    LOC="C7"   | IOSTANDARD=LVCMOS33;
#NET "led<4>"    LOC="G5"  | IOSTANDARD=LVCMOS33;
#NET "led<5>"    LOC="C11"  | IOSTANDARD=LVCMOS33;
#NET "led<5>"    LOC="J5"  | IOSTANDARD=LVCMOS33;
#NET "led<6>"    LOC="E6"  | IOSTANDARD=LVCMOS33;
#NET "led<7>"    LOC="B6"  | IOSTANDARD=LVCMOS33;
