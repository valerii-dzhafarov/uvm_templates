`ifndef AGENT1_BASE_SEQ_SVH
`define AGENT1_BASE_SEQ_SVH

class agent1_base_seq extends uvm_sequence #(agent1_item);
    `uvm_object_utils (agent1_base_seq)
    
    `uvm_declare_p_sequencer(agent1_sequencer)

    function new ( string name = "agent1_base_seq");
      super.new (name);
    endfunction
  
    virtual task body();  

      req = agent1_item::type_id::create("req");
      req.cfg  = p_sequencer.cfg;
      
      start_item(req);

      if ( !req.randomize() ) begin
          `uvm_fatal(get_type_name(), $sformatf("Randomize of req failed"))
      end
      
      finish_item(req);
    endtask 

    virtual function void do_record(uvm_recorder recorder);
      super.do_record(recorder);
      // record
    endfunction

endclass 

`endif