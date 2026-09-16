`ifndef AGENT1_BASE_SEQ_SVH
`define AGENT1_BASE_SEQ_SVH

class agent1_base_seq extends uvm_sequence #(agent1_item);
    `uvm_object_utils (agent1_base_seq)

    `uvm_declare_p_sequencer(agent1_sequencer)

    function new ( string name = "agent1_base_seq");
      super.new (name);
    endfunction

    virtual task body();
      agent1_config cfg = p_sequencer.cfg;
      req = agent1_item::type_id::create("req");
      start_item(req);

      if ( !req.randomize() with {
        start_delay_cycles inside {[cfg.start_delay_clks_min:cfg.start_delay_clks_max]}; // ut_del_pragma
      }) begin
          `uvm_fatal(get_type_name(), $sformatf("Randomize of req failed"))
      end

      finish_item(req);
    endtask

endclass

`endif