`ifndef ENV1_CFG_SVH
`define ENV1_CFG_SVH

class env1_cfg extends uvm_object;

    `uvm_object_utils(env1_cfg)

    virtual comp1_env1_tb_if vif;
    bit     coverage_en;
    int     sv_seed;

    agent1_config agent1_cfg; // ut_del_pragma

    function new (string name = "env1_cfg");
        super.new(name);
    endfunction

    virtual function void build();
        if (vif == null) begin
            `uvm_fatal(get_type_name(), $sformatf("No vif in config"))
        end
        read_properties();
        agent1_cfg = agent1_config::type_id::create("agent1_cfg"); // ut_del_pragma
        agent1_cfg.vif = vif.agent_if; // ut_del_pragma
    endfunction

    virtual function void read_properties();
        void'($value$plusargs("uvm_env_cfg_cov_en=%b", coverage_en));
        `uvm_info(get_type_name(), $sformatf("coverage_en=%0b", coverage_en), UVM_LOW)

        void'($value$plusargs("sv_seed=%d", sv_seed));
        `uvm_info(get_type_name(), $sformatf("sv_seed=%0d", sv_seed), UVM_LOW)
    endfunction

endclass

`endif

