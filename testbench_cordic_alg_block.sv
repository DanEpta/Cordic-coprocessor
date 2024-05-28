`include "cordic_alg_block.sv"
`timescale 10ns/1ns

module cordic_alg_block_tb
#(
  // Определение констант
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH = 19
);

  // Определение портов
  reg clk;
  reg rst;
  reg enable;
  reg data_in;
  reg signed [DATA_WIDTH-1:0] X, Y;
  reg signed [PHI_WIDTH-1:0] phi;
  wire signed [DATA_WIDTH-1:0] X_out, Y_out;
  wire signed [PHI_WIDTH-1:0] phi_out;
  wire done;

  defparam pmp.ITER = 0;
  // Подключение модуля
  cordic_alg_block pmp (.data_in(data_in), .rst(rst), .clk(clk), .enable(enable), .done(done),
                        .X_in(X), .Y_in(Y), .phi_veer_in(phi),
                        .X_out(X_out), .Y_out(Y_out), .phi_veer_out(phi_out));  

  // Генерация входных сигналов
  integer i;
  initial begin
    #10
    data_in <= 1'b0;
    rst     <= 1'b1;
    clk     <= 1'b0;
    enable  <= 1'b1;

    #10 
    rst     <= 1'b0;
    /*
    // Первый бит [12] X,Y указывает на знак (+ или -)
    // [11:5] целое число
    // [4:0] дробь
    X <=   13'b0000101000000; // 10
    Y <=   13'b0000000000000; // 0
    // Первый бит [18] Phi указывает на знак (+ или -)
    // [17:12] целое число
    // [11:0] дробь
    phi <= 19'b0110111000000000000; // 55
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%b.%b, \tY_in:%b.%b, \tPhi_in: %b.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
    end
    */
    /*
    //----------------------------
    X <=   13'b0000101000000; // 10
    Y <=   13'b0000101000000; // 10
    phi <= 19'b0001010000000000000; // 10
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%d.%b, \tY_in:%d.%b, \tPhi_in: %d.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%d.%b \tY_out:%d.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
    end
    */
    /*
    //----------------------------
    X <=   13'b0000010100000;       // 5
    Y <=   13'b0000111100000;       // 15
    phi <= 19'b1010000100110011001; //-16.6
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%d.%b, \tY_in:%d.%b, \tPhi_in: %b.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%d.%b \tY_out:%d.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
    end
    */
    //----------------------------
    /*
    X <=   13'b0000100011000;       // 8,75
    Y <=   13'b0000110111000;       // 13,75
    phi <= 19'b1000010100011110110; //-2.56
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%d.%b, \tY_in:%d.%b, \tPhi_in: %b.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%d.%b \tY_out:%d.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
    end
    */
    //----------------
    /*
    X <=   13'b0000101000000;       // 10
    Y <=   13'b0000101000000;       // 10
    phi <= 19'b0010100000000000000; // 20
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      $display("X_in:%d.%b, \tY_in:%d.%b, \tPhi_in: %d.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%d.%b \tY_out:%d.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
    end
    */
    //----------------
    /*
    X <=   13'b0000000000000;       // 0
    Y <=   13'b0001010000000;       // 20
    phi <= 19'b1011001000000000000; // -25
    data_in <= 1'b1;
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      if (done) begin
      $display("X_in:%b.%b, \tY_in:%b.%b, \tPhi_in: %b.%b", 
                                                              X[DATA_WIDTH-1:5], X[4:0], 
                                                              Y[DATA_WIDTH-1:5], Y[4:0], 
                                                              phi[PHI_WIDTH-1:12], phi[11:0]);
      $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                              X_out[DATA_WIDTH-1:5], X_out[4:0], 
                                                              Y_out[DATA_WIDTH-1:5], Y_out[4:0], 
                                                              phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
      $display("-----------------------------------------");
      end
    end
    */
    //------------------------------------
    X <=   20'b00000001000000000000; // 1
    Y <=   20'b00000000000000000000; // 0
    phi <= 19'b1110111000000000000;  // -55
    data_in <= 1'b1;
    #20
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk; 
      if (done) begin
        $display("X_in:%b.%b, \tY_in:%b.%b, \tPhi_in: %b.%b", 
                                                                X[DATA_WIDTH-1:12], X[11:0], 
                                                                Y[DATA_WIDTH-1:12], Y[11:0], 
                                                                phi[PHI_WIDTH-1:12], phi[11:0]);
        $display("X_out:%b.%b \tY_out:%b.%b \tPhi_out:%b.%b",
                                                                X_out[DATA_WIDTH-1:12], X_out[11:0], 
                                                                Y_out[DATA_WIDTH-1:12], Y_out[11:0], 
                                                                phi_out[PHI_WIDTH-1:12], phi_out[11:0]);
        $display("-----------------------------------------");
      end
    end

    $finish;
  end 

  initial
    $dumpvars;

endmodule