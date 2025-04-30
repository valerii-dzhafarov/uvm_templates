
`ifndef COMP1_AGENT1_INPUT_SKEW 
    `define COMP1_AGENT1_INPUT_SKEW #1step
`endif

`ifndef COMP1_AGENT1_OUTPUT_SKEW 
    `define COMP1_AGENT1_OUTPUT_SKEW #0
`endif

interface comp1_agent1_if (input logic clk, input logic rst_n);
    // ut_del_pragma_begin
    logic valid; 
    logic ready; 
    logic write; 
    logic [31:0] data_rd;
    logic [31:0] data_wr;
    logic err;
    // ut_del_pragma_end

    clocking cb_mon @ (posedge clk);
        default input `COMP1_AGENT1_INPUT_SKEW;
        input valid, ready, write, data_rd, data_wr, err; // ut_del_pragma
    endclocking

    clocking cb_drv @ (posedge clk);
        default input `COMP1_AGENT1_INPUT_SKEW output `COMP1_AGENT1_OUTPUT_SKEW;
        output valid, write, data_wr; // ut_del_pragma
        input  ready, data_rd, err; // ut_del_pragma
    endclocking

    modport mp_monitor (
        clocking cb_mon, input rst_n
    );

    modport mp_driver (
        clocking cb_drv, input rst_n
    );

endinterface