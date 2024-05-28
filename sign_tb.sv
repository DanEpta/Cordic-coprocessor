module sign_tb;
  reg clk;
  reg signed [3:0] phi_veer_in;

  integer i;
  initial begin
    clk = 0;      
    phi_veer_in = 4'b1000;
    for (i = 0; i < 2; i = i + 1)
    begin
      if (phi_veer_in < 0) begin
        $display("-");
      end
      else  begin
        $display("+");
      end
      #10 clk = ~clk;
    end
    #20

    phi_veer_in = 4'b0100;
    for (i = 0; i < 2; i = i + 1)
    begin
      if (phi_veer_in < 0) begin
        $display("-");
      end
      else  begin
        $display("+");
      end
      #10 clk = ~clk;
    end
    #20

    $finish;
  end

  initial
    $dumpvars;
endmodule