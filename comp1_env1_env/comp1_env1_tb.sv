
module comp1_env1_tb;

    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import comp1_env1_test_pkg::*;
  
    comp1_env1_tb_if    tb_if();
    comp1_env1_wrapper  dut_wrapper(tb_if);
    
    initial begin
      $timeformat(-9, 3, "ns", 10);
      uvm_config_db#(virtual comp1_env1_tb_if)::set(null, "", "ENV1_VIF::", tb_if);
      run_test();
    end
    
    // ut_del_pragma_begin
    initial begin
    	$dumpfile("dump.vcd"); 
      $dumpvars;
    end
    // ut_del_pragma_end

  endmodule
  
  