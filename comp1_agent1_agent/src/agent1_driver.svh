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
            reset_on_handle();
            reset_off_handle();
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

    virtual task reset_on_handle();
        forever begin
            @(negedge vif.rst_n);
            disable drive;
            // clean the buffers
            // disable other processes
        end
    endtask

    virtual task reset_off_handle();
        forever begin
            @(negedge vif.rst_n);
            drive();
            // enable other proc
        end
    endtask

endclass


`endif