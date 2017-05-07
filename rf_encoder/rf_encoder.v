module rf_encoder (cout, sum, a, b);
    output cout, sum;
    input  a, b;
    wire   cout, sum;
    
    assign {cout, sum} = a + b;    
    
endmodule