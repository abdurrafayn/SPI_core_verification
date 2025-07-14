class base_test extends uvm_test;
    `uvm_component_utils(base_test)

        function new(string name= "base_test", uvm_component parent);
            super.new(name, parent);
        endfunction

        spi_wb_env spi_wb;
    

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        spi_wb = new("spi_wb", this);
        `uvm_info("Test phase", "Build phase of test is being executed", UVM_LOW);
        // wb_environment = wb_env::type_id::create("wb_environment", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction
    

endclass