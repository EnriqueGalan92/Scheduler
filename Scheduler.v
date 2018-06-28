module Scheduler(
	///////// CLOCK /////////
   input              CLOCK_50,

	///////// KEY /////////
   input       [3:0]  KEY,
	
	///////// SW /////////
   input       [9:0]  SW,

	///////// HEX0 /////////
	output      [6:0]  HEX0,

	///////// HEX1 /////////
	output      [6:0]  HEX1,

	///////// HEX2 /////////
	output      [6:0]  HEX2,

	///////// HEX3 /////////
	output      [6:0]  HEX3,

	///////// HEX4 /////////
	output      [6:0]  HEX4,

	///////// HEX5 /////////
	output      [6:0]  HEX5
      
	///////// LEDR /////////
	// output      [9:0]  LEDR
	
);

wire clk_1;
wire clk_10;
wire [23:0]	mSEG7_DIG;
wire RST;

wire [3:0] task_num;
wire [3:0] task_timer;


always@(posedge clk_10 or negedge KEY[0])
begin
  if(!KEY[0])
  begin
  end		
end	

assign	mSEG7_DIG	=	KEY[0]? 	{6{4'b1111}} :{6{4'b1110}};
assign	RST = KEY[0];


SEG7_LUT_6 			u0	(	.oSEG0(HEX0),
							   .oSEG1(HEX1),
							   .oSEG2(HEX2),
							   .oSEG3(HEX3),
								.oSEG4(HEX4),
								.oSEG5(HEX5),
							   .iDIG(mSEG7_DIG),
								.task_timer(task_timer),
								.task_id(task_num));


PLL					u1 (	.refclk (CLOCK_50),
								.rst(RST),
								.outclk_0(clk_10));
								
CLK_1_SEC			u2 (  .ref_clk(clk_10),
								.rst(RST),
								.clk_out(clk_1));

TASK_MGR				u3 (	.clk (clk_1),
								.rst (RST),
								.task_no(task_num),
								.timer_left(task_timer));

endmodule
