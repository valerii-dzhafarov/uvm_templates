`ifndef ENV1_BASE_TEST_SVH
`define ENV1_BASE_TEST_SVH

class env1_base_test extends uvm_test;

    `uvm_component_utils(env1_base_test)

    env1_cfg cfg;
    env1_env env;
    comp1_test_utils test_utils;

    function new (string name = "env1_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);

        cfg = env1_cfg::type_id::create("cfg");

        if(!uvm_config_db#(virtual comp1_env1_tb_if)::get(null,"","ENV1_VIF::",cfg.vif)) begin
            `uvm_fatal(get_type_name(), "Handler on virtual interface (intt_env1_tb_if) haven't been found")
        end

        cfg.build();
        
        env = env1_env::type_id::create("env", this);
        env.cfg = cfg;

        test_utils = comp1_test_utils::type_id::create("test_utils", this);
        test_utils.test_name = get_type_name();
        test_utils.sv_seed   = cfg.sv_seed;

    endfunction

    // ut_del_pragma_begin
    task main_phase (uvm_phase phase);
        agent1_base_seq agent1_seq = agent1_base_seq::type_id::create("agent1_seq") ;
        phase.raise_objection(phase);
      	repeat(10) begin
	        int start_delay_cycles = $urandom_range(0,2); // this value should be in item
            repeat(start_delay_cycles) @(posedge cfg.vif.clk);  // this pause should be in driver
            agent1_seq.start(env.agent1_master.sequencer);
        end
      	#100ns; 
        phase.drop_objection(phase);
    endtask
    // ut_del_pragma_end

endclass

`endif 

