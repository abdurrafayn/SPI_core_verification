class wb_monitor extends uvm_monitor;

    `uvm_component_utils(wb_monitor)

    function new(string name = "wb_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation in Monitor...", UVM_HIGH);
    endfunction

    // task run_phase(uvm_phase phase);
    //     forever begin
    //         `uvm_info("master_Monitor", "driving master", UVM_LOW)
    //     end
    // endtask //

endclass