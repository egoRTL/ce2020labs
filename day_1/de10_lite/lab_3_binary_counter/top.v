`include "config.vh"

module top
(
    input           clk,

    input   [ 1:0]  key,
    input   [ 9:0]  sw,
    output  [ 9:0]  led,

    output  [ 7:0]  hex0,
    output  [ 7:0]  hex1,
    output  [ 7:0]  hex2,
    output  [ 7:0]  hex3,
    output  [ 7:0]  hex4,
    output  [ 7:0]  hex5,

    output          vga_hs,
    output          vga_vs,
    output  [ 3:0]  vga_r,
    output  [ 3:0]  vga_g,
    output  [ 3:0]  vga_b,

    inout   [35:0]  gpio
);

    assign hex0 = 8'hff;
    assign hex1 = 8'hff;
    assign hex2 = 8'hff;
    assign hex3 = 8'hff;
    assign hex4 = 8'hff;
    assign hex5 = 8'hff;

    wire reset = sw [9];

    // Exercise 1: Free running counter.
    // How do you change the speed of LED blinking?
    // Try different bit slices to display.

    reg [31:0] cnt;
    
    always @ (posedge clk or posedge reset)
      if (reset)
        cnt <= 32'b0;
      else
        cnt <= cnt + 32'b1;
        
    assign led = cnt [29:20];

    // Exercise 2: Key-controlled counter.
    // Comment out the code above.
    // Uncomment and synthesized the following code.
    // Press the key to see the counter incrementing.
    // Notice that the increment may not be always 1.
    // Why? Hint: google "switch bounce" and "debouncing".

    /*

    reg key_r;
    
    always @ (posedge clk or posedge reset)
      if (reset)
        key_r <= 1'b0;
      else
        key_r <= key [0];
        
    wire key_pressed = ~ key [0] & key_r;

    reg [9:0] cnt;

    always @ (posedge clk or posedge reset)
      if (reset)
        cnt <= 10'b0;
      else if (key_pressed)
        cnt <= cnt + 10'b1;
        
    assign led = cnt;

    */

    // Exercise 3 (advanced): Instantiate ../../common/sync_and_debounce.v
    // module to de-bounce the key. Or write the debouncer by yourself.

endmodule
