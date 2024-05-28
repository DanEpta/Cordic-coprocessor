module identifier_quarter
#(
  parameter DATA_WIDTH    = 20,
  parameter PHI_WIDTH     = 22,
  parameter PHI_WIDTH_INT = 9
)
(
  input                             clk,
  input                             rst,
  input                             rst_step,
  input                             enable,
  input signed      [PHI_WIDTH-1:0] phi_veer_in,

  output reg signed [PHI_WIDTH-1:0] phi_veer_out,
  output reg        [1:0]           quarter,
  output reg                        done
);

// Определение состояний
localparam [1:0] 
  STATE_Q1 = 2'b00,
  STATE_Q2 = 2'b01,
  STATE_Q3 = 2'b10,
  STATE_Q4 = 2'b11;

// Определяем переменные
reg [1:0] state, next_state; 
reg signed [PHI_WIDTH_INT-1:0] phi_int;
reg signed [PHI_WIDTH_INT-1:0] phi_int_reg;
reg phi_assign;
reg first_run;

always @(posedge clk or posedge rst or posedge rst_step) begin
  if (rst || rst_step) begin
    state        <= STATE_Q1;
    next_state   <= {2{1'bx}};
    phi_veer_out <= {PHI_WIDTH_INT{1'bx}};
    quarter      <= 2'bxx;
    done         <= 1'b0;
    phi_int      <= 9'bx;
    phi_assign   <= 1'b0;
    first_run    <= 1'b0;
  end
  else if (enable) begin
    state = next_state;

    if (!phi_assign && !done)
    begin
      phi_int = phi_veer_in[PHI_WIDTH-2:12];
      phi_assign <= 1'b1;
    end

    if (phi_int <= 9'd90 && !done && first_run && next_state == state) begin
      quarter <= state;
      phi_veer_out <= { phi_veer_in[PHI_WIDTH-1], phi_int[PHI_WIDTH_INT-1:0], phi_veer_in[11:0] };
      phi_int_reg <= phi_veer_out;
      done    <= 1'b1;
    end
  end
end

always @* begin
  done = 1'b0;
  // Определяем четверть окружности по вход градусам
  case(state)  
    STATE_Q1: begin
      first_run    = 1'b1;
      if (phi_int > 9'd90) begin
        phi_int    = phi_int - 10'd90;
        next_state = (phi_veer_in[PHI_WIDTH-1] == 1'b1) ? STATE_Q3 : STATE_Q2;        
      end
      else if (phi_veer_in[PHI_WIDTH-1] == 1'b1 && phi_int < 9'd90) begin     
        next_state = STATE_Q4;
      end
    end
    STATE_Q2: begin
      if (phi_int > 9'd90) begin
        phi_int    = phi_int - 9'd90;
        next_state = (phi_veer_in[PHI_WIDTH-1] == 1'b1) ? STATE_Q1 : STATE_Q3;
      end 
    end
    STATE_Q3: begin
      if (phi_int > 9'd90) begin
        phi_int    = phi_int - 9'd90;        
        next_state = (phi_veer_in[PHI_WIDTH-1] == 1'b1) ? STATE_Q2 : STATE_Q4;
      end 
    end
    STATE_Q4: begin
      if (phi_int > 9'd90) begin
        phi_int    = phi_int - 9'd90;
        next_state = (phi_veer_in[PHI_WIDTH-1] == 1'b1) ? STATE_Q3 : STATE_Q1;
      end 
    end
    default: next_state = STATE_Q1;
  endcase
end
endmodule