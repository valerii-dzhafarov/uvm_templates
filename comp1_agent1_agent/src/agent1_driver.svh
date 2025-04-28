`ifndef AGENT1_DRIVER_SVH
`define AGENT1_DRIVER_SVH

class agent1_driver extends uvm_driver;

    `uvm_component_utils(agent1_driver)

    virtual comp1_agent1_if.mp_driver vif;

    function new(string name = "agent1_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        fork
            disable_processes_by_reset_on();
            launch_processes_by_reset_off();
        join
    endtask

    virtual task drive();
        forever begin
            seq_item_port.get_next_item(req);
            @(vif.cb_drv);
            // pin wiggle
            seq_item_port.item_done();
        end
    endtask

    virtual task disable_processes_by_reset_on();
        forever begin
            @(negedge vif.rst_n);
            disable drive;
            // disable other processes
            // clean the buffers
        end
    endtask

    virtual task launch_processes_by_reset_off();
        forever begin
            @(posedge vif.rst_n);
            fork
                drive();
                // start other proc
            join_none
        end
    endtask

endclass


`endif