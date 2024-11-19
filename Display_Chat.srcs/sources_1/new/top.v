`timescale 1ns / 1ps

module top(
    input clk,          // 100MHz on Basys 3
    input reset,        // btnC on Basys 3,
    input [6:0] sw,
    input btnU,
    output hsync,       // to VGA connector
    output vsync,       // to VGA connector
    output [11:0] rgb   // to DAC, to VGA connector
    );
//    ila_0 ila_0_inst (
//        .clk(clk),
//        .probe0(test)
//    );
    // signals
    wire [9:0] w_x, w_y;
    wire w_video_on, w_p_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // VGA Controller
    vga_controller vga(.clk_100MHz(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                       .video_on(w_video_on), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    // Text Generation Circuit
    ascii_test at(.clk(clk), .video_on(w_video_on), .x(w_x), .y(w_y), .ascii_char(mem[w_x[9:3]]), .rgb(rgb_next));
    
    
    reg [6:0] mem [127:0];
    
    reg [6:0] xw;
    //reg [5:0] yw;
    
    initial begin
        xw = 0;
    end
    
    reg [6:0] test;

    always @(posedge btnU) begin
        mem[xw] = sw[6:0];
        test = sw[6:0];
        if (xw == 32) begin
            xw = 0;
        end
        else begin
            xw = xw + 1;
        end
        $display ("%d %d %d", test, xw, mem[xw]);
       
    end
    
    // rgb buffer
    always @(posedge clk)
        if(w_p_tick)
            rgb_reg <= rgb_next;
            
    // output
    assign rgb = rgb_reg;
      
endmodule