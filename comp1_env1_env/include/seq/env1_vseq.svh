`ifndef ENV1_VSEQ_SVH
`define ENV1_VSEQ_SVH

class env1_vseq extends uvm_sequence;
    `uvm_object_utils (env1_vseq)

    agent1_sequencer agent1_seqr; // ut_del_pragma
  
    function new ( string name = "env1_vseq");
        super.new (name);
    endfunction

    virtual task pre_start();  
        if (agent1_seqr == null)
            `uvm_fatal("NO_OBJ", "Set an agent1_sequencer before start a sequencer")
    endtask

    virtual task body();
        // ut_del_pragma_begin
        agent1_base_seq agent1_seq = agent1_base_seq::type_id::create("agent1_seq") ;
      	repeat(10) begin
            agent1_seq.start(agent1_seqr);
        end
        // ut_del_pragma_end
    endtask 


endclass 

`endif