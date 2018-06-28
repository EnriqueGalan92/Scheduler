module TASK_MGR (
	clk,
	rst,
	task_no,
	timer_left
);

input clk;
input rst;
output [3:0] task_no;
output [3:0] timer_left;

// memory_array[i_addr] <= i_data; 

reg [7:0] task_info;
reg [7:0] entry_index;

reg [3:0] task_no_r;
reg [3:0] task_timer_r;
reg [3:0] task_orig;


parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter DEPTH = 16;
	 
reg [DATA_WIDTH-1:0] task_array [0:DEPTH-1]; 
reg [DATA_WIDTH-5:0] entry_table [0:DEPTH-1];

initial
begin
	entry_table[0] <= 1'h1;
	entry_table[1] <= 1'h2;
	entry_table[2] <= 1'h3;
	entry_table[3] <= 1'h1;
	entry_table[4] <= 1'h4;
	entry_table[5] <= 1'h2;
	entry_table[6] <= 1'h1;
	entry_table[7] <= 1'h3;
	entry_table[8] <= 1'h1;
	entry_table[9] <= 1'h2;
	entry_table[10] <= 1'h4;
	entry_table[11] <= 1'h1;
	entry_table[12] <= 1'h3;
	entry_table[13] <= 1'h2;
	entry_table[14] <= 1'h1;
	entry_table[15] <= 1'hf;
end

always@(posedge clk or negedge rst)
begin
  if(!rst)
  begin
	 entry_index 	<= 0;
	 task_no_r 		<= 0;
	 task_timer_r  <= 0;
	 task_array[0] <= 8'b00010001;
	 task_array[1] <= 8'b00010001;
	 task_array[2] <= 8'b00100010;
	 task_array[3] <= 8'b00100010;
  end
  else
  begin
    task_no_r <= entry_table[entry_index];
	 task_info <= task_array[task_no_r];
	 task_orig <= {task_info[7:4]};
	 task_timer_r <= {task_info[3:0]};
	 if (task_timer_r > 0)
  		task_timer_r <= task_timer_r - 1;
	 else
	 begin
		entry_index <= entry_index + 1;
	 end
	 task_array[task_no_r] <= {task_orig,task_timer_r};
  end
	 
end

assign task_no = task_no_r;
assign timer_left = task_timer_r;

endmodule
