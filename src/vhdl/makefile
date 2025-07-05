ifeq ($(LANG),)
GHDL_PREFIX=c:/lib/ghdl/
PATH:=$(PATH):../../../oss_cad-suite/bin
else
GHDL_PREFIX=../../../oss-cad-suite/lib/ghdl/
PATH:=$(PATH):../../../oss-cad-suite/bin
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

all: synth route

monitor:
	-../tools/monitor.exe /dev/ttyUSB1 
	-../tools/monitor.exe 'COM6'

synth:
	ghdl -i --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) -Pbuild $(VHDL_SRC)
	ghdl -m --PREFIX=$(GHDL_PREFIX) --warn-no-binding --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) $(TOP)
	ghdl synth --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit --work=$(TOP) --out=verilog $(TOP) > $(TOP)_vhd.v
	yosys -ql synth.log -p 'read_verilog -defer -sv plasma_top.v TMDS_rPLL.v gowin_rpll.v $(TOP)_vhd.v sdram.v; synth_gowin -top plasma_top -family gw2a -json $(TOP)_v.json'

route:
	nextpnr-himbaechel --json $(TOP)_v.json \
		--write $(TOP).json \
		--device "GW2AR-LV18QN88C8/I7" \
		--vopt family=GW2A-18C \
		--vopt cst=tangnano20k.cst
	#	--vopt allow-unconstrained 
	gowin_pack --device GW2A-18C $(TOP).json --output $(TOP)_bit.fs

flash:
	openFPGALoader -b tangnano20k -f $(TOP)_bit.fs

sim:
	ghdl -a --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit $(VHDL_SRC) tbench.vhd
	ghdl -e --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit tbench 
	ghdl -r --PREFIX=$(GHDL_PREFIX) --ieee=synopsys -fsynopsys -fexplicit tbench --vcd=$(TOP).vcd --stop-time=1us
	gtkwave $(TOP).vcd

clean:
	$(RM) $(TOP)_vhd.v
	$(RM) $(TOP).json
	$(RM) $(TOP).vcd
	$(RM) $(TOP)_bit.fs
	$(RM) $(TOP)_v.json
	$(RM) $(TOP)*.cf
	$(RM) $(TOP)
	$(RM) *.o
	$(RM) synth.log


