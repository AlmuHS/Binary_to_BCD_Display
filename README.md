# Binary_to_BCD_Display
Project to show in a BCD display a value set in binary 


## Introduction

This project shows in a 4 digits BCD 7-segments display, the number introduced by the inputs (currently, a list of switches) in binary natural

By example, if you write "10001", the display will shows 0 0 1 7.

## Boards

This project is written for the QMTech Artix-7 SDRAM Board (Xilinx XC7A35T FPGA). The BCD Display and the switches are provide by a [ZXDOS module](http://www.forofpga.es/viewtopic.php?f=36&p=893)

## Some annotations

The ZXDOS module use a low-level logic, in which the enabling using "0" instead "1". By this reason, some inputs are inverted before connect to the display

## Implementation

This project is based in the code example ["disp_mux.vhd"](http://www.forofpga.es/viewtopic.php?p=893#p893), which allows to control a multiplexed BCD 7-segment display. This code was improved and simplified to ease the syntetizing.

Over this controller, we add two new modules, to implement a BCD to 7-segment decoder for each number, and a Binary to BCD translator.


 