`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2024 14:06:01
// Design Name: 
// Module Name: RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RAM(
    output reg [7:0] mem [63:0][127:0] , // Address
    input [6:0] nx, 
    input [5:0] ny,
    input clk, we,
    input [5:0] data
    //output reg [7:0] dout, // Out
    //input wire [7:0] din, // In
    //input wire oe , // Output Enable
    //input wire clk , we, reset
    ) ;
    
    always @(posedge clk) begin
        if(we) begin // write enable = write d_input into RAM
            mem[ny][nx] = data;
            //addr = addr+1;
        end
        
//        if(reset || (oe&&addr==0)) begin // reset button or empty stack
//            out = 0;
//            addr = 0;
//        end
//        if(oe && addr > 0) begin // read from stack to d_output
//            addr = addr-1;
//            dout = mem[addr];
//            mem[addr] = 0;
//        end
    end
endmodule
