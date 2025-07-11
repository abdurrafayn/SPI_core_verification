typedef enum { WRITE, READ, IDLE} spi_packet_e;

class spi_packet extends uvm_sequence_item;

rand bit [7:0]  dat_i;
rand bit [1:0]  add_i;
rand bit        we_i;

bit [7:0]       dat_o;

`uvm_object_utils_begin(spi_packet)
    `uvm_field_int(dat_i, UVM_ALL_ON)
    `uvm_field_int(add_i, UVM_ALL_ON)
    `uvm_field_int(we_i, UVM_ALL_ON)
    `uvm_field_int(dat_o, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name = "spi_packet");
    super.new(name);
endfunction


endclass
