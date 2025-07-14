class spi_driver extends uvm_driver #(spi_packet);

    `uvm_component_utils(spi_driver)

    virtual spi_intf spi_vif;

    function new(string name = "spi_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_HIGH);
    endfunction

    function void build_phase(uvm_phase phsae);
        `uvm_info(get_type_name(), "Build Phase of driver", UVM_LOW)
        if (!uvm_config_db#(virtual spi_intf)::get(this, "", "vif", spi_vif))
      `uvm_fatal("NOVIF", "SPI virtual interface not set")
    endfunction

    task run_phase(uvm_phase phase);
        spi_packet req;
        forever begin
            seq_item_port.get_next_item(req);
            req.data_out = 8'hFF;
            //wait (spi_vif.ss_o[0] == 0);
            `uvm_info(get_type_name(), $sformatf("Sending SPI byte: %h", req.data_out), UVM_LOW)
                for (int i = 7; i>= 0 ;i-- ) begin
                    @(posedge spi_vif.sck_o);
                    spi_vif.miso_i = req.data_out[i];
                `uvm_info("master_driver", "driving master", UVM_LOW)                    
                end
            seq_item_port.item_done();
        end
    endtask //
endclass

