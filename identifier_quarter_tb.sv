`include "identifier_quarter.sv"

module identifier_quarter_tb
#(
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH = 22
);

// Промежуточные переменные
reg clk;
reg rst;
reg enable;
//reg data_in;
reg signed [PHI_WIDTH-1:0] phi_veer_i;

wire [PHI_WIDTH-1:0] phi_o;
wire [1:0] quarter_o;
wire done;

identifier_quarter temp ( 
  .clk(clk), .rst(rst), 
  .enable(enable), .phi_veer_in(phi_veer_i),
  .phi_veer_out(phi_o), .quarter(quarter_o), .done(done)
);

integer i;
initial begin
  #1
  rst = 1'b1;
  clk = 1'b0;
  enable = 1'b1;
  #1 rst = 1'b0;
  /*
  phi_veer_i = 22'b0000110111000000000000; #1 // 55
  for (i = 0; i < 10; i = i + 1)
    begin
      #10 clk = ~clk; 
      if (done) begin
        $display("done: %b, \tquarter: %b", done, quarter_o);
        $display("Phi_in: %b.%b \tPhi_out:%b.%b", phi_veer_i[PHI_WIDTH-1:12], phi_veer_i[11:0],
                                                  phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
        $display("-----------------------------------------");
      end
    end
  */
  /*
  phi_veer_i = 22'b1000110111000000000010; #1 // -55
  for (i = 0; i < 10; i = i + 1)
    begin
      #10 clk = ~clk; 
      //if (done) begin
        $display("done: %b, \tquarter: %b", done, quarter_o);
        $display("Phi_in: %b.%b \tPhi_out:%b.%b", phi_veer_i[PHI_WIDTH-1:12], phi_veer_i[11:0],
                                                  phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
        $display("-----------------------------------------");
      //end
    end
    */

  phi_veer_i = 22'b1001011111000000000010; #1 // 95
  //phi_veer_i = 22'b1000100100000000000000; #1 // -36
  for (i = 0; i < 10; i = i + 1)
    begin
      #10 clk = ~clk; 
      //if (done) begin
        $display("done: %b, \tquarter: %b", done, quarter_o);
        $display("Phi_in: %b.%b \tPhi_out:%b.%b", phi_veer_i[PHI_WIDTH-1:12], phi_veer_i[11:0],
                                                  phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
        $display("-----------------------------------------");
      //end
    end

    $finish;
end

  initial begin
    $dumpvars;
  end
endmodule