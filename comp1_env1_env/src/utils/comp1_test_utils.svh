`ifndef COMP1_TEST_UTILS_SVH
`define COMP1_TEST_UTILS_SVH

interface class comp1_test_utils_cb ;
  pure virtual function void post_get_test_desc(ref string test_name);
endclass

class comp1_test_utils extends uvm_component;

  `uvm_component_utils(comp1_test_utils)

  string test_name    = "unknown_test";
  longint unsigned uvm_drain_time_ns = 500;
  longint unsigned uvm_timeout_us    = 5000;
  longint unsigned uvm_timestamp_us  = 100;
  int unsigned     sv_seed;

  comp1_test_utils_cb         cbs     [$];

  function new( string name = "comp1_test_utils", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    read_properties();
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);

    begin
      uvm_phase main_phase = phase.find_by_name("main", 0);
      main_phase.phase_done.set_drain_time(this, uvm_drain_time_ns * 1ns);
      uvm_root::get().set_timeout(uvm_timeout_us * 1us);
      printing_timestamp();
    end

  endfunction
  
  function void report_phase(uvm_phase phase);
      uvm_report_server svr;
      string result;
      string result_string;
      string canva;
      string formated_string;
      bit is_ok;
      super.report_phase(phase);
      svr = uvm_report_server::get_server();
      is_ok = !(svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR));
      result_string = $sformatf("\n SEED=%0d %s %s", sv_seed, get_test_desc(), is_ok ? "PASSED" : "FAILED");
      repeat(result_string.len())
        canva = {canva, "-"};
      result =
            {{3{"\n", canva}},
              result_string,
            {3{"\n", canva}}};
      formated_string = $sformatf("%c[1;%0dm%s %c[0m", 27, is_ok ? 32 : 31,result, 27);
      `uvm_info("REPORT", formated_string , UVM_NONE)
  endfunction

  virtual function string get_test_desc();

    get_test_desc = $sformatf("UVM_TEST=%s",  test_name);

    foreach (cbs[i])
      cbs[i].post_get_test_desc(get_test_desc);
    
  endfunction


  virtual function void printing_timestamp();
    time uvm_timestamp;
    uvm_timestamp = uvm_timestamp_us * 1us;
    fork
      while(1) begin
        #uvm_timestamp;
        `uvm_info("UVM_TIMESTAMP" , $sformatf("Test <%s> is pulsing", test_name), UVM_NONE)
      end
    join_none
  endfunction

  virtual function void read_properties();

    void'($value$plusargs("UVM_DRAINTIME_NS=%0d", uvm_drain_time_ns));
    void'($value$plusargs("UVM_TIMEOUT_US=%d", uvm_timeout_us));
    void'($value$plusargs("UVM_TIMESTAMP_US=%d", uvm_timestamp_us));

  endfunction

  
endclass
`endif