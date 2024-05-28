`include "cordic_proc.sv"
`timescale 10ns/1ns

module cordic_proc_tb
#(
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH = 22
);

// Промежуточные переменные
reg clk;
reg rst;
reg enable;
reg data_in;
// Входы и выходы сопроцессора
reg signed  [DATA_WIDTH-1:0] x_i, y_i;
reg signed  [PHI_WIDTH-1:0]  phi_i;
wire signed [DATA_WIDTH-1:0] x_o, y_o;
wire signed [PHI_WIDTH-1:0]  phi_o;
wire        [1:0]            quart;
wire data_ready;

cordic_proc temp (
  .clk(clk), .rst(rst), 
  .enable(enable), //.data_in(data_in),
  .x_i(x_i), .y_i(y_i), .phi_i(phi_i),
  .x_o(x_o), .y_o(y_o), .phi_o(phi_o),
  .quart(quart), .data_ready(data_ready)
);

integer i;
initial begin
  #1
  clk = 1'b0;
  rst = 1'b1;
  enable = 1'b1;
  //data_in = 1'b0;
  #1 
  rst = 1'b0;
  //--------------------------------------

  x_i   = 20'b00000011000000000000;    // 3
  y_i   = 20'b00000000000000000000;    // 0
  //phi_i = 22'b1000100100000000000000;  // -36
  phi_i = 22'b0001011111000000000000;  // 95
  //data_in = 1'b1;
  for (i = 0; i < 80; i = i + 1)
  begin
    #1 clk = ~clk; 
    if (data_ready) begin
      $display("X_in: %b.%b, \tY_in: %b.%b, \tPhi_in: %b.%b", 
                                                              x_i[DATA_WIDTH-1:12], x_i[11:0], 
                                                              y_i[DATA_WIDTH-1:12], y_i[11:0], 
                                                              phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              x_o[DATA_WIDTH-1:12], x_o[11:0], 
                                                              y_o[DATA_WIDTH-1:12], y_o[11:0], 
                                                              phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
      $display("quart: %b", quart);
      $display("-----------------------------------------");
    end
  end
  // ------------------------
  /*
  //rst = 1'b1;
  //#1 rst = 1'b0;
  x_i   = 20'b00000001000000000000;    // 1
  y_i   = 20'b00000000000000000000;    // 0
  phi_i = 22'b1001011111000000000000;  // -95
  //data_in = 1'b1;
  for (i = 0; i < 80; i = i + 1)
  begin
    #1 clk = ~clk; 
    if (data_ready) begin
      $display("X_in: %b.%b, \tY_in: %b.%b, \tPhi_in: %b.%b", 
                                                              x_i[DATA_WIDTH-1:12], x_i[11:0], 
                                                              y_i[DATA_WIDTH-1:12], y_i[11:0], 
                                                              phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              x_o[DATA_WIDTH-1:12], x_o[11:0], 
                                                              y_o[DATA_WIDTH-1:12], y_o[11:0], 
                                                              phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
      $display("quart: %b", quart);
      $display("-----------------------------------------");
    end
  end
  //------------------------------------

  x_i   = 20'b00000001000000000000;    // 1
  y_i   = 20'b00000000000000000000;    // 0
  phi_i = 22'b1000100100000000000000;  // -36
  //data_in = 1'b1;
  for (i = 0; i < 80; i = i + 1)
  begin
    #1 clk = ~clk; 
    if (data_ready) begin
      $display("X_in: %b.%b, \tY_in: %b.%b, \tPhi_in: %b.%b", 
                                                              x_i[DATA_WIDTH-1:12], x_i[11:0], 
                                                              y_i[DATA_WIDTH-1:12], y_i[11:0], 
                                                              phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              x_o[DATA_WIDTH-1:12], x_o[11:0], 
                                                              y_o[DATA_WIDTH-1:12], y_o[11:0], 
                                                              phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
      $display("quart: %b", quart);
      $display("-----------------------------------------");
    end
  end
  //-------------------------------------

  x_i   = 20'b00000001000000000000;    // 1
  y_i   = 20'b00000000000000000000;    // 0
  phi_i = 22'b0000100100000000000000;  // 36
  //data_in = 1'b1;
  for (i = 0; i < 80; i = i + 1)
  begin
    #1 clk = ~clk; 
    if (data_ready) begin
      $display("X_in: %b.%b, \tY_in: %b.%b, \tPhi_in: %b.%b", 
                                                              x_i[DATA_WIDTH-1:12], x_i[11:0], 
                                                              y_i[DATA_WIDTH-1:12], y_i[11:0], 
                                                              phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              x_o[DATA_WIDTH-1:12], x_o[11:0], 
                                                              y_o[DATA_WIDTH-1:12], y_o[11:0], 
                                                              phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
      $display("quart: %b", quart);
      $display("-----------------------------------------");
    end
  end
  */
end


initial begin
    $dumpvars;
  end
endmodule