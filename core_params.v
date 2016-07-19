`ifndef CORE_PARAMS
`define CORE_PARAMS

`define PCIE_DSN   64'h0305

/////////////////////////////////////////////////////
///////// macros below MUST not be changed by user
/////////////////////////////////////////////////////
`define PCIE_GEN_DCLK
`define DMAC_ASYN_RST

`define PCIEX4

`ifdef PCIEX4
 `define PCIE_LINK_WIDTH    4
 `define TRN_DAT_WID        64
 `define TRN_REM_WID        1
`endif


  // FPGA block memory parameters
`define FPGA_BRAM_SP    0
`define FPGA_BRAM_SDP   1
`define FPGA_BRAM_TDP   2
`define FPGA_BRAM_NBE   0
`define FPGA_BRAM_BE    1

  // FPGA distributed memory parameters
`define FPGA_DRAM_SP    0
`define FPGA_DRAM_SDP   1
`define FPGA_DRAM_TDP   2
`define FPGA_DRAM_NREG  0
`define FPGA_DRAM_REG   1
  
`endif //  `ifndef CORE_PARAMS
