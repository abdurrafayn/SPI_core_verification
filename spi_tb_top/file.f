-incdir ../wishbone_uvc/sv
-incdir ../spi_uvc/sv

-incdir ../wishbone_uvc/tb

../wishbone_uvc/sv/wb_pkg.sv
../spi_uvc/sv/spi_pkg.sv


./interface.sv
./top.sv

+UVM_TESTNAME=new_test
+UVM_VERBOSITY=UVM_HIGH