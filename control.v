module control(
    input [5:0] opcode, 
    output reg RegDst, 
    output reg Jump, 
    output reg ALUSrc, 
    output reg MemtoReg, 
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite, 
    output reg Branch, 
    output reg [1:0] ALUOp
    );


	parameter R_FORMAT = 6'b000000;
	parameter LW       = 6'b100011;
	parameter SW       = 6'b101011;
	parameter BEQ      = 6'b000100;
	parameter JUMP     = 6'b000010;
	parameter ADDi     = 6'b001000;
	parameter ORI      = 6'b001101;

	always @(*)
	begin
		case (opcode)
			R_FORMAT : begin RegDst<=1; Jump<=0; ALUSrc<=0; MemtoReg<=0; RegWrite<=1; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b10; end
			LW       : begin RegDst<=0; Jump<=0; ALUSrc<=1; MemtoReg<=1; RegWrite<=1; MemRead<=1; MemWrite<=0; Branch<=0; ALUOp<=2'b00; end
			SW       : begin RegDst<=0; Jump<=0; ALUSrc<=1; MemtoReg<=0; RegWrite<=0; MemRead<=0; MemWrite<=1; Branch<=0; ALUOp<=2'b00; end
			BEQ      : begin RegDst<=0; Jump<=0; ALUSrc<=0; MemtoReg<=0; RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=1; ALUOp<=2'b01; end
			JUMP     : begin RegDst<=0; Jump<=1; ALUSrc<=0; MemtoReg<=0; RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b00; end
			ADDi     : begin RegDst<=0; Jump<=0; ALUSrc<=1; MemtoReg<=0; RegWrite<=1; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b00; end
		    ORI      : begin RegDst<=0; Jump<=0; ALUSrc<=1; MemtoReg<=0; RegWrite<=1; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b00; end
		    default  : begin RegDst<=0; Jump<=0; ALUSrc<=0; MemtoReg<=0; RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b00; end
		endcase
	end
endmodule

