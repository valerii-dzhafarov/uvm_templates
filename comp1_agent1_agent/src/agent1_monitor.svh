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
        fork
            disable_processes_by_reset_on();
            launch_processes_by_reset_off();
        join
    endtask

    virtual task monitor();
        agent1_item item;
        forever begin
            item = agent1_item::type_id::create("agent1_item_monitored");
            @(vif.cb_mon)
            // collect item
            ap.write(item);
        end
    endtask

    virtual task disable_processes_by_reset_on();
        forever begin
            @(negedge vif.rst_n);
            disable monitor;
            // disable other processes
            // clean the buffers
        end
    endtask

    virtual task launch_processes_by_reset_off();
        forever begin
            @(posedge vif.rst_n);
            fork
                monitor();
                // start other proc
            join_none
        end
    endtask

endclass


`endif