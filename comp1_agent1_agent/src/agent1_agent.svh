`ifndef AGENT1_AGENT_SVH
`define AGENT1_AGENT_SVH

class agent1_agent extends uvm_agent;

    `uvm_component_utils(agent1_agent)

    agent1_config       cfg;
    
    agent1_monitor      monitor;
    agent1_driver       driver;
    agent1_sequencer    sequencer;

    agent1_checker          ichecker; // word "checker" is reserved in SV
    agent1_cov_collector    cov_collector;

    uvm_analysis_port #(agent1_item) monitor_ap;

    function new(string name = "agent1_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        monitor_ap = new("monitor_ap", this);

        if (cfg == null) begin
            `uvm_fatal (get_type_name(), $sformatf("No cfg object. Set it directly or with uvm_config_db"))
        end

        if (cfg.vif == null) begin
            `uvm_fatal (get_type_name(), $sformatf("No vif handle. Set it directly in cfg object"))
        end
        
        monitor = agent1_monitor::type_id::create($sformatf("monitor"), this);

        if ( get_is_active() == UVM_ACTIVE ) begin
            driver = agent1_driver::type_id::create("driver",this);
            sequencer = agent1_sequencer::type_id::create("sequencer", this);
        end
        
        if (cfg.checker_en) begin
            ichecker = agent1_checker::type_id::create("checker", this);
        end

        if (cfg.coverage_en) begin
            cov_collector = agent1_cov_collector::type_id::create("cov_collector", this);
        end

    endfunction
    
    function void connect_phase(uvm_phase phase);

        monitor.ap.connect(monitor_ap);
        monitor.vif = cfg.vif.mp_monitor;

        if ( get_is_active() == UVM_ACTIVE ) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
            driver.vif = cfg.vif.mp_driver;
        end
        
        if (cfg.checker_en) begin
            monitor.ap.connect ( ichecker.analysis_export );
        end

        if (cfg.coverage_en) begin
            monitor.ap.connect ( cov_collector.analysis_export );            
        end
        
    endfunction

    function uvm_active_passive_enum get_is_active();
        return cfg.is_active;
    endfunction

endclass


`endif