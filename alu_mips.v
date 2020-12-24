module alu_mips(a, b, control, outalu, zero);
    
    input [31:0] a, b;

    input [2:0] control;
    output reg [31:0] outalu;
    output zero;
    
    always @(*)  begin
        case(control)
            0 : outalu <= a&b;
            1 : outalu <= a|b;
            2 : outalu <= a+b;
            3 : outalu <= (b << 2);
            6 : outalu <= a-b;
            7 : outalu <= (a<b)? 1:0;
            default : outalu <= 0;
        endcase
    end
    
    assign zero = (outalu==0)? 1:0;

endmodule
