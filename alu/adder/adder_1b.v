module adder_1b(input a, b, ci, output s, co);
    wire ps = a ^ b; 
    wire pc = a & b;

    assign co = pc | ps & ci;
    assign s = ps ^ ci;
endmodule