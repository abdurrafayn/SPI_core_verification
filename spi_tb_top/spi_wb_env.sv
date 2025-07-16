class spi_wb_env extends uvm_env;
    `uvm_component_utils(spi_wb_env)

    wb_env wishbone;
    spi_env spi;
    spi_scoreboard top_scoreboard;
    top_sequencer top_seqr;

    function new(string name = "spi_wb_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Build_phase", "Build phase of testbench/env is being executed.", UVM_LOW);
        wishbone = wb_env::type_id::create("wishbone", this);
        spi = spi_env::type_id::create("spi", this);
        top_scoreboard = spi_scoreboard::type_id::create("top_scoreboard", this);
        top_seqr = top_sequencer::type_id::create("top_seqr", this);

    endfunction

    function void connect_phase(uvm_phase phase);

    wishbone.agent.monitor.wishbone_pkt_port.connect(top_scoreboard.wish_spi);
    spi.agent.monitor.spi_pkt_port.connect(top_scoreboard.slave_spi);
    top_sequencer.wish_spi = wishbone.agent.sequencer;
    top_sequencer.slave_spi = spi.agent.sequencer;

    endfunction: 

endclass