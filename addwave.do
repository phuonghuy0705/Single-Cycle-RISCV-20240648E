vsim work.Single_Cycle_Top_Tb
add wave -label "PC" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/PC_Top
add wave -label "RD" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/Instruction_Memory/RD
add wave -label "RD_Instr" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/RD_Instr
add wave -label "funct3" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/Control_Unit_Top/funct3
add wave -label "funct7" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/Control_Unit_Top/funct7
add wave -label "A1" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A1
add wave -label "A2" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A2
add wave -label "A3" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A3
add wave -label "RD1" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD1
add wave -label "RD2" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD2
add wave -label "WD3" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/WD3
add wave -label "ALUControl" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/ALU/ALUControl
add wave -label "A" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/ALU/A
add wave -label "B" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/ALU/B
add wave -label "Result" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/ALU/Result

add wave -label "RegWrite" /Single_Cycle_Top_Tb/Single_Cycle_Top/RegWrite
add wave -label "MemWrite" /Single_Cycle_Top_Tb/Single_Cycle_Top/MemWrite

run 500ns