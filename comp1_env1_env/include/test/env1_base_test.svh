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
        env1_vseq vseq = env1_vseq::type_id::create("env1_vseq") ;
        phase.raise_objection(phase);
        vseq.agent1_seqr = env.agent1_master.sequencer;
        vseq.start(null);
        phase.drop_objection(phase);
    endtask
    // ut_del_pragma_end

endclass

`endif 

