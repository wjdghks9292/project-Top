

module single_mips(
    input clk,
    input rstn,
    output [31:0] newPC,
	 output [31:0] PC_out_test,
    output [31:0] instruction_test,
	 output [31:0] wt_data
    );
	 
	 
    wire [31:0] PC_out;
    wire [31:0] PC_plus4;
    wire [31:0] instruction;
    wire [27:0] shift_out;
    wire [31:0] Jump_addr;
    wire [31:0] add_result;
    wire branch_cond;
    wire [31:0] branch_addr;
    
    assign PC_out_test = PC_out;
    assign instruction_test = instruction;
    
    wire RegDst;
    wire Jump;
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [1:0] ALUOp;
    
    wire [4:0] wt_register;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire [31:0] extend_out;
    wire [2:0] ALUcontrol;
        
    wire [31:0] ALU_b = (ALUSrc)? extend_out : read_data2;
    wire [31:0] ALU_result;
    wire Zero;
    
    wire [31:0] datamem_out;
    
    assign Jump_addr = {PC_plus4[31:28], shift_out};
    assign branch_cond = Branch & Zero;
    assign branch_addr = (branch_cond)? add_result : PC_plus4;
    assign newPC = (Jump)? Jump_addr : branch_addr;
    assign wt_register = (RegDst)? instruction[15:11] : instruction[20:16];
    assign wt_data = (MemtoReg)? datamem_out : ALU_result;
    
        
    pc myPC(
        clk,
        rstn,
        newPC,
        PC_out
    );
    
    add myAdd1(
        PC_out,
        32'd4,
        PC_plus4
    );
    
    instruction_memory myInstmem(
        PC_out,
        instruction
    );
    
    shift_left2 myShift(
        instruction[25:0],
        shift_out
    );
    
    // Do not need a shift left 2
    add myAdd2(
        PC_plus4,
        extend_out,
        add_result
    );
    
    control myControl(
        instruction[31:26],
        RegDst, 
        Jump, 
        ALUSrc, 
        MemtoReg, 
        RegWrite,
        MemRead,
        MemWrite, 
        Branch, 
        ALUOp
    );
    
    registers myReg(
        instruction[25:21],
        instruction[20:16],
        wt_register,
        wt_data,
        RegWrite,
        read_data1,
        read_data2
    );
    
    sign_ex mySignExtend(
        instruction[15:0],
        extend_out
    );
    
    aludec myALUcontrol(
        instruction[5:0],
        ALUOp,
        ALUcontrol
    );
    
    alu_mips myALU(
        read_data1,
        ALU_b,
        ALUcontrol,
        ALU_result,
        Zero
    );
    
    data_memory myDataMem(
        ALU_result,
        read_data2,
        MemRead,
        MemWrite,
        datamem_out
    );
    
    
endmodule