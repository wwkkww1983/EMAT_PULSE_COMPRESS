# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  ipgui::add_param $IPINST -name "BI_PHASE_CODE_COMP"
  ipgui::add_param $IPINST -name "CODE_LENGTH"
  ipgui::add_param $IPINST -name "CLK_DIV"
  ipgui::add_param $IPINST -name "BI_PHASE_CODE"

}

proc update_PARAM_VALUE.BI_PHASE_CODE { PARAM_VALUE.BI_PHASE_CODE } {
	# Procedure called to update BI_PHASE_CODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BI_PHASE_CODE { PARAM_VALUE.BI_PHASE_CODE } {
	# Procedure called to validate BI_PHASE_CODE
	return true
}

proc update_PARAM_VALUE.BI_PHASE_CODE_COMP { PARAM_VALUE.BI_PHASE_CODE_COMP } {
	# Procedure called to update BI_PHASE_CODE_COMP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BI_PHASE_CODE_COMP { PARAM_VALUE.BI_PHASE_CODE_COMP } {
	# Procedure called to validate BI_PHASE_CODE_COMP
	return true
}

proc update_PARAM_VALUE.CLK_DIV { PARAM_VALUE.CLK_DIV } {
	# Procedure called to update CLK_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_DIV { PARAM_VALUE.CLK_DIV } {
	# Procedure called to validate CLK_DIV
	return true
}

proc update_PARAM_VALUE.CODE_LENGTH { PARAM_VALUE.CODE_LENGTH } {
	# Procedure called to update CODE_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CODE_LENGTH { PARAM_VALUE.CODE_LENGTH } {
	# Procedure called to validate CODE_LENGTH
	return true
}

proc update_PARAM_VALUE.TR_DONE { PARAM_VALUE.TR_DONE } {
	# Procedure called to update TR_DONE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TR_DONE { PARAM_VALUE.TR_DONE } {
	# Procedure called to validate TR_DONE
	return true
}

proc update_PARAM_VALUE.TR_ING { PARAM_VALUE.TR_ING } {
	# Procedure called to update TR_ING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TR_ING { PARAM_VALUE.TR_ING } {
	# Procedure called to validate TR_ING
	return true
}

proc update_PARAM_VALUE.TR_WAIT { PARAM_VALUE.TR_WAIT } {
	# Procedure called to update TR_WAIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TR_WAIT { PARAM_VALUE.TR_WAIT } {
	# Procedure called to validate TR_WAIT
	return true
}


proc update_MODELPARAM_VALUE.BI_PHASE_CODE { MODELPARAM_VALUE.BI_PHASE_CODE PARAM_VALUE.BI_PHASE_CODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BI_PHASE_CODE}] ${MODELPARAM_VALUE.BI_PHASE_CODE}
}

proc update_MODELPARAM_VALUE.BI_PHASE_CODE_COMP { MODELPARAM_VALUE.BI_PHASE_CODE_COMP PARAM_VALUE.BI_PHASE_CODE_COMP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BI_PHASE_CODE_COMP}] ${MODELPARAM_VALUE.BI_PHASE_CODE_COMP}
}

proc update_MODELPARAM_VALUE.CODE_LENGTH { MODELPARAM_VALUE.CODE_LENGTH PARAM_VALUE.CODE_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CODE_LENGTH}] ${MODELPARAM_VALUE.CODE_LENGTH}
}

proc update_MODELPARAM_VALUE.CLK_DIV { MODELPARAM_VALUE.CLK_DIV PARAM_VALUE.CLK_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_DIV}] ${MODELPARAM_VALUE.CLK_DIV}
}

proc update_MODELPARAM_VALUE.TR_WAIT { MODELPARAM_VALUE.TR_WAIT PARAM_VALUE.TR_WAIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TR_WAIT}] ${MODELPARAM_VALUE.TR_WAIT}
}

proc update_MODELPARAM_VALUE.TR_DONE { MODELPARAM_VALUE.TR_DONE PARAM_VALUE.TR_DONE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TR_DONE}] ${MODELPARAM_VALUE.TR_DONE}
}

proc update_MODELPARAM_VALUE.TR_ING { MODELPARAM_VALUE.TR_ING PARAM_VALUE.TR_ING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TR_ING}] ${MODELPARAM_VALUE.TR_ING}
}

