module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wb_pkg::*;
    import spi_pkg::*;

    // `include "interface.sv"
    `include "spi_wb_env.sv"
    `include "wb_test.sv"
    `include "top_sequence.sv"
    `include "top_sequencer.sv"
    `include "spi_scoreboard.sv"

    logic clk,rst;

    wishbone_intf w_vif(clk, rst);
    spi_intf s_vif;
    

    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
    rst = 1;
    #10;
    rst = 0;
    end

    simple_spi dut (
    .clk_i(clk),      
    .rst_i(w_vif.rst_i),      
    .cyc_i(w_vif.cyc_i),        
    .stb_i(w_vif.stb_i),         
    .adr_i(w_vif.adr_i),         
    .we_i(w_vif.we_i),         
    .dat_i(w_vif.dat_i),        
    .dat_o(w_vif.dat_o),        
    .ack_o(w_vif.ack_o),         
    .inta_o(w_vif.inta_o),    

    .sck_o(s_vif.sck_o),        
    .ss_o(s_vif.ss_o),     
    .mosi_o(s_vif.mosi_o),       
    .miso_i(s_vif.miso_i)      
    );


    initial begin
        uvm_config_db#(virtual wishbone_intf)::set(null, "*", "vif", tb_intf);
        uvm_config_db#(virtual spi_intf)::set(null, "*", "vif", tb_intf);
        run_test("base_test");
    end
endmodule