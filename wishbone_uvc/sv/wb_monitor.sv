class wb_monitor extends uvm_monitor;
    virtual wishbone_intf wb_vif;

    `uvm_component_utils(wb_monitor)

    uvm_analysis_port#(wb_packet) wishbone_pkt_port;

    function new(string name = "wb_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation in Monitor...", UVM_HIGH);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual wishbone_intf)::get(this, "", "vif", wb_vif))
        `uvm_fatal("NOVIF","Virtual Interface Not set")
    endfunction: build_phase


    task run_phase(uvm_phase phase);
        wb_packet pkt;
        
        forever begin
            @(posedge wb_vif.clk_i);
            if (wb_vif.cyc_i && wb_vif.stb_i && wb_vif.ack_o) begin
                pkt = wb_packet::type_id::create("pkt", this);

                    pkt.add_i = wb_vif.adr_i;
                    pkt.we_i  = wb_vif.we_i;
                    pkt.dat_i = wb_vif.dat_i;
                    pkt.dat_o = wb_vif.dat_o;

                if (wb_vif.we_i)
                pkt.operation = WRITE;
                else
                pkt.operation = READ;

                `uvm_info(get_type_name(), $sformatf("Monitor Captured Packet:\n%s", pkt.sprint()), UVM_HIGH)
                wishbone_pkt_port.write(pkt);
            end
        end


        // forever begin

        //     pkt = wb_packet::type_id::create("pkt", this);
        //     //req = new("req");
        //     //seq_item_port.get_next_item(req);
        //     `uvm_info("master_Monitor", "driving monitor", UVM_LOW)
        //     //send_to_dut();
        //     @(posedge wb_vif.clk_i)
        //         wb_vif.cyc_i = 1;
        //         pkt.add_i = wb_vif.adr_i;
        //         pkt.we_i  = wb_vif.we_i;
        //         pkt.dat_i = wb_vif.dat_i;
        //         pkt.dat_o = wb_vif.dat_o;
        //     //seq_item_port.item_done();

        //     `uvm_info(get_type_name(), $sformatf("Monitor Packet: \n%s", pkt.sprint()), UVM_HIGH)
        //     // `uvm_info("MONITOR", $sformatf("Captured: addr=%0h, we=%0b, dat_i=%0h, dat_o=%0h",
        //     //                            pkt.add_i, pkt.we_i, pkt.dat_i, pkt.dat_o), UVM_LOW)
        // end
    endtask //
endclass