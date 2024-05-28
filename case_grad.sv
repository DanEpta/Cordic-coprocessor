module case_grad
#(
  parameter WIDTH_INPUT = 4,
  parameter WIDTH_OUTPUT = 22,

  // arctg(2^(-i))
  // Первый бит [22] Phi указывает на знак (+ или -)
  // [21:12] целое число
  // [11:0] дробь
  parameter TANAGLE_grad_0  = 22'b0000101101000000000000, // 1/1 45 градусов
  parameter TANAGLE_grad_1  = 22'b0000011010100110011001, // 1/2 26,6° градусов
  parameter TANAGLE_grad_2  = 22'b0000001110000010100011, // 1/4 14,04 градусов
  parameter TANAGLE_grad_3  = 22'b0000000111111010111000, // 1/8 7,92 градусов
  parameter TANAGLE_grad_4  = 22'b0000000011111110000101, // 1/16 3,97 градусов
  parameter TANAGLE_grad_5  = 22'b0000000001111111010111, // 1/32 1,99 градусов
  parameter TANAGLE_grad_6  = 22'b0000000000111111010111, // 1/64 0,99 градусов
  parameter TANAGLE_grad_7  = 22'b0000000000011111010111, // 1/128 0,49 градусов
  parameter TANAGLE_grad_8  = 22'b0000000000001110000101, // 1/256 0,22 градусов
  parameter TANAGLE_grad_9  = 22'b0000000000000111000010, // 1/512 0,11 градусов
  parameter TANAGLE_grad_10 = 22'b0000000000000011110101, // 1/1024 0,06 градусов
  parameter TANAGLE_grad_11 = 22'b0000000000000001111010, // 1/2048 0,03 градусов
  parameter TANAGLE_grad_12 = 22'b0000000000000000110101, // 1/4096 0,013 градусов
  parameter TANAGLE_grad_13 = 22'b0000000000000000011100, // 1/8192 0,007 градусов
  parameter TANAGLE_grad_14 = 22'b0000000000000000001100, // 1/16384 0.003 градусов
  parameter TANAGLE_grad_15 = 22'b0000000000000000000100  // 1/32768 0.001 градусов
)
(
  input [WIDTH_INPUT-1:0] value,
  output reg [WIDTH_OUTPUT-1:0] result
);

always @* begin
  case (value)
    4'b0000: result = TANAGLE_grad_0;
    4'b0001: result = TANAGLE_grad_1;
    4'b0010: result = TANAGLE_grad_2;
    4'b0011: result = TANAGLE_grad_3;
    4'b0100: result = TANAGLE_grad_4;
    4'b0101: result = TANAGLE_grad_5;
    4'b0110: result = TANAGLE_grad_6;
    4'b0111: result = TANAGLE_grad_7;
    4'b1000: result = TANAGLE_grad_8;
    4'b1001: result = TANAGLE_grad_9;
    4'b1010: result = TANAGLE_grad_10;
    4'b1011: result = TANAGLE_grad_11;
    4'b1100: result = TANAGLE_grad_12;
    4'b1101: result = TANAGLE_grad_13;
    4'b1110: result = TANAGLE_grad_14;
    4'b1111: result = TANAGLE_grad_15;
  endcase
end
endmodule