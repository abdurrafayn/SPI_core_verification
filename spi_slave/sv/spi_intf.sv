interface spi_intf();
  // SPI port
  
  logic         sck_o;
  logic  [1:0]   ss_o;           // slave select (active low)
  logic        mosi_o;        // MasterOut SlaveIN
  logic        miso_i;        // MasterIn SlaveOut
endinterface