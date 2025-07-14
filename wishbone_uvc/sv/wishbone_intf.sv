interface wishbone_intf(input logic clk_i, input logic rst_i);

  //logic        clk_i;         // clock
  //logic        rst_i;         // reset (synchronous active high)
  logic        cyc_i;         // cycle
  logic        stb_i;         // strobe
  logic  [2:0] adr_i;         // address
  logic        we_i;          // write enable
  logic  [7:0] dat_i;         // data input
  logic  [7:0] dat_o;         // data output
  logic        ack_o;         // normal bus termination
  logic        inta_o;        // interrupt output



endinterface