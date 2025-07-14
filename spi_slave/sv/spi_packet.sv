typedef enum { WRITE, READ, IDLE} spi_packet_e;

class spi_packet extends uvm_sequence_item;

rand bit [7:0] data_out;
bit [7:0] data_in;
bit [1:0] ss_o;
rand bit miso_i;
bit mosi_o;

`uvm_object_utils_begin(spi_packet)
    `uvm_field_int(data_out, UVM_ALL_ON)
    `uvm_field_int(data_in, UVM_ALL_ON)
    `uvm_field_int(ss_o, UVM_ALL_ON)
    `uvm_field_int(mosi_i, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name = "spi_packet");
    super.new(name);
endfunction


endclass
