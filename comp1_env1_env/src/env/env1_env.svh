`ifndef ENV1_ENV_SVH
`define ENV1_ENV_SVH

class env1_env extends uvm_env;
    `uvm_component_utils(env1_env)

    env1_cfg         cfg;

    function new (string name = "env1_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        if ( (cfg == null) || ( uvm_config_db#(env1_cfg)::get(this,"","env1_cfg",cfg) ) ) begin
            `uvm_fatal (get_type_name(), $sformatf("No cfg object"))
        end
        // add sub-components objects here
    endfunction

endclass

`endif 

