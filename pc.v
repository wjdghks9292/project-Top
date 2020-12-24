module pc(clk, rst, newpc, pc);
    input clk;
    input rst;
    input [31:0] newpc;
    output reg [31:0] pc;

    always @(negedge rst, posedge clk) begin
        if (!rst)
            pc <= 0;
        else
            pc <= newpc;
    end

endmodule