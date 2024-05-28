`include "identifier_quarter.sv"
`include "cordic_alg_block.sv"
`include "quartor_rotator.sv"
`include "fixed_point.sv"
`include "step_counter.sv"

module cordic_proc
#(
  parameter DATA_WIDTH = 20,
  parameter PHI_WIDTH  = 22,
  parameter COUNT      = 15
)
(
  input  clk,
  input  rst,
  input  enable,
  input  signed [DATA_WIDTH-1:0] x_i, y_i,
  input  signed [PHI_WIDTH-1:0]  phi_i,

  output signed [DATA_WIDTH-1:0] x_o, y_o,
  output signed [PHI_WIDTH-1:0]  phi_o,
  output        [1:0]            quart,
  output data_ready
);

// Промежуточные переменные
// Массив проводов соединяющий блоки всего сопроцессора
wire signed [DATA_WIDTH-1:0] X    [COUNT+2:0];
wire signed [DATA_WIDTH-1:0] Y    [COUNT+2:0];
wire signed [PHI_WIDTH-1:0]  Phi  [COUNT+1:0];
wire        [1:0]            qrt  [COUNT+1:0];
wire                         done [COUNT+2:0];
wire                         rst_step;

// Подключаем входы и выходы массивов к входному и выходному сигналу
// входы
assign X[0]  = x_i;
assign Y[0]  = y_i;
// выходы
assign phi_o = Phi [COUNT+1];
assign quart = qrt [COUNT+1];

// Объявление блоков
// Определение четветри окружности
identifier_quarter quart_in (
  .clk(clk), .rst(rst), .rst_step(rst_step),
  .enable(enable), .phi_veer_in(phi_i),
  .quarter(qrt[0]), .phi_veer_out(Phi[0]),
  .done(done[0])
);

// Последоватьельное присоединение блоков которые
// реализуют основной алгоритм
generate    
  genvar k;
  for (k=0; k<=COUNT; k=k+1) begin
    defparam Out.ITER = k;
    cordic_alg_block Out (
    .clk (clk), .rst(rst), .rst_step(rst_step), 
    .enable(enable), .data_in(done[k]), .quarter_in(qrt[k]),
    .X_in(X[k]), .Y_in(Y[k]), .phi_veer_in(Phi[k]),
    .X_out(X[k+1]), .Y_out(Y[k+1]), .phi_veer_out(Phi[k+1]),
    .quarter_out(qrt[k+1]), .done(done[k+1])
    );
  end
endgenerate

// Ротация сигналов согласно входящей четверти окружности
quartor_rotator rotator (
  .clk(clk), .rst(rst), .rst_step(rst_step),
  .new_data(done[COUNT+1]),
  .quartor(qrt[COUNT+1]), .x_i(X[COUNT+1]), .y_i(Y[COUNT+1]),
  .cos_x(X[COUNT+2]), .sin_y(Y[COUNT+2]), .data_ready(done[COUNT+2])
);

// Домножает на константу выходное значение
fixed_point consta (
  .clk(clk), .rst(rst), .rst_step(rst_step),
  .new_data(done[COUNT+2]),
  .data_in_x(X[COUNT+2]), .data_in_y(Y[COUNT+2]),
  .cos_x_out(x_o), .sin_y_out(y_o), 
  .data_ready(data_ready)
);

// Определение модуля который сбрасывает внутреннее состояние модулей при определенном 
// количестве тактов
step_counter step (
  .clk(clk), .rst(rst),
  .rst_step(rst_step) 
);
endmodule