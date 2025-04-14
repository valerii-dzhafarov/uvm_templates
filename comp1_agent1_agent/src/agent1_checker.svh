`ifndef AGENT1_CHECKER_SVH
`define AGENT1_CHECKER_SVH

class agent1_checker extends uvm_subscriber #(agent1_item);
    
    `uvm_component_utils(agent1_checker)
  
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
  
    function void write (agent1_item t);
    
    endfunction

endclass

`endif