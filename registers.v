

module registers(
    input clk,
    input [4:0] rd_register1,
    input [4:0] rd_register2,
    input [4:0] wt_register,
    input [31:0] wt_data,
    input RegWrite,
    output reg [31:0] rd_data1,
    output reg [31:0] rd_data2
    );
    
    reg [31:0] mem[0:31];
    integer i;
    
    initial begin
        for(i = 0 ; i < 32 ; i = i+1)
            mem[i] <= 0;
    end
    
    always @(negedge clk) begin
        rd_data1 <= mem[rd_register1];
        rd_data2 <= mem[rd_register2];
    end
    
    always @(posedge clk) begin
        if(RegWrite) begin
            mem[wt_register] <= wt_data;
        end
    end
    
endmodule
