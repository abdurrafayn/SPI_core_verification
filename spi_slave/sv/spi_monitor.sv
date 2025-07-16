class spi_monitor extends uvm_monitor;

    `uvm_component_utils(spi_monitor)

    uvm_analysis_port#(spi_packet) spi_pkt_port;

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
            pkt = slave_packet::type_id::create("Mon_slave_pkt", this);
            in_dex = 7;
       
            while(bit_count = 8) begin
              
            @(posedge spi_vif.sck_o) 
            #1ns
               pkt.data_in[in_dex] = spi_vif.mosi_o;
                //pkt.data_out[in_dex] = spi_vif.mosi_o;
                // pkt.miso_i = spi_vif.miso_i;
                //pkt.mosi_o = spi_vif.mosi_o;
                in_dex--;
                bit_count++;
            end       
                `uvm_info("master_Monitor", "driving master", UVM_LOW)
        end
        spi_pkt_port.write(pkt);
    endtask //

    function void connect_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual spi_vif)::get(this, "", "vif", spi_vif))
        `uvm_fatal("NOVIF", "VIF in SPI_SLAVE MONITOR is NOT SET")
    endfunction

endclass

