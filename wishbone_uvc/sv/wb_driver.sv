class wb_driver extends uvm_driver #(wb_packet);

    `uvm_component_utils(wb_driver)

    function new(string name = "wb_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_HIGH);
    endfunction

    // task run_phase(uvm_phase phase);
    //     forever begin
    //         seq_item_port.get_next_item(req);
    //         `uvm_info("master_driver", "driving master", UVM_LOW)
    //         send_to_dut();
    //         seq_item_port.item_done();
    //     end
    // endtask //

endclass