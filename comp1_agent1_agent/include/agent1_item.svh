`ifndef AGENT1_ITEM_SVH
`define AGENT1_ITEM_SVH

class agent1_item extends uvm_sequence_item;

    `uvm_object_utils_begin(agent1_item)
        `uvm_field_int(data, UVM_DEFAULT) // ut_del_pragma
        `uvm_field_int(write, UVM_DEFAULT) // ut_del_pragma
        `uvm_field_int(err, UVM_DEFAULT) // ut_del_pragma
        `uvm_field_int(start_delay_cycles, UVM_DEFAULT | UVM_NOCOMPARE) // ut_del_pragma
    `uvm_object_utils_end

    // ut_del_pragma_begin
    rand logic [31:0] data;
    rand logic write;
    logic err = 0;
    rand int start_delay_cycles;
    // ut_del_pragma_end

    function new(string name = "agent1_item");
        super.new(name);
    endfunction

endclass

`endif