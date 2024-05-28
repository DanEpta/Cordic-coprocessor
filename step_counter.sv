module step_counter
#(
  parameter STEP_COUNT = 25,  // Количество шагов для сброса
  parameter WIDTH = 5 
)
(
  input  wire clk,
  input  wire rst,     

  output reg  rst_step 
);

reg [WIDTH-1:0] counter;

always @(posedge clk or posedge rst) begin
if (rst) begin
  counter   <= 0;
  rst_step  <= 1'b0;
end else begin
  if (counter == STEP_COUNT-1) begin
  counter   <= 0;
  rst_step  <= 1'b1;
  end else begin
  counter   <= counter + 1;
  rst_step  <= 1'b0;
  end
end
end
endmodule