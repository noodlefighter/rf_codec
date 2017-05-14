module manchester_encoder (rst_n, clk2x, din, enable, dout, ready);
    input  rst_n, clk2x, din, enable;
    output dout, ready;
    reg    din_buf, state, ready_reg; 

    always @(clk2x)
    begin 
        if (clk2x) 
        begin 
            // posedge
            din_buf   <= din;   
            state     <= 0;            
        end 
        else begin            
            // negedge
            state     <= 1;            
        end
    end 

    always @(posedge clk2x or negedge enable or negedge rst_n)
    begin
        if (!rst_n) 
        begin            
            ready_reg = 0;  // reset
        end
        else begin
            if (!enable)
                ready_reg <= 0;
            else
                ready_reg <= enable & clk2x;
        end
    end 

    assign dout  = ready_reg & (state ^ din_buf);  
    assign ready = ready_reg;
endmodule