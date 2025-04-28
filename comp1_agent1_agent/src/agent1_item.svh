`ifndef AGENT1_ITEM_SVH
`define AGENT1_ITEM_SVH


class agent1_item extends uvm_sequence_item;

    rand int unsigned delete_me_var;

    `uvm_object_utils(agent1_item)

    function new(string name = "agent1_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        agent1_item rhs_casted;
        super.do_copy(rhs);
        if(!$cast(rhs_casted,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end

        delete_me_var = rhs_casted.delete_me_var;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        agent1_item rhs_casted;
        do_compare = super.do_compare(rhs,comparer);

        if(!$cast(rhs_casted,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end
        do_compare &= comparer.compare_field_int("delete_me_var", delete_me_var, rhs_casted.delete_me_var, $bits(delete_me_var));
    endfunction

    function void do_print (uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("delete_me_var", delete_me_var, $bits(delete_me_var));
    endfunction

    function void do_pack(uvm_packer packer);
        super.do_pack(packer);
        packer.pack_field_int(delete_me_var, $bits(delete_me_var));
    endfunction

    function void do_unpack(uvm_packer packer);
        super.do_unpack(packer);
        delete_me_var = packer.unpack_field_int($bits(delete_me_var));
        // unpack
    endfunction

    virtual function void do_record(uvm_recorder recorder);
        super.do_record(recorder);
        recorder.record_field_int("delete_me_var", delete_me_var, $bits(delete_me_var));
        // record
    endfunction

    function string convert2string();
        string s;
        s = super.convert2string();
        s = {s, $sformatf(" delete_me_var: 0x%h", delete_me_var)};
        return s;
    endfunction

endclass

`endif 