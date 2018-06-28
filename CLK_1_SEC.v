module CLK_1_SEC (
	ref_clk,
	rst,
	clk_out
);

input ref_clk;
input rst;
output clk_out;

reg clk_1;
reg [31:0] counter;

always@(posedge ref_clk or negedge rst)
begin
	if(!rst)
		clk_1 	<= 0;
	else
	begin
		if (counter < 10000000)
			counter <= counter + 1;
		else
		begin
			clk_1 <= ~clk_1;
			counter <= 0;
		end
	end
end	

assign clk_out = clk_1;
endmodule
	