`include "cordic_alg_block.sv"

module tb_cordic_conveer
#(
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH = 22,
  parameter COUNT = 10
);
  // Промежуточные переменные
  reg clk;
  reg rst;
  reg enable;
  reg data_in;
  // Входы и выходы конвеера
  reg signed [DATA_WIDTH-1:0] x_i, y_i;
  reg signed [PHI_WIDTH-1:0]  phi_i;
  wire signed [DATA_WIDTH-1:0] x_o, y_o;
  wire signed [PHI_WIDTH-1:0]  phi_o;
  wire data_ready;
  // Массив проводов соединяющий блоки самого конвеера
  wire signed [DATA_WIDTH-1:0] X   [COUNT+1:0];
  wire signed [DATA_WIDTH-1:0] Y   [COUNT+1:0];
  wire signed [PHI_WIDTH-1:0]  Phi [COUNT+1:0];
  wire done [COUNT+1:0];

  // Подключаем входы и выходы массивов к входному и выходному сигналу
  // входы
  assign X[0]       = x_i;
  assign Y[0]       = y_i;
  assign Phi[0]     = phi_i;
  assign done[0]    = data_in;
  // выходы
  assign x_o        = X[COUNT+1];
  assign y_o        = Y[COUNT+1];
  assign phi_o      = Phi[COUNT+1];
  assign data_ready = done[COUNT+1];

  // Объявление блоков
  generate    
    genvar k;
    for (k=0; k<=COUNT; k=k+1) begin
      defparam Out.ITER = k;
      cordic_alg_block Out (
      .rst(rst), .clk (clk), 
      .enable(enable), .data_in(done[k]),
      .X_in(X[k]), .Y_in(Y[k]), .phi_veer_in(Phi[k]),
      .X_out(X[k+1]), .Y_out(Y[k+1]), .phi_veer_out(Phi[k+1]),
      .done(done[k+1])
      );
    end
  endgenerate

  // Сама проверка последоватьльно соединнённых конвееров
  integer i;
  initial begin
    #10
    rst     = 1'b1;
    clk     = 1'b0;
    enable  = 1'b1;
    #10
    rst     = 1'b0;
    ///*
    x_i     = 20'b00000011000000000000; // 3
    y_i     = 20'b00000011000000000000; // 3
    //phi_i   = 22'b1000110111000000000000;  // -55
    phi_i   = 22'b0000000101000000000000; // 5
    data_in = 1'b1;
    for (i = 0; i < COUNT*2+2; i = i + 1)
    begin
      #10 clk = ~clk; 
      if (data_ready) begin
        $display("X_in:%b.%b, \tY_in:%b.%b, \tPhi_in:%b.%b", 
                                                                x_i[DATA_WIDTH-1:12], x_i[11:0], 
                                                                y_i[DATA_WIDTH-1:12], y_i[11:0], 
                                                                phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
        $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                                x_o[DATA_WIDTH-1:12], x_o[11:0], 
                                                                y_o[DATA_WIDTH-1:12], y_o[11:0], 
                                                                phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
        $display("-----------------------------------------");
      end
    end
    //*/
    //---------------------
    /*
    x_i   = 13'b0000101000000; // 10
    y_i   = 13'b0000101000000; // 10
    phi_i = 19'b0010100000000000000; // 20
    for (i = 0; i < COUNT*2+6; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%b.%b, \tY_in:%b.%b, \tPhi_in:%b.%b", 
                                                              x_i[DATA_WIDTH-1:5], x_i[4:0], 
                                                              y_i[DATA_WIDTH-1:5], y_i[4:0], 
                                                              phi_i[PHI_WIDTH-1:12], phi_i[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              x_o[DATA_WIDTH-1:5], x_o[4:0], 
                                                              y_o[DATA_WIDTH-1:5], y_o[4:0], 
                                                              phi_o[PHI_WIDTH-1:12], phi_o[11:0]);
      $display("-----------------------------------------");
    end
    */

    $finish;
  end

  initial begin
    $dumpvars;
  end

endmodule