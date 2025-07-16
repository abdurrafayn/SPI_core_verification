class wb_sequence extends uvm_sequence #(wb_packet);

    `uvm_object_utils(wb_sequence)


    function new(string name = "wb_sequence");
        super.new(name);
    endfunction

    function void build_phase(uvm_phase phase);
        //super.new();
        `uvm_info("Build_phase", "Build phase of testbench/env is being executed.", UVM_LOW);
    endfunction

    task pre_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
        phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "OBJECTION RAISED", UVM_MEDIUM)
        end
    endtask : pre_body

    task post_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info(get_type_name(), "OBJECTION DROPPED", UVM_MEDIUM)
        end
    endtask : post_body

endclass


// **************************************************************************************************
//                                         Test 1                                                 
// **************************************************************************************************

class new_test_seq extends wb_sequence;

`uvm_object_utils(new_test_seq)

  // Constructor
  function new(string name="new_test_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  task body();
    `uvm_info(get_type_name(), "Executing new_test_seq sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask

endclass


// **************************************************************************************************
//                                         Test 2                                                 
// **************************************************************************************************

class basic_write_seq extends wb_sequence;
  `uvm_object_utils(basic_write_seq)

  function new(string name = "basic_write_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Starting basic_write_seq", UVM_LOW)

    `uvm_create(req)
    req.operation = WRITE;
    req.adr_i = 3'b010; // SPDR
    req.dat_i = 8'hA5;
    `uvm_send(req)

  endtask
endclass


// **************************************************************************************************
//                                         Test 3                                                 
// **************************************************************************************************


class multi_byte_write_seq extends wb_sequence;
  `uvm_object_utils(multi_byte_write_seq)

  function new(string name = "multi_byte_write_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Starting multi_byte_write_seq", UVM_LOW)

    bit [7:0] data_array[4] = {8'h11, 8'h22, 8'h33, 8'h44};

    foreach (data_array[i]) begin
      `uvm_create(req)
      req.operation = WRITE;
      req.adr_i = 3'b010; // SPDR
      req.dat_i = data_array[i];
      `uvm_send(req)
    end
  endtask
endclass

// **************************************************************************************************
//                                         Test 4                                                 
// **************************************************************************************************


class config_and_transfer_seq extends wb_sequence;
  `uvm_object_utils(config_and_transfer_seq)

  function new(string name = "config_and_transfer_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Starting config_and_transfer_seq", UVM_LOW)

    // Enabling SPI
    `uvm_create(req)
    req.operation = WRITE;
    req.adr_i = 3'b000; // SPCR
    req.dat_i = 8'b01010000; // SPE = 1, MSTR = 1, CPOL/CPHA = 0
    `uvm_send(req)

    // writing through SPDR
    `uvm_create(req)
    req.operation = WRITE;
    req.adr_i = 3'b010; // SPDR
    req.dat_i = 8'h5A;
    `uvm_send(req)

    #800; //some delay so that data completey transfer

    `uvm_create(req)
    req.operation = WRITE;
    req.adr_i = 3'b000; // SPCR
    req.dat_i = 8'b00000000;
    `uvm_send(req)
  endtask
endclass