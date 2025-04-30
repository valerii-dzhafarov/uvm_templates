`ifndef ENV1_ENV_SVH
`define ENV1_ENV_SVH

class env1_env extends uvm_env;
    `uvm_component_utils(env1_env)

    env1_cfg         cfg;

    agent1_agent      agent1_master; // ut_del_pragma
    env1_stack_sb    stack_sb; // ut_del_pragma

    function new (string name = "env1_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        if ( cfg == null ) begin
            `uvm_fatal (get_type_name(), $sformatf("No cfg object"))
        end        
        // ut_del_pragma_begin
        agent1_master = agent1_agent::type_id::create("agent1_master", this);
        agent1_master.cfg = cfg.agent1_cfg;
        stack_sb = env1_stack_sb::type_id::create("stack_sb", this);
        // ut_del_pragma_end
    endfunction

    function void connect_phase (uvm_phase phase);
        agent1_master.monitor_ap.connect(stack_sb.analysis_export);  // ut_del_pragma
    endfunction

endclass

`endif 

