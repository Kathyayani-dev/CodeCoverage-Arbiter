# code for tb_interface.v
  ...
     module tb_userinterface;

                //Signal Declaration
                reg bfm_clk;
                reg [3:0] bfm_command;

                wire bfm_grant;

                //BFM commands Declaration
                parameter NOREQ    = 4'B0001,
                                                        REQFA    = 4'B0010,
                                                        REQFB    = 4'B0011,
                                                        REQFC    = 4'B0100,
                                                        ATCAB    = 4'B0101,
                                                        ATCBC    = 4'B0110,
                                                        ATCCA    = 4'B0111,
                                                        SACC     = 4'B1000,
                                                        ATCAC    = 4'B1001,
                                                        ATCBA    = 4'B1010,
                                                        ATCCB    = 4'B1011;


                parameter CYCLE = 50;

                //BFM Instantiation
                bfm_arbiter BFM1 (bfm_clk,
                                                                                        bfm_command,
                                                                                        bfm_grant);

                //Clock Generation
                always
                        begin
                                #(CYCLE/2);
                                bfm_clk = 1'b0;
                                #(CYCLE/2);
                                bfm_clk = 1'b1;
                        end

                //Applying Commands
                initial
                        begin
                                BFM1.syn_reset;

                                bfm_command = NOREQ;
                                @(posedge bfm_grant);

                                bfm_command = REQFA;
                                @(posedge bfm_grant);

                                bfm_command = REQFB;
                                @(posedge bfm_grant);

                                bfm_command = REQFC;
                                @(posedge bfm_grant);

                                bfm_command = SACC;
                                @(posedge bfm_grant);

                                bfm_command = ATCAB;
                                @(posedge bfm_grant);

                                bfm_command = ATCBC;
                                @(posedge bfm_grant);

                                bfm_command = ATCCA;
                                @(posedge bfm_grant);

                                //NEW

                                bfm_command = ATCAC;
                                @(posedge bfm_grant);

                                bfm_command = ATCBA;
                                @(posedge bfm_grant);

                                //NEW

                                bfm_command = ATCAC;
                                @(posedge bfm_grant);

                                bfm_command = ATCBA;
                                @(posedge bfm_grant);

                                bfm_command = ATCCB;
                                @(posedge bfm_grant);


                                BFM1.set_acc(8'b01010101);
                                BFM1.set_acc(8'b00000000);
                                BFM1.set_acc(8'b11111111);
                                BFM1.DUT1.count=8'b00000000;
                                BFM1.DUT1.count=8'b11111111;
                                BFM1.syn_reset;

                                $display("\n ****** Simulation Complete ********** \n");
                                $stop;
                        end

        endmodule

...
