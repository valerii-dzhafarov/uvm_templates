// ut_del_pragma_file

`ifndef STACK_MODEL_SVH
`define STACK_MODEL_SVH

class stack_model extends uvm_component;

    `uvm_component_utils(stack_model)

    int depth = 16;

    logic [31:0] stack [$];

    function new (string name = "stack_model", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    

    function void request(agent1_item t);
        if (t.write) begin

          if (stack.size() >= depth) begin
                t.err = 1;
                return;
            end

            t.err = 0;    
            stack.push_front(t.data);

        end
        else begin

            if (stack.size() == 0) begin
                t.err = 1;
                return;
            end

            t.err = 0;
            t.data = stack.pop_front();

        end
    endfunction


endclass


`endif