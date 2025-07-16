module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wb_pkg::*;
    `include "spi_env.sv"
    `include "wb_test.sv"

    logic clk;
    logic rst;


    wishbone_intf w_vif(.clk_i(clk), .rst_i(rst));

    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
    rst = 1;
    #10;
    rst = 0;
    end

    initial begin
        uvm_config_db#(virtual wishbone_intf)::set(null,"*","vif", w_vif);
        run_test("base_test");
    end


endmodule: top