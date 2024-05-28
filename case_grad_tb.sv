`include "case_grad.sv"

module case_grad_tb;
  reg clk;
  reg [3:0] val = 4'b0000;
  wire [18:0] result;
  reg signed [18:0] peremen_x, peremen_y;
  reg signed [18:0] result_func;

  case_grad ppp ( .value(val), .result(result) );

  integer i;
  initial begin
    // Первый бит [18] Phi указывает на знак (+ или -)
    // [17:12] целое число
    // [11:0] дробь
    clk = 0;      
    val = 4'b0001;
    peremen_x = 19'b0001010000000000000; // 10
    peremen_y = 19'b0011010100110011001; // 26.6
    for (i = 0; i < 6; i = i + 1)
    begin
      result_func = result - peremen_x;
      $display("case:%d \tresult:%b.%b", val, result_func[18:12], result_func[11:0]);
      #10 clk = ~clk;
    end
    #20

    $finish;
  end

  initial
    $dumpvars;
endmodule