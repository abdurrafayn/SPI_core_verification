class wb_env extends uvm_env;
    `uvm_component_utils(wb_env)

    wb_agent agent;

    function new(string name = "wb_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Build_phase", "Build phase of testbench/env is being executed.", UVM_LOW);
        agent = wb_agent::type_id::create("agent", this);
    endfunction

endclass