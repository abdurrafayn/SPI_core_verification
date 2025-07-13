class wb_agent extends uvm_agent;

    `uvm_component_utils(wb_agent)

    function new(string name = "wb_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    wb_driver driver;
    wb_sequencer sequencer;
    wb_monitor monitor;

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Agent simulation ....", UVM_HIGH);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        monitor = wb_monitor::type_id::create("monitor", this);
        sequencer = wb_sequencer::type_id::create("sequencer", this);
        driver = wb_driver::type_id::create("driver", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass