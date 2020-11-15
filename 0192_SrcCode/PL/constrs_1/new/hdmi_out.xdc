set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_n]
set_property PACKAGE_PIN N18 [get_ports TMDS_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[0]}]
set_property PACKAGE_PIN V20 [get_ports {TMDS_data_p[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[1]}]
set_property PACKAGE_PIN T20 [get_ports {TMDS_data_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[2]}]
set_property PACKAGE_PIN N20 [get_ports {TMDS_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[2]}]
#set_property PACKAGE_PIN Y19 [get_ports {hdmi_hpd_tri_i[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hdmi_hpd_tri_i[0]}]
set_property PACKAGE_PIN V16 [get_ports hdmi_oen]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_oen]
set_property PACKAGE_PIN R18 [get_ports hdmi_ddc_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_scl_io]
set_property PACKAGE_PIN R16 [get_ports hdmi_ddc_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_sda_io]
#PL_KEYS
#set_property IOSTANDARD LVCMOS33 [get_ports {keys_tri_i[0]}] 
#set_property PACKAGE_PIN N15 [get_ports {keys_tri_i[0]}] 
#KEY_LEFT
set_property IOSTANDARD LVCMOS33 [get_ports {key_left_tri_i[0]}] 
set_property PACKAGE_PIN N15 [get_ports {key_left_tri_i[0]}] 
#KEY_RIGHT
set_property IOSTANDARD LVCMOS33 [get_ports {key_right_tri_i[0]}] 
set_property PACKAGE_PIN T17 [get_ports {key_right_tri_i[0]}] 
#CURRSOR CHANGE
set_property IOSTANDARD LVCMOS33 [get_ports {currsor_change_tri_i[0]}] 
set_property PACKAGE_PIN R17 [get_ports {currsor_change_tri_i[0]}]


####
set_property PACKAGE_PIN F17 [get_ports  ADC_ch1_clk]
set_property PACKAGE_PIN H17 [get_ports  ADC_ch0_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_ch0_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_ch1_clk]

set_property PACKAGE_PIN F16 [get_ports {adc_ch1_data[0]}]
set_property PACKAGE_PIN F20 [get_ports {adc_ch1_data[1]}]
set_property PACKAGE_PIN F19 [get_ports {adc_ch1_data[2]}]
set_property PACKAGE_PIN G20 [get_ports {adc_ch1_data[3]}]
set_property PACKAGE_PIN G19 [get_ports {adc_ch1_data[4]}]
set_property PACKAGE_PIN H18 [get_ports {adc_ch1_data[5]}]
set_property PACKAGE_PIN J18 [get_ports {adc_ch1_data[6]}]
set_property PACKAGE_PIN L20 [get_ports {adc_ch1_data[7]}]
set_property PACKAGE_PIN L19 [get_ports {adc_ch1_data[8]}]
set_property PACKAGE_PIN M20 [get_ports {adc_ch1_data[9]}]
set_property PACKAGE_PIN M19 [get_ports {adc_ch1_data[10]}]
set_property PACKAGE_PIN K18 [get_ports {adc_ch1_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_ch1_data[*]}]
set_property IOB true [get_ports adc_ch1_data[*]]

set_property PACKAGE_PIN H20 [get_ports {adc_ch0_data[1]}]
set_property PACKAGE_PIN J20 [get_ports {adc_ch0_data[0]}]
set_property PACKAGE_PIN L17 [get_ports {adc_ch0_data[3]}]
set_property PACKAGE_PIN L16 [get_ports {adc_ch0_data[2]}]
set_property PACKAGE_PIN M18 [get_ports {adc_ch0_data[5]}]
set_property PACKAGE_PIN M17 [get_ports {adc_ch0_data[4]}]
set_property PACKAGE_PIN D20 [get_ports {adc_ch0_data[7]}]
set_property PACKAGE_PIN D19 [get_ports {adc_ch0_data[6]}]
set_property PACKAGE_PIN E19 [get_ports {adc_ch0_data[9]}]
set_property PACKAGE_PIN E18 [get_ports {adc_ch0_data[8]}]
set_property PACKAGE_PIN G18 [get_ports {adc_ch0_data[11]}]
set_property PACKAGE_PIN G17 [get_ports {adc_ch0_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_ch0_data[*]}]
set_property IOB true [get_ports adc_ch0_data[*]]

set_property PACKAGE_PIN N16 [get_ports  wr_start_first]
set_property IOSTANDARD LVCMOS33 [get_ports wr_start_first]

#set_property PACKAGE_PIN T17 [get_ports  HV_KEY]
#set_property IOSTANDARD LVCMOS33 [get_ports HV_KEY]

set_property PACKAGE_PIN T10 [get_ports  L1]
set_property IOSTANDARD LVCMOS33 [get_ports L1]

set_property PACKAGE_PIN U12 [get_ports  H2]
set_property IOSTANDARD LVCMOS33 [get_ports H2]

set_property PACKAGE_PIN A20 [get_ports  H1]
set_property IOSTANDARD LVCMOS33 [get_ports H1]

set_property PACKAGE_PIN W13 [get_ports  L2]
set_property IOSTANDARD LVCMOS33 [get_ports L2]

set_property PACKAGE_PIN B19 [get_ports  scl]
set_property IOSTANDARD LVCMOS33 [get_ports scl]

set_property PACKAGE_PIN T11 [get_ports  sda]
set_property IOSTANDARD LVCMOS33 [get_ports sda]

set_property PACKAGE_PIN B20 [get_ports  POWER_EN]
set_property IOSTANDARD LVCMOS33 [get_ports POWER_EN]

set_property PACKAGE_PIN W19 [get_ports  HV_EN]
set_property IOSTANDARD LVCMOS33 [get_ports HV_EN]