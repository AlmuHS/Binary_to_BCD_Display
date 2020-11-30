# Binary_to_BCD_Display
Project to show in a BCD display a value set in binary 


## Introduction

This project shows in a 4 digits BCD 7-segments display, the number introduced by the inputs (currently, a list of switches) in binary natural

By example, if you write "10001", the display will shows 0 0 1 7.

## Boards

This project is written for the QMTech Artix-7 SDRAM Board, with a XC7A35T FPGA model. The BCD Display and the switches are provide by a ZXDOS module (http://www.forofpga.es/viewtopic.php?f=36&p=893#p893)

## Some annotations

The ZXDOS module use a low-level logic, in which the enabling using "0" instead "1". By this reason, some inputs are inverted before connect to the display



 