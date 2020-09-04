`include "config.vh"

module top
(
    input        clk,
    input        reset_n,
    
    input  [3:0] key_sw,
    output [3:0] led,

    output [7:0] abcdefgh,
    output [3:0] digit,

    output       buzzer,

    output       hsync,
    output       vsync,
    output [2:0] rgb
);

    assign abcdefgh  = 8'b0;
    assign digit     = 4'b0;
    assign buzzer    = 1'b0;
    assign hsync     = 1'b1;
    assign vsync     = 1'b1;
    assign rgb       = 3'b0;

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.

    reg [31:0] cnt;
    
    always @ (posedge clk or negedge reset_n)
      if (~ reset_n)
        cnt <= 32'b0;
      else
        cnt <= cnt + 32'b1;
        
    assign { led [0], led [1], led [2], led [3] } = ~ cnt [27:24];

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesized the following code.
    // Press the key to see the counter incrementing.
    // Notice that the increment is not always 1.
    // Why? Hint: google "switch bounce" and "debouncing".

    /*

    wire key = key_sw [0];

    reg key_r;
    
    always @ (posedge clk or negedge reset_n)
      if (~ reset_n)
        key_r <= 1'b0;
      else
        key_r <= key;
        
    wire key_pressed = ~ key & key_r;

    reg [31:0] cnt;
    
    always @ (posedge clk or negedge reset_n)
      if (~ reset_n)
        cnt <= 32'b0;
      else if (key_pressed)
        cnt <= cnt + 32'b1;
        
    assign { led [0], led [1], led [2], led [3] } = ~ cnt [3:0];
    
    */

    // Exercise 3 (advanced): Instantiate ../../common/sync_and_debounce.v
    // module to de-bounce the key.

endmodule