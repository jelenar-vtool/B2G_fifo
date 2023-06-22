`timescale 1ns/100ps

module traffic_lights_tb;

	reg clk, rst_n;
	reg broken;
	wire r_l, y_l, g_l;

	// dump signals to wave file
	initial begin
		$recordsetup("directory = waves");
		$recordfile("dump");
		$recordvars;
	end

	// design under test
	traffic_lights dut (
		.clk(clk),
		.rst_n(rst_n),
		.broken(broken),
		.r_l(r_l),
		.y_l(y_l),
		.g_l(g_l)
	);

	// clock generator
	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end

	// release the reset
	initial begin
		rst_n = 1;
		repeat (5) @(posedge clk);
		rst_n = 0;
	end 

	initial begin
		repeat (3000) @(posedge clk);
		$finish;
	end


endmodule

// ----------------------------------------------------------------------
// EXERCISE 1
// a) bind traffic_lights_assertions module with traffic_lights_tb.dut module
//    HINT - take a look at the traffic_lights_assertions port list and connect the relevant signals
// b) name the binded module as dut_sva
// IMPORTANT - If you want to use your implementation, 
//             comment out line with `include statement, which is BELOW.
// ----------------------------------------------------------------------
// YOUR CODE HERE - START












// YOUR CODE HERE - END
// ----------------------------------------------------------------------
`include "solutions/ex1_solved.v"