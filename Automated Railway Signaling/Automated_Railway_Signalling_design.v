module Automatic_signaling(
  output reg [1:0] a, b, c, d,
  input x,
  input clk, clr
);

  parameter r  = 2'd0;
  parameter yy  = 2'd1;
  parameter y = 2'd2;
  parameter g  = 2'd3;

  parameter s0 = 3'd0;
  parameter s1 = 3'd1;
  parameter s2 = 3'd2;
  parameter s3 = 3'd3;
  parameter s4 = 3'd4;
  parameter s5 = 3'd5;
  parameter s6 = 3'd6;

  integer g2rdelay  = 10;
  integer r2yydelay = 10;
  integer yy2ydelay = 10;
  integer y2gdelay  = 20;

  reg [2:0] state;
  reg [2:0] next_state;
  reg [7:0] count;

  always @(posedge clk) begin
    if (clr) begin
      state <= s0;
      count <= 0;
    end else begin
      state <= next_state;
      if (state != next_state)
        count <= 0;
      else
        count <= count + 1;
    end
  end

  always @(state) begin
    a = g; b = g; c = g; d = g;
    case (state)
      s0: begin
        a = g; b = g; c = g; d = g;
      end
      s1: begin
        a = r;
      end
      s2: begin
        a = yy; b = r;
      end
      s3: begin
        a = y; b = yy; c = r;
      end
      s4: begin
        a = g; b = y; c = yy; d = r;
      end
      s5: begin
        b = g; c = y; d = yy;
      end
      s6: begin
        c = g; d = y;
      end
    endcase
  end

  always @(*) begin
    case (state)
      s0: begin
        if (x) next_state = s1;
        else   next_state = s0;
      end
      s1: begin
        if (count >= g2rdelay) next_state = s2;
        else                   next_state = s1;
      end
      s2: begin
        if (count >= r2yydelay) next_state = s3;
        else                    next_state = s2;
      end
      s3: begin
        if (count >= yy2ydelay) next_state = s4;
        else                    next_state = s3;
      end
      s4: begin
        if (count >= y2gdelay) next_state = s5;
        else                   next_state = s4;
      end
      s5: begin
        if (count >= g2rdelay) next_state = s6;
        else                   next_state = s5;
      end
      s6: begin
        if (x) next_state = s6;
        else   next_state = s0;
      end
      default: next_state = s0;
    endcase
  end

endmodule
