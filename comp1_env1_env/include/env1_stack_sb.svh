// ut_del_pragma_file

`ifndef ENV1_STACK_SB_SVH
`define ENV1_STACK_SB_SVH

class env1_stack_sb extends uvm_subscriber#(agent1_item);

    `uvm_component_utils(env1_stack_sb)

    stack_model gm;

    function new (string name = "stack_model", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    function void build_phase (uvm_phase phase);
        gm = stack_model::type_id::create("gm",this);
        gm.depth = 4; // is magic number. it is simple example. in real case use cfg object
    endfunction

    function void write (agent1_item t);
        
        agent1_item t_gm;
        
        if (!$cast(t_gm, t.clone()))
            `uvm_fatal("CAST_FAIL", "")

        t_gm.set_name("agent1_gm_item");
        gm.request(t_gm);
        
        if (!t_gm.compare(t)) 
            `uvm_error("CMP_ERR", 
                $sformatf("GM item is not matched with catched from DUT. GM : \n %s \nDUT : \n %s ",  
                    t_gm.sprint(), t.sprint()))
        else 
            `uvm_info("CMP_MATCH", 
                $sformatf("GM item is matched with catched from DUT. GM : \n %s \nDUT : \n %s ",  
                    t_gm.sprint(), t.sprint()), UVM_MEDIUM)


    endfunction

endclass


`endif