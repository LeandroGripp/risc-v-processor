#do tb_script.tcl

if {[file exists work]} {
vdel -lib work -all
}
vlib work
vcom -explicit  -93 "SigExt.vhd"
vcom -explicit  -93 "tb_SigExt.vhd"
vsim -t 1ns   -lib work tb_SigExt
add wave sim:/tb_SigExt/*
#do {wave.do}
view wave
view structure
view signals
run 30ns
#quit -force
