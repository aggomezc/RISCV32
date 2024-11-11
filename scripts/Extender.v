module EXTENSION (
    input [31:0] Instr,
    input [1:0] ImmControl,
    output reg [31:0] ExtendedImm
);
parameter I = 0,
          S = 1,
          B = 2,
          U = 3;



always @(Instr or ImmControl) begin

        case (ImmControl)
            // I:  ExtendedImm = {{20{Instr[31]}}, Instr[31:20]};

            // S: ExtendedImm = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

            // B: ExtendedImm = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
            // default: ExtendedImm = 0;iveri    Ext    

        I:  ExtendedImm = {{20{Instr[31]}}, {Instr[31:20]}};
        
        S: ExtendedImm = {{20{Instr[31]}}, {Instr[31:25]}, {Instr[11:7]}};
        
        B: begin 
            ExtendedImm = {{20{Instr[31]}}, {Instr[7]}, {Instr[30:25]}, {Instr[11:8]}, 1'b0};
        end
        U: ExtendedImm = {{Instr[31:12]}, 10{1'b0}};
        default: ExtendedImm = 0;

        endcase
        
    end
endmodule