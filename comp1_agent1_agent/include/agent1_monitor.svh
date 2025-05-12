`ifndef AGENT1_MONITOR_SVH
`define AGENT1_MONITOR_SVH

class agent1_monitor extends uvm_monitor;

    `uvm_component_utils(agent1_monitor)

    agent1_config cfg;
    uvm_analysis_port #(agent1_item) ap;
    virtual comp1_agent1_if.mp_monitor vif;
    local event dis_process_event;

    function new(string name = "agent1_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void set_cfg (agent1_config in);
        cfg = in;
        vif = cfg.vif;
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
      
	  @(vif.cb_mon);

      forever begin
        // ut_del_pragma_begin
        @(vif.cb_mon);
        if( !vif.cb_mon.valid || !vif.cb_mon.ready)
          continue;				

        begin
          agent1_item item = agent1_item::type_id::create("agent1_item_monitored");
          item.write = vif.cb_mon.write;
          item.err   = vif.cb_mon.err;

          if (vif.cb_mon.write)
            item.data  = vif.cb_mon.data_wr;
          else
            item.data  = vif.cb_mon.data_rd;

          ap.write(item);
          // ut_del_pragma_end

        end
      end 
    endtask


    virtual task disable_processes_by_reset_on();
        forever begin
            @(negedge vif.rst_n);
            ->dis_process_event; // It is possible to call 'disable monitor' but Xcelium (23.09) doesn't disable inner fork-join_none correctly
            // clean the buffers
        end
    endtask

    virtual task launch_processes_by_reset_off();
        forever begin
            @(posedge vif.rst_n);
            fork
                monitor();
                wait(dis_process_event.triggered);
            join_any
            disable fork;
        end
    endtask

endclass


`endif