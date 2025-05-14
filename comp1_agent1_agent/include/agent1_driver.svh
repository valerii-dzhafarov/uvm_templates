`ifndef AGENT1_DRIVER_SVH
`define AGENT1_DRIVER_SVH

class agent1_driver extends uvm_driver#(agent1_item);

    `uvm_component_utils(agent1_driver)

    agent1_config cfg;
    virtual comp1_agent1_if.mp_driver vif;
    local event dis_process_event;

    function new(string name = "agent1_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void set_cfg(agent1_config in);
        cfg = in;
        vif = in.vif;
    endfunction

    task run_phase(uvm_phase phase);
        fork
            disable_processes_by_reset_on();
            launch_processes_by_reset_off();
        join
    endtask

    virtual task drive();
        forever begin
            @vif.cb_drv;
            // ut_del_pragma_begin
            vif.cb_drv.valid <= 1'b0;
            vif.cb_drv.write <= 1'b0; 	
          
            if (req != null) begin
                `uvm_info (get_type_name(), $sformatf("finish drive the item: \n%s", req.sprint()), UVM_NONE)
                seq_item_port.item_done();
            end
            
            req = null;
            seq_item_port.try_next_item(req);
            if (req==null) 
                continue;

            repeat (req.start_delay_cycles)
                @vif.cb_drv;
            
            `uvm_info (get_type_name(), $sformatf("start drive the item: \n%s", req.sprint()), UVM_NONE)

            if (req.write) begin
                vif.cb_drv.data_wr <= req.data; 
            end

            vif.cb_drv.valid <= 1'b1; 
            vif.cb_drv.write <= req.write; 

            wait (vif.cb_drv.ready);
        
            if (!req.write) begin
                req.data = vif.cb_drv.data_rd;
                req.err  = vif.cb_drv.err; 
            end
            // ut_del_pragma_end
        
      end
  endtask

    virtual task disable_processes_by_reset_on();
        forever begin
            @(negedge vif.rst_n);
            ->dis_process_event; // It is possible to call 'disable drive' but Xcelium (23.09) doesn't disable inner fork-join_none correctly
            // clean the buffers
        end
    endtask

    virtual task launch_processes_by_reset_off();
        forever begin
            @(posedge vif.rst_n);
            init_bus_state();
            fork
                drive();
                wait (dis_process_event.triggered);
            join_any;
            disable fork;
        end
    endtask

    virtual task init_bus_state();
        // ut_del_pragma_begin
        {vif.cb_drv.valid, vif.cb_drv.write, vif.cb_drv.data_wr} <= '0;
        // ut_del_pragma_end
    endtask

endclass


`endif