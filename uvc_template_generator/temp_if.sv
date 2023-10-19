
interface temp_if #(parameter ADDR = 32, parameter DATA = 32)(input bit system_clock, input bit reset_n);
    
    // * * * Add you specific interface logics below * * *

    task wait_n_clocks(int N);
        // * * * This task is just a blocking function that waits N clock cycles. * * *
        repeat(N) @(posedge system_clock);
    endtask
	
    // * * * You can add assertion checkers bellow * * * 
    

endinterface   
    


