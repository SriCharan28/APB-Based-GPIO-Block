module IO_IF
(
out_pad_o,oen_padeo_o,ext_clk_pad_i,
io_pad,
in_pad_i,gpio_eclk
);

    input wire [31:0] out_pad_o;
    input wire [31:0] oen_padeo_o;
    input wire ext_clk_pad_i;
    
    inout wire [31:0] io_pad;
    
    output wire [31:0] in_pad_i;
    output wire gpio_eclk;
    
    assign gpio_eclk = ext_clk_pad_i;
    
    //assign io_pad = (((~oen_padeo_o) & 32'b0)|(oen_padeo_o & out_pad_o)); 
    
    ///*
    genvar i;
    generate for(i=0;i<32;i=i+1)
        begin
            assign io_pad[i] = (oen_padeo_o[i] == 1'd1) ? out_pad_o[i] : 1'dz;
        end
    endgenerate
    //*/
    
    /*   
    genvar i;
    generate for(i=0;i<32;i=i+1)
    begin
        assign io_pad[i] = (oen_padeo_o[i] == 1'd1) ? out_pad_o[i] : 1'd0;
    end
    */
    
    assign in_pad_i = io_pad;
    
endmodule
