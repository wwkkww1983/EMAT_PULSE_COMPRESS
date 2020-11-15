# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "IDLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POWER_CHARGE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TOP_TR" -parent ${Page_0}


}

proc update_PARAM_VALUE.HV_CLOSE_DELAY { PARAM_VALUE.HV_CLOSE_DELAY } {
	# Procedure called to update HV_CLOSE_DELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HV_CLOSE_DELAY { PARAM_VALUE.HV_CLOSE_DELAY } {
	# Procedure called to validate HV_CLOSE_DELAY
	return true
}

proc update_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to update IDLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to validate IDLE
	return true
}

proc update_PARAM_VALUE.POWER_CHARGE { PARAM_VALUE.POWER_CHARGE } {
	# Procedure called to update POWER_CHARGE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POWER_CHARGE { PARAM_VALUE.POWER_CHARGE } {
	# Procedure called to validate POWER_CHARGE
	return true
}

proc update_PARAM_VALUE.TOP_TR { PARAM_VALUE.TOP_TR } {
	# Procedure called to update TOP_TR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TOP_TR { PARAM_VALUE.TOP_TR } {
	# Procedure called to validate TOP_TR
	return true
}


proc update_MODELPARAM_VALUE.IDLE { MODELPARAM_VALUE.IDLE PARAM_VALUE.IDLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IDLE}] ${MODELPARAM_VALUE.IDLE}
}

proc update_MODELPARAM_VALUE.POWER_CHARGE { MODELPARAM_VALUE.POWER_CHARGE PARAM_VALUE.POWER_CHARGE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POWER_CHARGE}] ${MODELPARAM_VALUE.POWER_CHARGE}
}

proc update_MODELPARAM_VALUE.TOP_TR { MODELPARAM_VALUE.TOP_TR PARAM_VALUE.TOP_TR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TOP_TR}] ${MODELPARAM_VALUE.TOP_TR}
}

proc update_MODELPARAM_VALUE.HV_CLOSE_DELAY { MODELPARAM_VALUE.HV_CLOSE_DELAY PARAM_VALUE.HV_CLOSE_DELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HV_CLOSE_DELAY}] ${MODELPARAM_VALUE.HV_CLOSE_DELAY}
}

