module fsm2 (
    input clk, reset,
    input a, b,
    output y
);
    reg [1:0] state, nextstate;
    
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State Register
    always @ (posedge clk, posedge reset) begin
        if (reset) 
            state <= S0;
        else 
            state <= nextstate;
    end

    // Next State Logic
    always @ (*) begin
        case (state)
            S0: if (a != b)  nextstate = S1; // a != b is equivalent to a xor b
                else         nextstate = S0;
            S1: if (a & b)   nextstate = S2;
                else         nextstate = S0;
            S2: if (a | b)   nextstate = S3;
                else         nextstate = S0;
            S3: if (a | b)   nextstate = S3;
                else         nextstate = S0;
            default:         nextstate = S0;
        endcase
    end

    // Output Logic
    assign y = (state == S1) | (state == S2);

endmodule
