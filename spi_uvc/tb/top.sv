module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import spi_pkg::*;
    `include "spi_env.sv"
    `include "spi_test.sv"

    spi_packet w1;
    bit ok;

    initial begin
        s1 = new ("s1");
        
        repeat(5) begin
        ok = s1.randomize();
        assert (ok) else $display("RANDOMIZE FAILED");
        s1.print();
        end

        run_test("base_test");
    end


endmodule