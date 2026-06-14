module AUX_IF_TB;

    reg sys_clk;
    reg  sys_rst;
    reg [31:0] aux_in;
    wire [31:0] aux_i;
    
    AUX_IF DUT(
            sys_clk,sys_rst,aux_in,
            aux_i
           );
           
    parameter CP = 20;
    
    always
    begin
        sys_clk = 1'd0;
        #(CP/2);
        sys_clk = 1'd1;
        #(CP/2);
    end
    
    initial
    begin
        $monitor("TIME = %0d, sys_clk = %0d, sys_rst = %0d, aux_in = %0d, aux_i = %0d",$time,sys_clk,sys_rst,aux_in,aux_i);
        #1000;
        $finish;
    end
    
    initial
    begin
        //reset
        sys_rst = 1'd1;
        aux_in = 1'd0;
        #(CP*2);
        //deassert reset
        sys_rst = 1'd0;
        #(CP*2);
        //send data        
        aux_in = 32'd1;
        #(CP*2);       
        aux_in = 32'd2;
        #(CP*2);        
        aux_in = 32'd4;
        #(CP*2);        
        aux_in = 32'd8;
        #(CP*2);        
        aux_in = 32'd16;
        #(CP*2);        
        aux_in = 32'd32;
        #(CP*2);       
        aux_in = 32'd64;
        #(CP*2);        
        aux_in = 32'd128;
        #(CP*2);        
        aux_in = 32'd256;
        #(CP*2);        
        aux_in = 32'd512;
        #(CP*2);       
        aux_in = 32'd1024;
        #(CP*2);        
        aux_in = 32'd512;
        #(CP*2);        
        aux_in = 32'd256;
        #(CP*2);        
        aux_in = 32'd128;
        #(CP*2);        
        aux_in = 32'd64;
        #(CP*2);        
        aux_in = 32'd32;
        #(CP*2);        
        aux_in = 32'd16;
        #(CP*2);        
        aux_in = 32'd8;
        #(CP*2);        
        aux_in = 32'd4;
        #(CP*2);        
        aux_in = 32'd2;
        #(CP*2);        
        aux_in = 32'd1;
        #(CP*2);           
         //reset
        sys_rst = 1'd1;
        #(CP*2);   
    end
endmodule