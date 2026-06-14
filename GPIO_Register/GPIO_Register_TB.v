module GPIO_Register_TB;
    reg gpio_eclk,sys_clk;
    reg sys_rst;
    reg gpio_we;
    reg [31:0] gpio_addr;
    reg [31:0] gpio_dat_i,aux_i,in_pad_i;
    
    wire gpio_inta_o;
    wire [31:0] gpio_dat_o,out_pad_o;
    wire [31:0] oen_padeo_o;
    
    GPIO_Regiser DUT(
                    gpio_eclk,sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,aux_i,in_pad_i,
                    gpio_inta_o,gpio_dat_o,out_pad_o,oen_padeo_o
                    );
 
    parameter CP = 20;
    
    wire [1:0] RGPIO_CTRL = DUT.RGPIO_CTRL;
    wire [31:0] RGPIO_PTRIG = DUT.RGPIO_PTRIG;
    wire [31:0] RGPIO_INTE = DUT.RGPIO_INTE;
    wire [31:0] RGPIO_INTS = DUT.RGPIO_INTS;
    wire [31:0] RGPIO_ECLK = DUT.RGPIO_ECLK;
    wire [31:0] RGPIO_NEC = DUT.RGPIO_NEC;
    wire [31:0] RGPIO_OUT = DUT.RGPIO_OUT;
    wire [31:0] RGPIO_AUX= DUT.RGPIO_AUX;
    wire [31:0] RGPIO_OE = DUT.RGPIO_OE;    
    wire [31:0] RGPIO_IN = DUT.RGPIO_IN;
    
    //sys_clk
    always
    begin
        sys_clk = 1'd0;
        #(CP/2);
        sys_clk = 1'd1;
        #(CP/2);        
    end                
    
    //gpio_eclk
    always
    begin
        gpio_eclk = 1'd0;
        #(CP);
        gpio_eclk = 1'd1;
        #(CP);        
    end        
      
    initial
    begin
        //Reset
        sys_rst = 1'd1;
        #(CP*2);
        //RGPIO_OUT        
        sys_rst = 1'd0;  
        gpio_we = 1'd1;     
        gpio_addr = 6'h04;
        gpio_dat_i = 6'h04;        
        #(CP*2);
        //RGPIO_OE
        gpio_addr = 6'h08;
        gpio_dat_i = 6'h08;           
        #(CP*2);     
        //RGPIO_INTE
        gpio_addr = 6'h0c;
        gpio_dat_i = 6'h0c;        
        #(CP*2);
        //RGPIO_PTRIG
        gpio_addr = 6'h10;
        gpio_dat_i = 6'h10;        
        #(CP*2);
        //RGPIO_AUX
        gpio_addr = 6'h14;
        gpio_dat_i = 6'h14;        
        #(CP*2);
        //RGPIO_CTRL
        gpio_addr = 6'h18;
        gpio_dat_i = 2'd2;             
         #(CP*2);  
        //RGPIO_INTS
        gpio_addr = 6'h1c;
        gpio_dat_i = 6'h1c;        
        #(CP*2);
        //RGPIO_ECLK
        gpio_addr = 6'h20;
        gpio_dat_i = 6'h20;                
        #(CP*2);
        //RGPIO_NEC
        gpio_addr = 6'h24;
        gpio_dat_i = 6'h24;        
        #(CP*2);
        //out_pad_o due to RGPIO_OUT      
        gpio_addr = 6'h14; //RGPIO_AUX
        gpio_dat_i = 32'd0; //RGPIO_AUX             
        #(CP*2);    
        gpio_addr = 6'h4; //RGPIO_OUT
        gpio_dat_i = 32'd32;  //RGPIO_OUT             
        #(CP*2);    
        //out_pad_o due to aux_i
        aux_i = 32'd16;        
        gpio_addr = 6'h14; //RGPIO_AUX
        gpio_dat_i = 32'hffff_ffff; //RGPIO_AUX          
        #(CP*2);    
        //RGPIO_IN due to sys_clk
        gpio_addr = 6'h20; //RGPIO_ECLK
        gpio_dat_i = 32'd0; //RGPIO_ECLK
        in_pad_i = 32'd64;        
        #(CP*2);          
        //RGPIO_IN due to positive edge external clock
        gpio_addr = 6'h20;  //RGPIO_ECLK
        gpio_dat_i = 32'hffff_ffff; //RGPIO_ECLK
        #(CP*2);            
        gpio_addr = 6'h24; //RGPIO_NEC
        gpio_dat_i = 32'd0; //RGPIO_NEC               
        in_pad_i = 32'd8;        
        #(CP*2);          
        //RGPIO_IN due to negative edge external clock         
        gpio_addr = 6'h24; //RGPIO_NEC
        gpio_dat_i = 32'hffff_ffff; //RGPIO_NEC               
        in_pad_i = 32'd4;        
        #(CP*2); 
        /*
        //gpio_inta_o due to postitve edge
        gpio_addr = 6'h20; //RGPIO_ECLK
        gpio_dat_i = 32'd0; //RGPIO_ECLK
        in_pad_i = 32'd0;         
        #(CP*2); 
        gpio_addr = 6'h18;  //RGPIO_CTRL
        gpio_dat_i = 2'd1;  //RGPIO_CTRL            
        #(CP*2);      
        gpio_addr = 6'h0c;  //RGPIO_INTE
        gpio_dat_i = 32'hffff_ffff; //RGPIO_INTE          
        #(CP*2);  
        gpio_addr = 6'h10;  //RGPIO_PTRIG
        gpio_dat_i = 32'hffff_ffff; //RGPIO_PTRIG          
        #(CP*2);       
        in_pad_i = 32'hffff_ffff;           
        #(CP*2);     
        */
        //gpio_inta_o due to negatve edge
        in_pad_i = 32'hffff_ffff;       
        #(CP*2); 
        gpio_addr = 6'h18;  //RGPIO_CTRL
        gpio_dat_i = 2'd1;  //RGPIO_CTRL            
        #(CP*2);      
        gpio_addr = 6'h0c;  //RGPIO_INTE
        gpio_dat_i = 32'hffff_ffff; //RGPIO_INTE          
        #(CP*2);  
        gpio_addr = 6'h10;  //RGPIO_PTRIG
        gpio_dat_i = 32'd0; //RGPIO_PTRIG          
        #(CP*2);      
        in_pad_i = 32'd0;  
        
    end
    
    initial
    begin
        #1000;
        $finish;
    end
    
endmodule