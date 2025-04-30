`ifndef AGENT1_SEQUENCER_SVH
`define AGENT1_SEQUENCER_SVH

class agent1_sequencer extends uvm_sequencer#(agent1_item);

    `uvm_component_utils(agent1_sequencer)

    agent1_config cfg;
    
    function new(string name = "agent1_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void set_cfg(agent1_config in);
        cfg = in;
    endfunction

endclass

`endif