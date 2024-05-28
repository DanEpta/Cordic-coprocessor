`include "case_grad.sv"

module cordic_alg_block 
#(
  parameter ITER = 0, // итерация, которую представляет собой этот блок
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH = 22
)
(
  input        clk,
  input        rst,
  input        rst_step,
  input        enable,
  input        data_in,
  input [1:0]  quarter_in,
  input signed [DATA_WIDTH-1:0] X_in,
  input signed [DATA_WIDTH-1:0] Y_in,
  input signed [PHI_WIDTH-1:0]  phi_veer_in,

  output reg signed [DATA_WIDTH-1:0] X_out,
  output reg signed [DATA_WIDTH-1:0] Y_out,
  output reg signed [PHI_WIDTH-1:0]  phi_veer_out,
  output            [1:0]            quarter_out,
  output reg done
);

// Подключаем вход к выходу, т.к
assign quarter_out = quarter_in;

// Промежуточные переменные
reg [DATA_WIDTH-1:0] Xd, Yd;

// получаем арктангенс в градусах из модуля
reg [3:0] iter_grad = ITER;
wire [PHI_WIDTH-1:0] result_grad;
case_grad grd ( 
  .value(iter_grad), .result(result_grad) 
); 

// Основной блок
always @(posedge clk or posedge rst or posedge rst_step) begin
  if (rst || rst_step) begin
    Xd <= 0;
    Yd <= 0;
    X_out <= {DATA_WIDTH{1'bx}};
    Y_out <= {DATA_WIDTH{1'bx}};
    phi_veer_out <= 0;
    done <= 1'b0;
  end
  else if (enable && data_in && !done) begin
    if (phi_veer_in[PHI_WIDTH-1] == 'b1) begin
      Xd = SHIFT_RIGHT(X_in, ITER);
      Yd = SHIFT_RIGHT(Y_in, ITER);
      X_out <= X_in + Yd;
      if (Y_in[DATA_WIDTH-2:0] < Xd[DATA_WIDTH-2:0]) begin
        Y_out = Xd - Y_in;
        Y_out[DATA_WIDTH-1] <= ~Y_out[DATA_WIDTH-1];
      end
      else
        Y_out <= Y_in - Xd;
      // Другим способом угол считает не правильно, а этим норм
      if (result_grad < phi_veer_in[PHI_WIDTH-2:0]) begin
        phi_veer_out <= phi_veer_in - result_grad;
        done <= 1'b1;
      end
      else begin 
        phi_veer_out = result_grad - phi_veer_in;
        phi_veer_out[PHI_WIDTH-1] <= ~phi_veer_out[PHI_WIDTH-1];
        done <= 1'b1;
      end
    end
    else begin
      Xd = SHIFT_RIGHT(X_in, ITER);
      Yd = SHIFT_RIGHT(Y_in, ITER);
      X_out <= X_in - Yd;
      Y_out <= Y_in + Xd;
      // Другим способом угол считает не правильно, а этим норм
      if (phi_veer_in < result_grad) begin
        phi_veer_out = result_grad - phi_veer_in;
        phi_veer_out[PHI_WIDTH-1] <= ~phi_veer_out[PHI_WIDTH-1];
        done <= 1'b1;
      end
      else begin
        phi_veer_out <= phi_veer_in - result_grad;
        done <= 1'b1;
      end
    end
  end
end

// Функция которая сдвигает двоичное число на определенное количество бит вправо, не трогает старший бит
// по сути домножение на 2^(-cnt)
function automatic signed [DATA_WIDTH-1:0] SHIFT_RIGHT(
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
  SHIFT_RIGHT = val;
end
endfunction
endmodule