class base_test extends uvm_test;
    `uvm_component_utils(base_test)

        function new(string name= "base_test", uvm_component parent);
            super.new(name, parent);
        endfunction

        spi_env spi;
    

    function void build_phase(uvm_phase phase);
        
        uvm_config_wrapper::set(this, "spi.wishbone.agent.sequencer.run_phase", "default_sequence", new_test_seq::get_type());
        spi = spi_env::type_id::create("spi", this);

        `uvm_info("Test phase", "Build phase of test is being executed", UVM_LOW);
        super.build_phase(phase);
        
        // wb_environment = wb_env::type_id::create("wb_environment", this);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction
    
endclass: base_test