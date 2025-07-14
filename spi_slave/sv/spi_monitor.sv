class spi_monitor extends uvm_monitor;

    `uvm_component_utils(spi_monitor)

    virtual wishbone_intf spi_vif; 
    


    function new(string name = "spi_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void start_of_elaboration_phase();
        `uvm_info(get_type_name(), "Running Simulation in Monitor...", UVM_HIGH);
    endfunction

    function void build_phase(uvm_phase phase)
        super.build_phase(phase);

        if(!uvm_config_db#(virtual wishbone_intf)::get(this, "", "vif", spi_vif))
        `uvm_fatal("NOVIF","Virtual Interface Not set")
    endfunction

    task run_phase(uvm_phase phase);

        spi_packet pkt;
        bit [7:0] shift_reg;
        int bit_count;

        forever begin
            // @(posedge spi_vif.clk_i);
            //     if (spi_vif.ss_o[0] == 0) begin
            //         shift_reg = 8'b0;
            //         bit_count = 0;

                while(bit_count = 8)
                 //@(posedge spi_intf.ss_o[0]== 0) begin
                    @(posedge spi_vif.sck_o);
                    shift_reg = {shift_reg[6:0], spi_vif.mosi_o};
                    bit_count++;

                if (bit_count == 8) begin
                    pkt = spi_packet::type_id::create("pkt", this);
                    pkt.mosi_o = shift_reg;
            end
        
            `uvm_info("master_Monitor", "driving master", UVM_LOW)
        end
                end
        //end
    endtask //

    function void connect_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual spi_vif)::get(this, "", "vif", spi_vif))
        `uvm_fatal("NOVIF", "VIF in SPI_SLAVE MONITOR is NOT SET")
    endfunction

endclass