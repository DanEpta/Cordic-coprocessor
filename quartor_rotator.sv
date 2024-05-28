module quartor_rotator
#(
  parameter DATA_WIDTH = 20  
)
(
  input                  clk,
  input                  rst,
  input                  rst_step,
  input                  new_data,
  input [1:0]            quartor,
  input signed [DATA_WIDTH-1:0] x_i,
  input signed [DATA_WIDTH-1:0] y_i,

  output reg signed [DATA_WIDTH-1:0] cos_x,
  output reg signed [DATA_WIDTH-1:0] sin_y,
  output reg                  data_ready
);

// Определение состояний
localparam [1:0] 
  STATE_Q1 = 2'b00,
  STATE_Q2 = 2'b01,
  STATE_Q3 = 2'b10,
  STATE_Q4 = 2'b11;

// Промежуточные переменные
reg [DATA_WIDTH-1:0] x_temp;
reg [DATA_WIDTH-1:0] y_temp;
reg [DATA_WIDTH-1:0] x_reg1;
reg [DATA_WIDTH-1:0] y_reg1;
reg [DATA_WIDTH-1:0] x_reg2;
reg [DATA_WIDTH-1:0] y_reg2;
reg                  processing;

always @* begin
  case (quartor)
    STATE_Q1: begin
      x_temp = x_i;
      y_temp = y_i;
    end
    STATE_Q2: begin
      x_temp = {~y_i[DATA_WIDTH-1], y_i[DATA_WIDTH-2:0]};
      y_temp = x_i;
    end
    STATE_Q3: begin
      x_temp = {~x_i[DATA_WIDTH-1], x_i[DATA_WIDTH-2:0]};
      y_temp = {~y_i[DATA_WIDTH-1], y_i[DATA_WIDTH-2:0]};
    end
    STATE_Q4: begin
      x_temp = y_i;
      y_temp = {~x_i[DATA_WIDTH-1], x_i[DATA_WIDTH-2:0]};
    end
    default: begin
      x_temp = x_i;
      y_temp = y_i;
    end
  endcase
end

always @(posedge clk or posedge rst or posedge rst_step) begin
  if (rst || rst_step) begin
    data_ready <= 1'b0;
    cos_x      <= 20'bx;
    sin_y      <= 20'bx;
    processing  <= 1'b0;
  end
  else begin
    if (new_data) begin
      processing <= 1'b1;
      data_ready <= 1'b0;
    end

    if (processing) begin
      cos_x      <= x_temp;
      sin_y      <= y_temp;
      data_ready <= 1'b1;
      processing <= 1'b0;
    end
  end
end
endmodule