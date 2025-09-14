module Automatic_signaling_tb;

  reg clk;
  reg clr;
  reg x;
  wire [1:0] a, b, c, d;

  Automatic_signaling uut (.a(a),.b(b),.c(c),.d(d),.x(x),.clk(clk),.clr(clr));

  always #5 clk = ~clk;

  initial begin
    $dumpfile("Automatic_signaling_tb.vcd");
    $dumpvars(0, Automatic_signaling_tb);

    clk = 0;
    clr = 1;
    x = 0;

    #20;
    clr = 0;

    #50;
    x = 1;
    #300;

    #300;
    x = 0;
    #200;

    #200;
    $finish;
  end

  initial begin
    $monitor("Time=%0t | x=%b | a=%b b=%b c=%b d=%b",
              $time, x, a, b, c, d);
  end

endmodule
