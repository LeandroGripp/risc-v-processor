# use this command in ModelSim (Altera) to simulate: 
# do tb_script.tcl

if {[file exists work]} {
vdel -lib work -all
}
vlib work

vcom -explicit  -93 "riscV.vhd"
vcom -explicit  -93 "Controller/Controller.vhd"
vcom -explicit  -93 "Datapath/Datapath.vhd"
vcom -explicit  -93 "../Components/Adder_32b/Adder_32b.vhd"
vcom -explicit  -93 "../Components/ALU/ALU.vhd"
vcom -explicit  -93 "../Components/DataMemory/DataMemory.vhd"
vcom -explicit  -93 "../Components/InstructionMemory/InstructionMemory.vhd"
vcom -explicit  -93 "../Components/Mux32b_2x1/Mux32b_2x1.vhd"
vcom -explicit  -93 "../Components/Mux32b_8x1/Mux32b_8x1.vhd"
vcom -explicit  -93 "../Components/PC_REGISTER/PC_REGISTER.vhd"
vcom -explicit  -93 "../Components/RegisterFile/RegisterFile.vhd"
vcom -explicit  -93 "../Components/SigExt/SigExt.vhd"
vcom -explicit  -93 "tb726_riscV.vhd"

vsim -t 1ns   -lib work tb726_riscV
add wave sim:/tb726_riscV/*
#do {wave.do}
view wave
view structure
view signals
run 14400ns
#quit -force
