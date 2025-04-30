interface comp1_env1_tb_if;

    // ut_del_pragma_begin

    logic clk;
    logic reset_n;

    initial begin
        reset_n = 0;
        #150ns reset_n = 1;
    end

    initial begin
        clk = 0;
        forever begin
           #5ns clk = !clk;
        end
    end

    comp1_agent1_if agent_if(clk, reset_n);
    
    // ut_del_pragma_end

endinterface
