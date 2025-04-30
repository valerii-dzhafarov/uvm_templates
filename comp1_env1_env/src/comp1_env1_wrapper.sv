
module comp1_env1_wrapper (comp1_env1_tb_if tb_if);

    // connect DUT here
    
    // ut_del_pragma_begin
    stack_model u_stack_model (
        .clk(tb_if.clk),
        .reset_n(tb_if.reset_n),
    
        .valid(tb_if.agent_if.valid),
        .ready(tb_if.agent_if.ready),
        .err(tb_if.agent_if.err),
    
        .write(tb_if.agent_if.write),
        
        .data_rd(tb_if.agent_if.data_rd),
        .data_wr(tb_if.agent_if.data_wr)
    );
    // ut_del_pragma_end
endmodule
