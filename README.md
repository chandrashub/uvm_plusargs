# uvm_plusargs
# This project illustrates on how to setup the base level classes and macros to use the +arg control to all variables in a class/transaction item.
# Also shown on how the +args control can be filtered based on name, type_nam and instance name , to provide more controllability.
# The Readme demos the +args control on a variable in the class called m_addr
# +m_addr_min = 2000 //sets constraint on m_addr to be more than or equal to 2000
# +m_addr_max = 3000 //sets constraint on m_addr to be less than or equal to 3000
# +m_packet0_m_addr = 2000 // sets m_addr in the instance "m_packet0" to 2000
# +m_packet1_m_addr = 2000 // sets m_addr in the instance "m_packet1" to 2200
# +ext_mbp_packet_m_addr = 2210 // sets m_addr in the type of object "ext_mbp_packet" to 2000
# +ext1_mbp_packet_m_addr = 2220 // sets m_addr in the type of object "ext1_mbp_packet" to 2000

#The README is optimized to run on Mentor QuestaSim. Please update the run cmd if running on other simulators.


