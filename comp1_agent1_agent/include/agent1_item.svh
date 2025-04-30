`ifndef AGENT1_ITEM_SVH
`define AGENT1_ITEM_SVH

class agent1_item extends uvm_sequence_item;
    
    `uvm_object_utils(agent1_item)
    agent1_config cfg;

    // ut_del_pragma_begin
    rand logic [31:0] data; 
    rand logic write; 
    logic err = 0;
    rand int start_delay_cycles;


    constraint c_start_delay_cycles {
        start_delay_cycles inside {[cfg.start_delay_clks_min:cfg.start_delay_clks_max]};
    }
    // ut_del_pragma_end

    function void pre_randomize();
        if (cfg == null)
            `uvm_fatal("NO_CFG_OBJECT", "Set cfg before randomize")
    endfunction
    
    function new(string name = "agent1_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        agent1_item rhs_casted;
        super.do_copy(rhs);
        if(!$cast(rhs_casted,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end
        // ut_del_pragma_begin
        data  = rhs_casted.data; 
        write = rhs_casted.write;
        err   = rhs_casted.err;
        start_delay_cycles   = rhs_casted.start_delay_cycles;
        // ut_del_pragma_end
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        agent1_item rhs_casted;
        do_compare = super.do_compare(rhs,comparer);

        if(!$cast(rhs_casted,rhs)) begin
            `uvm_fatal(get_type_name(), $sformatf("cast to type %s failed", get_type_name())) 
        end
        // ut_del_pragma_begin
        do_compare &= comparer.compare_field_int("data",  data, rhs_casted.data, $bits(data));  
        do_compare &= comparer.compare_field_int("write", write, rhs_casted.write, $bits(write)); 
        do_compare &= comparer.compare_field_int("err",   err, rhs_casted.err, $bits(err)); 
        // ut_del_pragma_end
    endfunction

    function void do_print (uvm_printer printer);
        super.do_print(printer);
        // ut_del_pragma_begin
        printer.print_field_int("data", data, $bits(data)); 
        printer.print_field_int("write", write, $bits(write)); 
        printer.print_field_int("err", err, $bits(err)); 
        printer.print_field_int("start_delay_cycles", start_delay_cycles, $bits(start_delay_cycles)); 
        // ut_del_pragma_end
    endfunction

    function void do_pack(uvm_packer packer);
        super.do_pack(packer);
        // ut_del_pragma_begin
        packer.pack_field_int(data, $bits(data)); 
        packer.pack_field_int(write, $bits(write)); 
        packer.pack_field_int(err, $bits(err)); 
        // ut_del_pragma_end
    endfunction

    function void do_unpack(uvm_packer packer);
        super.do_unpack(packer);
        // ut_del_pragma_begin
        data = packer.unpack_field_int($bits(data)); 
        write = packer.unpack_field_int($bits(write)); 
        err   = packer.unpack_field_int($bits(err)); 
        // ut_del_pragma_end
    endfunction

    virtual function void do_record(uvm_recorder recorder);
        super.do_record(recorder);
        // ut_del_pragma_begin
        recorder.record_field_int("data", data, $bits(data)); 
        recorder.record_field_int("write", write, $bits(write)); 
        recorder.record_field_int("err", err, $bits(err)); 
        // ut_del_pragma_end
    endfunction

    function string convert2string();
        string s;
        s = super.convert2string();
        // ut_del_pragma_begin
        s = {s, $sformatf(" data: 0x%h", data)}; 
        s = {s, $sformatf(" write:%1b", write)}; 
        s = {s, $sformatf(" err:%1b",   err)}; 
        s = {s, $sformatf(" start_delay_cycles:%0d",   start_delay_cycles)}; 
        // ut_del_pragma_end
        return s;
    endfunction

endclass

`endif 