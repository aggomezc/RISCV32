module BranchEncoder (
    //para diferenciar entre los dos branches, y evitar que
    //la logica de uno interfiera en el otro, se implementa esta
//codificacion del Branch.El sentido de esta decision se vuelve claro
//al analizar la logica que rige a pcsource
    input [2:0] funct3, //funct3 de la instruccion que se esta ejecutando

    output reg Encoded_Branch
);
    parameter BGE = 3'b101;
    parameter BNE = 3'b001;

    always @(*) begin 
            case (funct3)
            BGE: Encoded_Branch = 0;
            BNE: Encoded_Branch = 1;  
            default: Encoded_Branch = 1'bx;
            endcase

    end
endmodule
