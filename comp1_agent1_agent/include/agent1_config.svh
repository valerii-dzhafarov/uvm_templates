`ifndef AGENT1_CONFIG_SVH
`define AGENT1_CONFIG_SVH

class agent1_config extends uvm_object;

    `uvm_object_utils(agent1_config)

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    virtual comp1_agent1_if vif;

    // build and connect inner coverage collector
    bit coverage_en = 1;
    // build and connect inner/protocol checker  
    bit checker_en  = 1;

    // ut_del_pragma_begin
    int start_delay_clks_min = 0;
    int start_delay_clks_max = 3;
    // ut_del_pragma_end

    function new(string name = "agent1_config");
        super.new(name);
    endfunction

endclass

`endif 