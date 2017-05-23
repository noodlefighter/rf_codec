module manchester_decoder (
    input  clk2x, rst_n, enable, din,
    output dout, error
);
    reg fifo[1:0];
    reg syn_flg, error_buf, dout_buf;
    reg clk1x;

    /* syn_flg and fifo */
    always @(posedge clk2x)
    begin
        if (!rst_n)
            syn_flg <= 0;
        else begin            
            fifo <= {din, fifo[1]};       /* 2bits fifo buffer */
            if ((fifo == 2'b00) || (fifo == 2'b11))
                syn_flg <= 1;
            else 
                syn_flg <= 0;   //todo: 有毛病 删掉 
        end
    end

    /* divider */
    always @(posedge clk2x)
    begin
        if (!rst_n)
            clk1x <= 0;
        else if (syn_flg)
            clk1x <= ~clk1x;
    end

    /* decoder */
    always @(posedge clk1x)
    begin
        if (!rst_n || !syn_flg)
        begin
            error_buf <= 1;            
            dout_buf  <= 0;
        end
        else begin
            case (fifo)
                2'b10: begin
                    dout_buf  <= 1;
                    error_buf <= 0;   
                end

                2'b01: begin
                    dout_buf  <= 0;
                    error_buf <= 0;   
                end

                default: begin
                    error_buf <= 1;   
                end
            endcase 
        end
    end

    assign error = (enable) ? error_buf : 'bz;
    assign dout =  (enable) ? dout_buf  : 'bz;

endmodule