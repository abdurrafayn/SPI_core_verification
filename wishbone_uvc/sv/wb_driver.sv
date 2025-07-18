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
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), "Starting Wishbone transaction", UVM_LOW)

      case (req.operation)
        WRITE: do_write(req);
        READ:  do_read(req);
        default: do_idle();
      endcase

      seq_item_port.item_done();
      `uvm_info(get_type_name(), $sformatf("Driver Packet:\n%s", req.sprint()), UVM_HIGH)
    end
    endtask


    // task run_phase(uvm_phase phase);
    //     wb_packet pkt;
    //     forever begin
    //         seq_item_port.get_next_item(req);
    //         // `uvm_info(get_type_name(), $sformatf("Driving transaction: addr=%0h, data=%0h, we=%0b",
    //         //                                req.add_i, req.dat_i, req.we_i), UVM_LOW)
    //         //req = new("req");
    //         `uvm_info("master_driver", "driving master /n", UVM_LOW)
    //         `uvm_info("master_driver", "***************************", UVM_LOW)
    //         //send_to_dut();
    //         @(posedge wb_vif.clk_i)
    //             wb_vif.cyc_i = 1;
    //             wb_vif.stb_i = 1;
    //             wb_vif.adr_i = req.add_i;
    //             wb_vif.we_i = req.we_i;
    //             wb_vif.dat_i = req.dat_i;
    //         seq_item_port.item_done();
    //         `uvm_info(get_type_name(), $sformatf("Driver Packet: \n%s", req.sprint()), UVM_HIGH)
    //     end
    // endtask //


    task do_write(wb_packet pkt);
        @(posedge wb_vif.clk_i);
            wb_vif.cyc_i <= 1;
            wb_vif.stb_i <= 1;
            wb_vif.adr_i <= pkt.add_i;
            wb_vif.we_i  <= 1;
            wb_vif.dat_i <= pkt.dat_i;

        @(posedge wb_vif.ack_o);
            @(posedge wb_vif.clk_i);
                wb_vif.cyc_i <= 0;
                wb_vif.stb_i <= 0;
                wb_vif.we_i  <= 0;
    endtask

  // ---------------------------------------------------------
  // Read TASK
  task do_read(wb_packet pkt);
    @(posedge wb_vif.clk_i);
        wb_vif.cyc_i <= 1;
        wb_vif.stb_i <= 1;
        wb_vif.adr_i <= pkt.add_i;
        wb_vif.we_i  <= 0;

    @(posedge wb_vif.ack_o);
        @(posedge wb_vif.clk_i);
            pkt.dat_o = wb_vif.dat_o;

            wb_vif.cyc_i <= 0;
            wb_vif.stb_i <= 0;
  endtask

  // ***********************************************************************************8
  // IDLE TASk
  task do_idle();
    `uvm_info(get_type_name(), "IDLE Operation. No wishbone activity.", UVM_MEDIUM)
    @(posedge wb_vif.clk_i);
        wb_vif.cyc_i <= 0;
        wb_vif.stb_i <= 0;
        wb_vif.adr_i <= pkt.add_i;
        wb_vif.we_i  <= 1;
        wb_vif.dat_i <= pkt.dat_i;
  endtask

endclass
