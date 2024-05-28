module fixed_point
#(
  parameter DATA_WIDTH = 20,
  parameter FRAC_WIDTH = 12
)
(
  input                         clk,
  input                         rst,
  input                         rst_step,
  input                         new_data,  
  input signed [DATA_WIDTH-1:0] data_in_x,
  input signed [DATA_WIDTH-1:0] data_in_y,

  output reg signed [DATA_WIDTH-1:0] cos_x_out,
  output reg signed [DATA_WIDTH-1:0] sin_y_out,
  output reg                         data_ready
);

// Промежуточные переменные
reg signed [DATA_WIDTH-2:0] temp_data_x;
reg signed [DATA_WIDTH-2:0] temp_data_y;
reg first_run;

always @(posedge clk or posedge rst or posedge rst_step) begin
if (rst || rst_step) begin
  data_ready  <= 1'b0;
  first_run   <= 1'b0;
  cos_x_out   <= {DATA_WIDTH{1'bx}};
  sin_y_out   <= {DATA_WIDTH{1'bx}};
  temp_data_x <= {DATA_WIDTH{1'bx}};
  temp_data_y <= {DATA_WIDTH{1'bx}};
end
else begin
  if (new_data && !first_run) begin
    // Выполняем умножение на 0.607253
    temp_data_x <= SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 1) + SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 4) 
                 + SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 5) + SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 7) 
                 + SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 8) + SHIFT_RIGHT(data_in_x[DATA_WIDTH-2:0], 9);

    temp_data_y <= SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 1) + SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 4) 
                 + SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 5) + SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 7) 
                 + SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 8) + SHIFT_RIGHT(data_in_y[DATA_WIDTH-2:0], 9);

    first_run   <= 1'b1;
    data_ready  <= 1'b0; 
  end
  else if (first_run) begin
    cos_x_out  <= { data_in_x[DATA_WIDTH-1], temp_data_x };
    sin_y_out  <= { data_in_y[DATA_WIDTH-1], temp_data_y };
    data_ready <= 1'b1;
    first_run  <= 1'b0; 
  end
  else
    data_ready <= 1'b0;
end
end

// Функция которая сдвигает двоичное число на определенное количество бит вправо, не трогает старший бит
// По сути домножение на 2^(-cnt)
function automatic signed [DATA_WIDTH-1:0] SHIFT_RIGHT(
  input signed [DATA_WIDTH-2:0] Arg,
  input integer cnt
);  

integer k;
reg [DATA_WIDTH-2:0] val;  

begin
  val = Arg;
  for (k=0; k<cnt; k=k+1)
    val[DATA_WIDTH-2:0] = val[DATA_WIDTH-2:1];

  SHIFT_RIGHT = val;
end
endfunction
endmodule