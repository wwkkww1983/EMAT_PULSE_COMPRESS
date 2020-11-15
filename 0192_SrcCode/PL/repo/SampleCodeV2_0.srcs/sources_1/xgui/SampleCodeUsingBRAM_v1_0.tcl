# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FIRST_WR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IDLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SECOND_WR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WR_DONE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WR_WAITING" -parent ${Page_0}


}

proc update_PARAM_VALUE.FIRST_WR { PARAM_VALUE.FIRST_WR } {
	# Procedure called to update FIRST_WR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIRST_WR { PARAM_VALUE.FIRST_WR } {
	# Procedure called to validate FIRST_WR
	return true
}

proc update_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to update IDLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to validate IDLE
	return true
}

proc update_PARAM_VALUE.SECOND_WR { PARAM_VALUE.SECOND_WR } {
	# Procedure called to update SECOND_WR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SECOND_WR { PARAM_VALUE.SECOND_WR } {
	# Procedure called to validate SECOND_WR
	return true
}

proc update_PARAM_VALUE.WR_DONE { PARAM_VALUE.WR_DONE } {
	# Procedure called to update WR_DONE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WR_DONE { PARAM_VALUE.WR_DONE } {
	# Procedure called to validate WR_DONE
	return true
}

proc update_PARAM_VALUE.WR_WAITING { PARAM_VALUE.WR_WAITING } {
	# Procedure called to update WR_WAITING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WR_WAITING { PARAM_VALUE.WR_WAITING } {
	# Procedure called to validate WR_WAITING
	return true
}


proc update_MODELPARAM_VALUE.IDLE { MODELPARAM_VALUE.IDLE PARAM_VALUE.IDLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IDLE}] ${MODELPARAM_VALUE.IDLE}
}

proc update_MODELPARAM_VALUE.FIRST_WR { MODELPARAM_VALUE.FIRST_WR PARAM_VALUE.FIRST_WR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIRST_WR}] ${MODELPARAM_VALUE.FIRST_WR}
}

proc update_MODELPARAM_VALUE.WR_WAITING { MODELPARAM_VALUE.WR_WAITING PARAM_VALUE.WR_WAITING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WR_WAITING}] ${MODELPARAM_VALUE.WR_WAITING}
}

proc update_MODELPARAM_VALUE.SECOND_WR { MODELPARAM_VALUE.SECOND_WR PARAM_VALUE.SECOND_WR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SECOND_WR}] ${MODELPARAM_VALUE.SECOND_WR}
}

proc update_MODELPARAM_VALUE.WR_DONE { MODELPARAM_VALUE.WR_DONE PARAM_VALUE.WR_DONE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WR_DONE}] ${MODELPARAM_VALUE.WR_DONE}
}

