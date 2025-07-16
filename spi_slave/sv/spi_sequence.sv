class spi_sequence extends uvm_sequence #(spi_packet);

    `uvm_object_utils(spi_sequence)


    function new(string name = "spi_sequence");
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
       `uvm_info(get_type_name(), "OBJECTION DROPPED", UVM_MEDIUM)
        end
    endtask : post_body

endclass

class new_test_seq extends wb_sequence;

    `uvm_object_utils(new_test_seq)

    // Constructor
    function new(string name="new_test_seq");
        super.new(name);
    endfunction

    // Sequence body definition
    task body();
        `uvm_info(get_type_name(), "Executing new_test_seq sequence in SPI SLave", UVM_LOW)
        repeat(5)
        `uvm_do(req)
    endtask
endclass

