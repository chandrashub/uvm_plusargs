`ifndef MBP_PKG__SV
`define MBP_PKG__SV
package mbp_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `define  SET_CONST(T) \
    constraint T``_const { if(p_args.exists(`"T`")) { if(p_args[`"T`"].size() > 0) { T inside { p_args[`"T`"]};}}} \
    constraint T``_const_min { if(p_args_min.exists(`"T`")) { if(p_args_min[`"T`"].size() > 0 && p_args_max[`"T`"].size() > 0) { \
      foreach(p_args_min[s,i]) { if(s == `"T`") { T  inside {[p_args_min[s][i]:p_args_max[s][i]]};}}}}}


  class mbp_packet extends uvm_sequence_item;
    rand int m_addr;
    rand int m_data;
    rand int m_length;
    //These are the queues to which +args gets added. Needed to be define in the base class
    int p_args[string][$];
    int p_args_min[string][$];
    int p_args_max[string][$];
    //
    `uvm_object_utils_begin(mbp_packet)
      `uvm_field_int(m_addr,UVM_DEFAULT)
      `uvm_field_int(m_data,UVM_DEFAULT)
      `uvm_field_int(m_length,UVM_DEFAULT)
    `uvm_object_utils_end

    // Constraints added to data and addr
    `SET_CONST(m_data)
    `SET_CONST(m_addr)

    function new(string name="mbp_packet");
      super.new(name);
      `uvm_info("new",$psprintf("name %0s",name),UVM_MEDIUM)
    endfunction : new 

    function void pre_randomize();
      //Need to add this to register the datatype to arg_assoc array
      set_attr("m_data");
      set_attr("m_addr");
    endfunction : pre_randomize

    // set_addr sets the queues based on +args passes needs to be added to base class. Needs to be defined once in base class
    function void set_attr(string s_attr);
      uvm_cmdline_processor m_clp;
      string myargs[$];
      string myargs_get_name[$];
      string myargs_get_type[$];
      string myargs_min[$];
      string myargs_get_name_min[$];
      string myargs_get_type_min[$];
      string myargs_max[$];
      string myargs_get_name_max[$];
      string myargs_get_type_max[$];
      string gname;
      string gtype;
      string attr;
      string gname_min;
      string gtype_min;
      string attr_min;
      string gname_max;
      string gtype_max;
      string attr_max;
      m_clp = new();
      attr = $sformatf("+%0s=",s_attr);
      gname = $sformatf("+%0s_%0s=",get_name(),s_attr);
      gtype = $sformatf("+%0s_%0s=",get_type_name(),s_attr);
      attr_min = $sformatf("+%0s_min=",s_attr);
      gname_min = $sformatf("+%0s_%0s_min=",get_name(),s_attr);
      gtype_min = $sformatf("+%0s_%0s_min=",get_type_name(),s_attr);
      attr_max = $sformatf("+%0s_max=",s_attr);
      gname_max = $sformatf("+%0s_%0s_max=",get_name(),s_attr);
      gtype_max = $sformatf("+%0s_%0s_max=",get_type_name(),s_attr);
      `uvm_info(get_name(),$psprintf("%0s %0s %0s %0s %0s %0s %0s %0s %0s",attr,gname,gtype,attr_min,gname_min,gtype_min,attr_max,gname_max,gtype_max),UVM_MEDIUM)
      if(m_clp.get_arg_values(attr,myargs)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",attr,myargs.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gname,myargs_get_name)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gname,myargs_get_name.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gtype,myargs_get_type))
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gtype,myargs_get_type.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(attr_min,myargs_min)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",attr_min,myargs_min.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gname_min,myargs_get_name_min)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gname_min,myargs_get_name_min.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gtype_min,myargs_get_type_min))
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gtype_min,myargs_get_type_min.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(attr_max,myargs_max)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",attr_max,myargs_max.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gname_max,myargs_get_name_max)) 
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gname_max,myargs_get_name_max.size()),UVM_DEBUG)
      if(m_clp.get_arg_values(gtype_max,myargs_get_type_max))
        `uvm_info(get_name,$psprintf("attr %0s myargs %0d ",gtype_max,myargs_get_type_max.size()),UVM_DEBUG)

      myargs = { myargs, myargs_get_name , myargs_get_type };
      if(myargs.size() >0) begin
        for(int i=0;i<myargs.size;i++) begin
          `uvm_info("1",$psprintf("arg %0s",myargs[i]),UVM_MEDIUM)
          p_args[s_attr].push_back(myargs[i].atohex());
        end
        for(int i=0;i<p_args[s_attr].size();i++) begin
          `uvm_info(get_name(),$psprintf("val %0s %0h",s_attr,p_args[s_attr][i]),UVM_MEDIUM)
        end
      end
      myargs_min = { myargs_min, myargs_get_name_min , myargs_get_type_min };

      if(myargs_min.size() > 0) begin
        for(int i=0;i<myargs_min.size;i++) begin
          `uvm_info("1",$psprintf("arg %0s",myargs_min[i]),UVM_MEDIUM)
          p_args_min[s_attr].push_back(myargs_min[i].atohex());
        end
        for(int i=0;i<p_args_min[s_attr].size();i++) begin
          `uvm_info(get_name(),$psprintf("min %0s %0h",s_attr,p_args_min[s_attr][i]),UVM_MEDIUM)
        end
      end 
      myargs_max = { myargs_max, myargs_get_name_max , myargs_get_type_max };
      if(myargs_max.size() > 0) begin
        for(int i=0;i<myargs_max.size;i++) begin
          `uvm_info("1",$psprintf("arg %0s",myargs_max[i]),UVM_MEDIUM)
          p_args_max[s_attr].push_back(myargs_max[i].atohex());
        end
        for(int i=0;i<p_args_max[s_attr].size();i++) begin
          `uvm_info(get_name(),$psprintf("max %0s %0h",s_attr,p_args_max[s_attr][i]),UVM_MEDIUM)
        end
      end
      if(myargs_max.size() != myargs_min.size())  `uvm_fatal(get_name,$psprintf(" both _min and _max  +args should be defined"))
    endfunction : set_attr 
  endclass : mbp_packet

  class ext1_mbp_packet extends mbp_packet;
    rand int err1;
    rand int sec1;
    `uvm_object_utils_begin(ext1_mbp_packet)
      `uvm_field_int(err1,UVM_DEFAULT)
      `uvm_field_int(sec1,UVM_DEFAULT)
    `uvm_object_utils_end
    //Constraint macro for new datatypes added
    `SET_CONST(err1)
    `SET_CONST(sec1)

    function new(string name="ext1_mbp_packet");
      super.new(name);
    endfunction : new 
     
    function void pre_randomize();
      super.pre_randomize();
      //Registering the datatypes to the arglist
      set_attr("err1");
      set_attr("sec1");
    endfunction : pre_randomize

  endclass : ext1_mbp_packet

  class ext_mbp_packet extends mbp_packet;
    rand int err;
    rand int sec;
    `uvm_object_utils_begin(ext_mbp_packet)
      `uvm_field_int(err,UVM_DEFAULT)
      `uvm_field_int(sec,UVM_DEFAULT)
    `uvm_object_utils_end
    //Constraint macro for new datatypes added
    `SET_CONST(err)
    `SET_CONST(sec)

    function new(string name="ext_mbp_packet");
      super.new(name);
    endfunction : new

    function void pre_randomize();
      super.pre_randomize();
      `uvm_info(get_name,$psprintf("pre_randomize %0s %0s",get_name(),get_type_name()),UVM_MEDIUM)
      set_attr("err");
      set_attr("sec");
    endfunction : pre_randomize
  endclass : ext_mbp_packet
endpackage
`endif//MBP_PKG__SV
