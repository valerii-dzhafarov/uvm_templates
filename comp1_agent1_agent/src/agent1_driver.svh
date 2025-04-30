`ifndef AGENT1_DRIVER_SVH
`define AGENT1_DRIVER_SVH

class agent1_driver extends uvm_driver#(agent1_item);

    `uvm_component_utils(agent1_driver)

    agent1_config cfg;
    virtual comp1_agent1_if.mp_driver vif;

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