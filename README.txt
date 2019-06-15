Title - OSPF
The instructions given below describe the naming conventions of the vhd files, their functions and how to run the respective testbench. The code was quite extensive, hence was not possible to be written as a single module. Thus it has been divided accross a large no. of modules as given below.

1) At the port there runs a Parser machine. This reads in the incoming packets, does appropriate processing and passes them on to the respective modules where they are needed.
File in which implemented --> message_parser.vhd
Testbench for this --> parsertb.vhd

2) Then there is another parser come ack generator that picks out LSU packets and generate acks and passes on LSAs for updating db
Code File --> LSU_parser.vhd
Testbench --> lsu_parser_tb.vhd
Note :- there is also lsup_tb2.vhd combining the above 2 modules

3) There is an interfaceOutput machine that takes in packets (LSA's or LSA Acks (as generated above)) from a queue and gives them as output (acting like a sort of arbiter and after appending appropriate headers)
Code File --> interfaceOut.vhd
Testbench --> iface_out_tb.vhd

4) Generating hello messages periodically
Code File --> helloalive.vhd
Testbench --> tb_helloalive.vhd

5) Spontaneous LSA generation by self
Code File --> lsugen.vhd
Testbench --> LSUGEN_TB.vhd

6) Generating LSU corresponding to incoming LSRs
Code File --> lsraction.vhd
Testbench --> lsraction_tb.vhd

7) Generating LSR's from generated LSA headers
Code File --> lsr_gen.vhd
Testbench --> LSUGEN_TB.vhd

8) Implementing Dijkstra
Code File --> Dijkstra.vhd
Testbench --> Dijkstra_tb.vhd

9) Flooding the packets given
Code File --> FloodingFSM.vhd
Testbench --> merged with LSUM_TB

10) Handling the dbd exchange process
Code File --> NeighbourMachine.vhd
Testbench --> NeighbourMachineTb.vhd

11) Updates Database depending on LSAs
Code File --> LinkStateUpdateMachine.vhd
Testbench --> LSUM_tb.vhd

MainModule.vhd --> Integrates and maps all modules
tb_Main_Machine.vhd --> correspnding tb


