`timescale 1 ns / 1 ps
module dff_1b(
    output reg  out,
    input in,
    input clk,
    input rstn);

    always @(posedge clk) begin
        if(~rstn) begin
            out <= 1'b0;
        end
        else begin
            out <= in;
        end
    end

    endmodule


module dff_4b(
    output reg  [4-1:0] out,
    input [4-1:0] in,
    input clk,
    input rstn);

    always @(posedge clk) begin
        if(~rstn) begin
            out <= 4'b0;
        end
        else begin
            out <= in;
        end
    end

    endmodule

module dff_20b(
    output reg  [20-1:0] out,
    input [20-1:0] in,
    input clk,
    input rstn);

    always @(posedge clk) begin
        if(~rstn) begin
            out <= 20'b0;
        end
        else begin
            out <= in;
        end
    end

    endmodule


module dff_21b(
    output reg  [21-1:0] out,
    input [21-1:0] in,
    input clk,
    input rstn);

    always @(posedge clk) begin
        if(~rstn) begin
            out <= 21'b0;
        end
        else begin
            out <= in;
        end
    end

    endmodule