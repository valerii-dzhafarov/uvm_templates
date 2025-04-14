`ifndef AGENT1_ITEM_SVH
`define AGENT1_ITEM_SVH


class agent1_item extends uvm_sequence_item;
    typedef agent1_item this_t;

    `uvm_object_utils(agent1_item)

    function new(string name = "agent1_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        this_t rhs_;
        super.do_copy(rhs);
        if(!$cast(rhs_,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end

        // copy
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t rhs_;
        do_compare = super.do_compare(rhs,comparer);
        if(!$cast(rhs_,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end
//        do_compare &= comparer.compare_field_int("f1", f1, rhs_.f1);

    endfunction

    function void do_print (uvm_printer printer);
        super.do_print(printer);
  //|     printer.print_field_int("f1", f1, $bits(f1), UVM_DEC);
  //|     printer.print_object("data", data);
    endfunction

    function string convert2string();
        string s;
        s = super.convert2string();
        // 
        return s;
    endfunction

endclass

`endif 