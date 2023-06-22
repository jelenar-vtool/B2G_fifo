module traffic_lights_assertions (
	input logic clk,
	input logic rst_n,
	//input logic broken,
    // all signals are inputs to this checker module
	input logic r_l,
	input logic y_l,
	input logic g_l,
    // also include any internal signals that you
    // use in your assertions expressions
	input logic time_of_day,
 	input logic [1:0] lights_state
);

	initial begin
		$display("------------------------------------------------------");
		$display("- traffic_lights_assertions file was binded properly -");
		$display("------------------------------------------------------");
	end

	sequence s_turn_off (logic x);
	    (x === 0);
	endsequence : s_turn_off

	sequence s_turn_on (logic x);
	    (x === 1);
	endsequence : s_turn_on

	property p_stop_go (bit clk, bit rst, bit r, bit y, bit g);
	    @(posedge clk) disable iff (rst)
	        (s_turn_on(r) and $rose(y)) |-> 
	        (s_turn_off(g) and s_turn_on(y)  and s_turn_on(r)) [*stop_go_duration] ##1 
	        (s_turn_on(g)  and s_turn_off(y) and s_turn_off(r));
	endproperty : p_stop_go

	a_stop_go: assert property (p_stop_go(clk, rst_n | (time_of_day != daytime), r_l, y_l, g_l));

	// ----------------------------------------------------------------------
	// EXERCISE 2
	// a) Implement a property that checks "go -> stop" traffic lights procedure
	//    based on "stop -> go" property,
	// b) Implement an assertion that will assert this property
	// IMPORTANT - If you want to use your implementation, 
	//             comment out line with `include statement, which is BELOW.
	// ----------------------------------------------------------------------
	// YOUR CODE HERE - START
	








	// YOUR CODE HERE - END
	// ----------------------------------------------------------------------
	`include "solutions/ex2_solved.v"


	// ----------------------------------------------------------------------
	// EXERCISE 3
	// a) Implement a property that checks the blinking of a yellow light
	//    during the nighttime.
	//    HINT - use the variable to store the previous value of yellow light
	// b) Implement an assertion that will assert this property
	// IMPORTANT - If you want to use your implementation, 
	//             comment out line with `include statement, which is BELOW.
	// ----------------------------------------------------------------------
	// YOUR CODE HERE - START
	








	// YOUR CODE HERE - END
	// ----------------------------------------------------------------------
	`include "solutions/ex3_solved.v"

endmodule: traffic_lights_assertions
