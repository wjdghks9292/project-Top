
// ALU control module
module aludec(func, aluop, alucontrol);
    input   [5:0] func;
    input   [1:0] aluop;
    output reg [2:0] alucontrol;
    
    always @(aluop, func)
    begin
        case(aluop)
          2'b00: alucontrol <= 3'b010;  // add
          2'b01: alucontrol <= 3'b110;  // sub
          default: case(func)          // RTYPE
                      6'b000000: alucontrol <= 3'b011; // shift left
                      6'b100000: alucontrol <= 3'b010; // add
                      6'b100010: alucontrol <= 3'b110; // sub
                      6'b100100: alucontrol <= 3'b000; // and
                      6'b100101: alucontrol <= 3'b001; // or
                      6'b101011: alucontrol <= 3'b111; // sltu
                      default:   alucontrol <= 3'bxxx; // ???
                  endcase
        endcase
    end

endmodule
