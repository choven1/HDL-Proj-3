#  VGAStart_Basys3Pins.xdc
#  UW EE 4490 
#  Adapted from original code by Jerry C. Hamann
#  Derived from master XDC file provided for Basys3 rev B board by Digilent Inc.

## Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK_100MHz]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK_100MHz]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK_100MHz]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#
## Switches
#SW0
set_property PACKAGE_PIN V17 [get_ports {Reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Reset}]
	
## Buttons
# BTNC
    set_property PACKAGE_PIN U18 [get_ports {Go}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {Go}]
# BTNU
    set_property PACKAGE_PIN T18 [get_ports {Up}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {Up}]
# BTNR
    set_property PACKAGE_PIN T17 [get_ports {Right}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {Right}]
# BTND
    set_property PACKAGE_PIN U17 [get_ports {Down}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {Down}]
# BTNL
    set_property PACKAGE_PIN W19 [get_ports {Left}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {Left}]
 
##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {RED[0]}]				
    set_property IOSTANDARD LVCMOS33 [get_ports {RED[0]}]
set_property PACKAGE_PIN H19 [get_ports {RED[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[1]}]
set_property PACKAGE_PIN J19 [get_ports {RED[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[2]}]
set_property PACKAGE_PIN N19 [get_ports {RED[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {RED[3]}]
set_property PACKAGE_PIN N18 [get_ports {BLUE[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[0]}]
set_property PACKAGE_PIN L18 [get_ports {BLUE[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[1]}]
set_property PACKAGE_PIN K18 [get_ports {BLUE[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[2]}]
set_property PACKAGE_PIN J18 [get_ports {BLUE[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[3]}]
set_property PACKAGE_PIN J17 [get_ports {GREEN[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[0]}]
set_property PACKAGE_PIN H17 [get_ports {GREEN[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[1]}]
set_property PACKAGE_PIN G17 [get_ports {GREEN[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[2]}]
set_property PACKAGE_PIN D17 [get_ports {GREEN[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[3]}]
set_property PACKAGE_PIN P19 [get_ports HS]						
	set_property IOSTANDARD LVCMOS33 [get_ports HS]
set_property PACKAGE_PIN R19 [get_ports VS]						
	set_property IOSTANDARD LVCMOS33 [get_ports VS]

# End of VGAStart_Basys3Pins.xdc
