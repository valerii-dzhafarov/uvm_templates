`ifndef AGENT1_COV_COLLECTOR_SVH
`define AGENT1_COV_COLLECTOR_SVH

class agent1_cov_collector extends uvm_subscriber #(agent1_item);
  
    `uvm_component_utils(agent1_cov_collector)
  
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
  
    function void write (agent1_item t);
        
    endfunction

endclass

`endif