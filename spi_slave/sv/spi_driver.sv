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

    endfunction

    task run_phase(uvm_phase phase);
        spi_packet req;
        forever begin
            seq_item_port.get_next_item(req);
            wait (spi_vif.ss_o[0] == 0);
                for (int i = 7; i>= 0 ;i-- ) begin
                     @(negedge spi_vif.sck.o);
                    spi_vif.miso_i = req.miso_i[i];
                `uvm_info("master_driver", "driving master", UVM_LOW)                    
                end
               
            seq_item_port.item_done();
        end
    endtask //

endclass

