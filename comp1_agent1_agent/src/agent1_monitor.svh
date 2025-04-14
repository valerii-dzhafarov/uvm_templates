`ifndef AGENT1_MONITOR_SVH
`define AGENT1_MONITOR_SVH

class agent1_monitor extends uvm_monitor;

    `uvm_component_utils(agent1_monitor)

    virtual comp1_agent1_if.mp_monitor vif;
    uvm_analysis_port #(agent1_item) ap;

    function new(string name = "agent1_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        ap = new ("agent1_mon_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        agent1_item item;
        forever begin
            item = agent1_item::type_id::create("agent1_item_monitored");
            @(vif.cb_mon)
            // collect item
            ap.write(item);
        end
    endtask

endclass


`endif