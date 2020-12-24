
module shift_left2(
    input [31:0] a,
    output [31:0] out
    );
    
    assign out = (a << 2);
    
endmodule
