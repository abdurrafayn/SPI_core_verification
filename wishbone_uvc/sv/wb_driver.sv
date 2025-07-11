class wb_driver extends uvm_driver #(wb_packet);

    virtual wishbone_intf wb_vif;

    `uvm_component_utils(wb_driver)

    function new(string name = "wb_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_HIGH);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual wishbone_intf)::get(this, "", "vif", wb_vif))
        `uvm_fatal("NOVIF","Virtual Interface Not set")
    endfunction: build_phase

    
    task run_phase(uvm_phase phase);
        wb_packet pkt;
        forever begin
            req = new("req");
            seq_item_port.get_next_item(req);
            `uvm_info("master_driver", "driving master", UVM_LOW)
            //send_to_dut();
                wb_vif.cyc_i = 1;
                wb_vif.stb_i = 1;
                wb_vif.adr_i = pkt.add_i;
                wb_vif.we_i = pkt.we_i;
                wb_vif.dat_i = pkt.dat_i;
            seq_item_port.item_done();
        end
    endtask //

endclass
