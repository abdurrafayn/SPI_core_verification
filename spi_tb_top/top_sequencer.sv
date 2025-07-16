class top_sequencer extends uvm_sequencer;
    `uvm_component_utils(mcsequencer)

    wb_sequencer wish_spi;
    spi_sequencer slave_spi;

    function new (string name = "mcsequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation ...", UVM_HIGH);
    endfunction: start_of_simulation_phase

endclass