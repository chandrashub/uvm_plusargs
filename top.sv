`ifndef TOP__SV
`define TOP__SV
module top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import mbp_pkg::*;
  
  initial begin
    mbp_packet m_packet0;
    mbp_packet m_packet1;
    ext_mbp_packet m_packet2;
    ext1_mbp_packet m_packet3;
    m_packet0 = new("m_packet0");
    m_packet1 = new("m_packet1");
    m_packet2 = new("m_packet2");
    m_packet3 = new("m_packet3");
    for(int i=0;i<1;i++) begin
      if(!m_packet0.randomize()) begin
        `uvm_fatal("top","Failed to randomize m_packet")
      end
      if(!m_packet1.randomize()) begin
        `uvm_fatal("top","Failed to randomize m_packet")
      end
      if(!m_packet2.randomize()) begin
        `uvm_fatal("top","Failed to randomize m_packet")
      end
      if(!m_packet3.randomize()) begin
        `uvm_fatal("top","Failed to randomize m_packet")
      end
      `uvm_info("top",$sformatf(" packet0 %0s",m_packet0.sprint()),UVM_MEDIUM)
      `uvm_info("top",$sformatf(" packet1 %0s",m_packet1.sprint()),UVM_MEDIUM)
      `uvm_info("top",$sformatf(" packet2 %0s",m_packet2.sprint()),UVM_MEDIUM)
      `uvm_info("top",$sformatf(" packet3 %0s",m_packet3.sprint()),UVM_MEDIUM)
      if($test$plusargs("test"))
       `uvm_info("top","test",UVM_MEDIUM)
    end
  end
endmodule //top

`endif//TOP__SV
