
module data_memory(
    input [31:0] addr,
    input [31:0] wt_data,
    input MemRead,
    input MemWrite,
    output reg [31:0] rd_data
    );
    
    
    reg [31:0] mem [0:63];
    
    initial begin
        $readmemb("memory.mem", mem);
    end
    
    always @ (addr, wt_data) begin
        if(MemRead)
            rd_data <= mem[addr];
        else if(MemWrite)
            mem[addr] <= wt_data;
        else begin
            rd_data <= rd_data;
        end
    end
    
    
endmodule
