module AUX_IF
(
sys_clk,sys_rst,aux_in,
aux_i
);
    input wire sys_clk;
    input wire sys_rst;
    input wire [31:0] aux_in;
    output reg [31:0] aux_i;
    
    always@(posedge sys_clk)
    begin
        if(sys_rst == 1'd1)
        begin
            aux_i <= 32'd0;
        end
        else
        begin
            aux_i <= aux_in;
        end
    end
    
endmodule
