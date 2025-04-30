`ifndef AGENT1_BASE_SEQ_SVH
`define AGENT1_BASE_SEQ_SVH

class agent1_base_seq extends uvm_sequence #(agent1_item);
    `uvm_object_utils (agent1_base_seq)
  
    // Define a constructor
    function new ( string name = "agent1_base_seq");
      super.new (name);
    endfunction : new
  
    virtual task body();  

      req = agent1_item::type_id::create("req");
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