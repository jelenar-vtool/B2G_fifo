xrun top.sv -timescale 1ns/1ns -sysv -access +rw -uvm -seed random -uvmhome CDNS-1.2 +UVM_TESTNAME=temp_rst_test -clean -l temp_rst_test.log +DUMPNAME="temp_rst_test.vcd" +VERBOSITY=UVM_LOW
xrun top.sv -timescale 1ns/1ns -sysv -access +rw -uvm -seed random -uvmhome CDNS-1.2 +UVM_TESTNAME=temp_random_test -clean -l temp_random_test.log +DUMPNAME="temp_random_test.vcd" +VERBOSITY=UVM_LOW 

