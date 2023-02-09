
filename="hydra-vivado/hydra-vivado.srcs/sim_1/new/program.mem"
with open(filename,'r') as fl:
    hex_lines=fl.read().splitlines()
    bin_line_splits=[]
    for hex_line in hex_lines:
        bin_line=bin(int(hex_line, 16))[2:].zfill(32)
        bin_line_split=bin_line[0:7]+' '+bin_line[7:12]+' '+bin_line[12:17]+' '+bin_line[17:20]+' '+bin_line[20:25]+' '+bin_line[25:32]
        bin_line_splits.append(bin_line_split)

    bin_line_splits.append('f7      rs2   rs1   f3  rd    op')

    print(*bin_line_splits,sep='\n',end='')
    with open(filename[:-3]+'bin','w') as flw:
        flw.write('\n'.join(bin_line_splits)) 