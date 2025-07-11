module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wb_pkg::*;
    import spi_pkg::*;

    `include "interface.sv"
    `include "spi_wb_env.sv"
    `include "wb_test.sv"


    wishbone_intf tb_intf;

    wb_packet w1;
    bit ok;

    initial begin


        w1 = new ("w1");
        repeat(5) begin
        ok = w1.randomize();
        assert (ok) else $display("RANDOMIZE FAILED...");
        w1.print();
        end
        uvm_config_db#(virtual wishbone_intf)::set(null, "*", "vif", "tb_intf")
        run_test("base_test");
    end


endmodule