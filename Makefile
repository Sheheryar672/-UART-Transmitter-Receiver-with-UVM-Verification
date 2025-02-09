FILELIST = filelist.f

$(FILELIST): 
	@echo "Generating filelist.f"
	@find rtl uvm_tb -name "*.sv" > $(FILELIST)
	@echo "Filelist generated"

compile: $(FILELIST)
	@echo "Compiling all files"
	@vlog -work work -sv -f $(FILELIST)

run_tb: compile
	@echo "Running"
	@vsim -voptargs=+acc -c work.tb -do \
	 "add wave -position insertpoint sim:/tb/dut/*; \
	 add wave -position insertpoint sim:/tb/dut/*; \
	   run -all; quit"

wave: 
	@echo "Displaying waveform"
	@vsim -view vsim.wlf


clean:  
	@rm -rf filelist.f
	@rm -rf work
	@rm -rf transcript
	@rm -rf tr_db.log
	@rm -rf *.vcd
	@rm -rf +acc
	@rm -rd *.wlf
