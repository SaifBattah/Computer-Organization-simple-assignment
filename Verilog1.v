module Verilog1(
    input clk,
    input [7:0] memory_address,
    input [15:0] data_in,
    output reg [15:0] data_out,
    output wire [15:0] result
);

reg [15:0] memory[127:0];
reg [15:0] R0, R1;
reg [7:0] PC;

always @(posedge clk) begin
    PC <= PC + 1;
    case(memory[PC])
        // LOAD R0, [20]
        16'h00_00_00: begin
            R0 <= memory[memory[20]];
        end
        // LOAD R1, 21
        16'h00_01_11: begin
            R1 <= memory[21];
        end
        // ADD R0, [R1]
        16'h01_00_10: begin
            R0 <= R0 + memory[R1];
        end
        // LOAD R1, [22]
        16'h00_01_00: begin
            R1 <= memory[memory[22]];
        end
        // SUB R1, +8
        16'h01_01_11: begin
            R1 <= R1 - 8;
        end
        // ADD R0, R1
        16'h01_00_01: begin
            R0 <= R0 + R1;
        end
        // STORE R0, [23]
        16'h00_10_00: begin
            memory[memory[23]] <= R0;
        end
    endcase
end

always @(posedge clk) begin
    data_out <= memory[memory_address];
end

assign result = memory[24];

initial begin
    memory[20] = 6;
    memory[21] = 4;
    memory[22] = 13;
    memory[23] = 24;
    PC = 10;
end

endmodule
