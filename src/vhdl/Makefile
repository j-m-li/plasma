TOOLCHAIN=../../../oss-cad-suite
ifeq ($(LANG),)
GHDL_PREFIX=c:/lib/ghdl/
PATH:=$(PATH):$(TOOLCHAIN)/bin
else
GHDL_PREFIX=$(TOOLCHAIN)/lib/ghdl/
PATH:=$(PATH):$(TOOLCHAIN)/bin
endif

TOP=mlite_cpu
RM=rm -f 
VHDL_SRC = \
	mlite_pack.vhd \
	alu.vhd \
	bus_mux.vhd \
	control.vhd \
	ddr_ctrl.vhd \
	mem_ctrl.vhd \
	mlite_cpu.vhd \
	mult.vhd \
	pc_next.vhd \
	pipeline.vhd \
	plasma.vhd \
	plasma_if.vhd \
	ram.vhd \
	reg_bank.vhd \
	shifter.vhd \
	uart.vhd 

VLOG_SRC= plasma_top_gm.v $(TOP)_vhd.v sdram.v
PRFLAGS= --vopt allow-unconstrained --vopt ccf=gatemate.ccf
IVLFLAGS=-g2012 -gspecify -Ttyp
CELLS_SYNTH= $(TOOLCHAIN)/share/yosys/gatemate/cells_sim.v
CELLS_IMPL=$(TOOLCHAIN)/share/yosys/gatemate/cells_bb.v
 

all: synth route

monitor:
	-../tools/monitor.exe /dev/ttyUSB1 
	-../tools/monitor.exe 'COM6'

synth:
	ghdl -i --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) -Pbuild $(VHDL_SRC)
	ghdl -m --PREFIX=$(GHDL_PREFIX) --warn-no-binding --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) $(TOP)
	ghdl synth --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) --out=verilog $(TOP) > $(TOP)_vhd.v
	yosys -ql synth.log -p 'read_verilog -defer -sv $(VLOG_SRC); synth_gatemate -top $(TOP) -luttree -nomx8 -json $(TOP).json ; write_verilog -norename -noattr $(TOP)_ys.v'

route:
	nextpnr-himbaechel --device CCGM1A1 --json $(TOP).json $(PRFLAGS) --vopt out=$(TOP).txt --router router2 --freq 10 --sdc constraints.sdc --write $(TOP)_pr.json


flash:
	gmpack $(TOP).txt $(TOP).bit
	openFPGALoader -b gatemate_evb_jtag -f --verify $(TOP).bit


sim:
	iverilog $(IVLFLAGS) -D SIM=SIM -o sim.vvp $(VLOG_SRC) soc_tb.v && vvp -N sim.vvp -lx2 && gtkwave soc_tb.vcd config.gtkw

clean:
	$(RM) $(TOP)_vhd.v
	$(RM) $(TOP).json
	$(RM) *.vcd
	$(RM) $(TOP)_bit.fs
	$(RM) $(TOP).bit
	$(RM) $(TOP).txt
	$(RM) $(TOP)_ys.v
	$(RM) output.txt
	$(RM) $(TOP)_pr.json
	$(RM) $(TOP)_v.json
	$(RM) $(TOP)*.cf
	$(RM) $(TOP)
	$(RM) sim.vvp  tbench work-obj93.cf
	$(RM) *.o
	$(RM) synth.log


