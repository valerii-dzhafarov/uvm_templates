
`ifndef COMP1_AGENT1_INPUT_SKEW 
    `define COMP1_AGENT1_INPUT_SKEW #1step
`endif

`ifndef COMP1_AGENT1_OUTPUT_SKEW 
    `define COMP1_AGENT1_OUTPUT_SKEW #0
`endif


interface comp1_agent1_if (input logic clk, input logic rst_n);


    clocking cb_mon @ (posedge clk);
        default input `COMP1_AGENT1_INPUT_SKEW;
    endclocking

    clocking cb_drv @ (posedge clk);
        default input `COMP1_AGENT1_INPUT_SKEW output `COMP1_AGENT1_OUTPUT_SKEW;
    endclocking

    modport mp_monitor (
        clocking cb_mon, input rst_n
    );

    modport mp_driver (
        clocking cb_drv, input rst_n
    );

endinterface