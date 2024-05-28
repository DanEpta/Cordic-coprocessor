module function_tb
#(
  parameter DATA_WIDTH = 4
);

  function automatic signed [DATA_WIDTH-1:0] Delta(
    input signed [DATA_WIDTH-1:0] Arg,
    input integer cnt
  );  

  integer k;
  reg [DATA_WIDTH-1:0] val;  
  
  begin
    val = Arg;
    for (k=0; k<cnt; k=k+1)
    begin
      val[DATA_WIDTH-2:0] = val[DATA_WIDTH-2:1];
      val[DATA_WIDTH-1] = Arg[DATA_WIDTH-1];
    end
    Delta = val;
  end
endfunction

  // Промежуточные переменные
  reg signed [DATA_WIDTH-1:0] Xd, Yd;
  reg clk;

  reg signed [DATA_WIDTH-1:0] X_in0 = 4'b1000;
  reg signed [DATA_WIDTH-1:0] Y_in0 = 4'b1000; 
  reg signed [DATA_WIDTH-1:0] X_in1 = 4'b0100;
  reg signed [DATA_WIDTH-1:0] Y_in1 = 4'b0100; 
  reg signed [DATA_WIDTH-1:0] X_in2 = 4'b1100;
  reg signed [DATA_WIDTH-1:0] Y_in2 = 4'b1100; 
   
  // Генерация входных сигналов
  integer i = 0;
  initial begin
    clk <= 1'b0;
    Xd <= Delta(X_in0, 1);
    Yd <= Delta(Y_in0, 1);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("0 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in0, Y_in0, Xd, Yd);
    end
    #20

    Xd <= Delta(X_in0, 2);
    Yd <= Delta(Y_in0, 2);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("0 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in0, Y_in0, Xd, Yd);
    end
    #20

    //
    Xd <= Delta(X_in1, 1);
    Yd <= Delta(Y_in1, 1);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("1 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in1, Y_in1, Xd, Yd);
    end
    #20

    Xd <= Delta(X_in1, 2);
    Yd <= Delta(Y_in1, 2);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("1 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in1, Y_in1, Xd, Yd);
    end
    #20

    //
    Xd <= Delta(X_in2, 1);
    Yd <= Delta(Y_in2, 1);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("2 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in2, Y_in2, Xd, Yd);
    end
    #20

    Xd <= Delta(X_in2, 2);
    Yd <= Delta(Y_in2, 2);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("2 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in2, Y_in2, Xd, Yd);
    end
    #20

    Xd <= Delta(X_in2, 3);
    Yd <= Delta(Y_in2, 3);
    for (i = 0; i < 2; i = i + 1)
    begin
      #10 clk = ~clk;
      $display("2 X_in:%b \tY_in:%b \tXd:%b \tYd:%b", X_in2, Y_in2, Xd, Yd);
    end
    #20

    $finish;
  end

  initial
    $dumpvars;
    
endmodule