module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wb_pkg::*;
    `include "wb_env.sv"
    `include "wb_test.sv"

    wb_packet w1;
    bit ok;

    initial begin
        w1 = new ("w1");
        
        repeat(5) begin
        ok = w1.randomize();
        assert (ok) else $display("RANDOMIZE FAILED");
        w1.print();
        end

        run_test("base_test");
    end


endmodule