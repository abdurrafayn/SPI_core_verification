class wb_sequence extends uvm_sequence #(wb_pkg);

    `uvm_component_utils(wb_sequence)


    function new(string name = "wb_sequence", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
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