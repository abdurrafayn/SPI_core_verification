class top_sequence extends uvm_sequence;
    `uvm_object_utils(top_sequence)

    function new (string name = "top_sequence");
        super.new(name);
    endfunction: new

    task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
    // in UVM1.2, get starting phase from method
        phase = get_starting_phase();
    `else
        phase = starting_phase;
    `endif
    if (phase != null) begin
        phase.raise_objection(this, get_type_name());
        `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
    endtask : pre_body

    task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
    // in UVM1.2, get starting phase from method
        phase = get_starting_phase();
    `else
        phase = starting_phase;
    `endif
    if (phase != null) begin
        phase.drop_objection(this, get_type_name());
        `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
    endtask : post_body

endclass

// Now writing main sequence that will run on wishbone and spi slave

class top_test extends top_sequence;

    `uvm_object_utils(top_test)
    `uvm_declare_p_sequencer(top_sequencer)


    basic_write_seq wr_spi;
    config_and_transfer_seq tr_spi;
    new_test_seq slave_spi;

    function new (string name = "top_test");
            super.new(name);
    endfunction: new

    task body();


            `uvm_do_on(wr_spi,p_sequencer)

            #40ns

        fork
            `uvm_do_on(tr_spi,p_sequencer)
            `uvm_do_on(slave_spi,p_sequencer)
        join

    endtask

endclass