
module stack_model #(
    parameter DEPTH = 4
) (
    input  logic clk,
    input  logic reset_n,

    input  logic valid,
    output logic ready,
    output logic err,

    input  logic write,
    
    input   logic [31:0]  data_wr,
    output  logic [31:0]  data_rd

    );
	
 
    logic [2:0] ready_cnt;

    localparam MAX_READY_DELAY = {$bits(ready_cnt) {1'b1}};
    localparam AWIDTH = (DEPTH > 1) ? $clog2(DEPTH) : 1; 

    logic [31:0] mem [DEPTH];

    logic [AWIDTH  : 0] pntr;
    wire  [AWIDTH  : 0] rd_pntr_w;
    
    wire overflow;
    wire underflow;
    
    assign overflow  = valid && ready &&  write && (pntr == DEPTH);
    assign underflow = valid && ready && !write && (pntr == 0);

	assign rd_pntr_w  = pntr - !underflow;
  
    assign err = overflow | underflow;

    always_ff @(posedge clk) begin
        if (valid && ready && write) begin
                mem[pntr] <= data_wr;
        end
    end

    assign data_rd = mem[rd_pntr_w];

  	always_ff @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            pntr <= '0;
        end
        else if (valid && ready) begin
            if (write)
                pntr <= pntr + !overflow;
            else
                pntr <= rd_pntr_w;
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            ready_cnt <= '0;
        end
        else if (ready && valid) begin
            ready_cnt <= $bits(ready_cnt)'($urandom_range(MAX_READY_DELAY));
        end
        else 
            ready_cnt <= ready_cnt ? (ready_cnt - 1) : 0;
    end

    assign ready = !ready_cnt;

endmodule
