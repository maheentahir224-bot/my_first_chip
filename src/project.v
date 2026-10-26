`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Input pins
    output wire [7:0] uo_out,   // Output pins
    input  wire [7:0] uio_in,   // Bidirectional pins (Input)
    output wire [7:0] uio_out,  // Bidirectional pins (Output)
    output wire [7:0] uio_oe,   // Bidirectional enable
    input  wire       ena,      // Enable signal
    input  wire       clk,      // Clock signal
    input  wire       rst_n     // Reset signal (active low)
);

    // Map inputs:
    // ui_in[3:0] -> 4 Data Inputs (D0, D1, D2, D3)
    // ui_in[5:4] -> 2 Select Lines (S0, S1)
    wire [3:0] data = ui_in[3:0];
    wire [1:0] sel  = ui_in[5:4];
    reg        mux_out;

    // 4-to-1 Multiplexer Logic
    always @(*) begin
        case (sel)
            2'b00: mux_out = data[0];
            2'b01: mux_out = data[1];
            2'b10: mux_out = data[2];
            2'b11: mux_out = data[3];
            default: mux_out = 1'b0;
        endcase
    end

    // Assign output to the first pin of uo_out
    assign uo_out[0] = mux_out;
    assign uo_out[7:1] = 7'b0000000; // Drive unused pins low

    // Unused bidirectional IOs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent unused variable warnings
    wire _unused = &{ena, clk, rst_n, uio_in, ui_in[7:6], 1'b0};

endmodule