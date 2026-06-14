module APB_GPIO_TB;

    reg PCLK;
    reg PRESET;
    reg PSEL,PENABLE;
    reg PWRITE;
    reg [31:0] PADDR;
    reg [31:0] PWDATA;
    reg [31:0] aux_in;
    reg ext_clk_pad_i;
    
    wire [31:0] io_pad;
    
    wire PREADY;
    wire IRQ;
    wire [31:0] PRDATA;
    
    APB_GPIO DUT(
                PCLK,PRESET,PSEL,PENABLE,PWRITE,PADDR,PWDATA,aux_in,ext_clk_pad_i,
                io_pad,
                PREADY,IRQ,PRDATA
             );
             
    parameter TC = 20;
    
    reg [31:0] io_pad_temp;

    assign io_pad[0] = ((PADDR == 32'd8) && (PWDATA[0] == 1'd0)) ? io_pad_temp[0] : 1'dz;    
    assign io_pad[1] = ((PADDR == 32'd8) && (PWDATA[1] == 1'd0)) ? io_pad_temp[1] : 1'dz;    
    assign io_pad[2] = ((PADDR == 32'd8) && (PWDATA[2] == 1'd0)) ? io_pad_temp[2] : 1'dz;    
    assign io_pad[3] = ((PADDR == 32'd8) && (PWDATA[3] == 1'd0)) ? io_pad_temp[3] : 1'dz;
    assign io_pad[4] = ((PADDR == 32'd8) && (PWDATA[4] == 1'd0)) ? io_pad_temp[4] : 1'dz;   
    assign io_pad[5] = ((PADDR == 32'd8) && (PWDATA[5] == 1'd0)) ? io_pad_temp[5] : 1'dz;   
    assign io_pad[6] = ((PADDR == 32'd8) && (PWDATA[6] == 1'd0)) ? io_pad_temp[6] : 1'dz;   
    assign io_pad[7] = ((PADDR == 32'd8) && (PWDATA[7] == 1'd0)) ? io_pad_temp[7] : 1'dz;
    assign io_pad[8] = ((PADDR == 32'd8) && (PWDATA[8] == 1'd0)) ? io_pad_temp[8] : 1'dz;   
    assign io_pad[9] = ((PADDR == 32'd8) && (PWDATA[9] == 1'd0)) ? io_pad_temp[9] : 1'dz;    
    assign io_pad[10] = ((PADDR == 32'd8) && (PWDATA[10] == 1'd0)) ? io_pad_temp[10] : 1'dz;    
    assign io_pad[11] = ((PADDR == 32'd8) && (PWDATA[11] == 1'd0)) ? io_pad_temp[11] : 1'dz;
    assign io_pad[12] = ((PADDR == 32'd8) && (PWDATA[12] == 1'd0)) ? io_pad_temp[12] : 1'dz; 
    assign io_pad[13] = ((PADDR == 32'd8) && (PWDATA[13] == 1'd0)) ? io_pad_temp[13] : 1'dz;    
    assign io_pad[14] = ((PADDR == 32'd8) && (PWDATA[14] == 1'd0)) ? io_pad_temp[14] : 1'dz;    
    assign io_pad[15] = ((PADDR == 32'd8) && (PWDATA[15] == 1'd0)) ? io_pad_temp[15] : 1'dz;
    assign io_pad[16] = ((PADDR == 32'd8) && (PWDATA[16] == 1'd0)) ? io_pad_temp[16] : 1'dz;    
    assign io_pad[17] = ((PADDR == 32'd8) && (PWDATA[17] == 1'd0)) ? io_pad_temp[17] : 1'dz;    
    assign io_pad[18] = ((PADDR == 32'd8) && (PWDATA[18] == 1'd0)) ? io_pad_temp[18] : 1'dz;   
    assign io_pad[19] = ((PADDR == 32'd8) && (PWDATA[19] == 1'd0)) ? io_pad_temp[19] : 1'dz;
    assign io_pad[20] = ((PADDR == 32'd8) && (PWDATA[20] == 1'd0)) ? io_pad_temp[20] : 1'dz;  
    assign io_pad[21] = ((PADDR == 32'd8) && (PWDATA[21] == 1'd0)) ? io_pad_temp[21] : 1'dz; 
    assign io_pad[22] = ((PADDR == 32'd8) && (PWDATA[22] == 1'd0)) ? io_pad_temp[22] : 1'dz;   
    assign io_pad[23] = ((PADDR == 32'd8) && (PWDATA[23] == 1'd0)) ? io_pad_temp[23] : 1'dz;
    assign io_pad[24] = ((PADDR == 32'd8) && (PWDATA[24] == 1'd0)) ? io_pad_temp[24] : 1'dz;    
    assign io_pad[25] = ((PADDR == 32'd8) && (PWDATA[25] == 1'd0)) ? io_pad_temp[25] : 1'dz;   
    assign io_pad[26] = ((PADDR == 32'd8) && (PWDATA[26] == 1'd0)) ? io_pad_temp[26] : 1'dz;    
    assign io_pad[27] = ((PADDR == 32'd8) && (PWDATA[27] == 1'd0)) ? io_pad_temp[27] : 1'dz;
    assign io_pad[28] = ((PADDR == 32'd8) && (PWDATA[28] == 1'd0)) ? io_pad_temp[28] : 1'dz;    
    assign io_pad[29] = ((PADDR == 32'd8) && (PWDATA[29] == 1'd0)) ? io_pad_temp[29] : 1'dz;    
    assign io_pad[30] = ((PADDR == 32'd8) && (PWDATA[30] == 1'd0)) ? io_pad_temp[30] : 1'dz;   
    assign io_pad[31] = ((PADDR == 32'd8) && (PWDATA[31] == 1'd0)) ? io_pad_temp[31] : 1'dz;
    
    always
    begin
        PCLK = 1'd0;
        #(TC/2);
        PCLK = 1'd1;
        #(TC/2);
    end                 
    
    always
    begin
        ext_clk_pad_i = 1'd0;
        #(TC);
        ext_clk_pad_i = 1'd1;
        #(TC);
    end         
    
    initial
    begin
        //RESET
        PRESET = 1'd1;        
        PSEL = 1'd0;
        PENABLE = 1'd0;
        PWRITE = 1'd0;
        PWDATA = 32'd0;
        PADDR = 32'd0;
        aux_in = 32'd0;        
        io_pad_temp = 32'd0;
        #(2*TC);
        
                       
         /*
        //Data due to RGPIO_OUT
        //RGPIO_OUT [WRITE]
        //ACCESS TO IDLE [WRITE]         
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWDATA = 32'd16;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);   
                
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);  
          
        //RGPIO_OUT [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWRITE = 1'd0;
        #(2*TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(2*TC);         
        
        //RGPIO_OE [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWRITE = 1'd0;
        #(2*TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(2*TC);         
        

        //Data due to aux_in                           
        //aux_in
        //ACCESS TO IDLE [WRITE]      
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd7;
        aux_in = 32'd7;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);          
        
        //RGPIO_AUX [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h14;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);         
        
        //RGPIO_AUX [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'h14;
        PWRITE = 1'd0;
        #(2*TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(2*TC); 
       */
        
                
        /*        
        //Data due to io_pad [sys_clk]                    
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'd0;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);            
           
        io_pad_temp = 32'd512;
        #(2*TC);          
        */
        
        
        ///*
        //Data due to io_pad [-ve edge External Clock]                   
        //RGPIO_ECLK [WRITE]      
        //ACCESS TO IDLE [WRITE]            
        PRESET = 1'd0;    
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h20;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(TC);  
        
        //RGPIO_NEC [WRITE]      
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h24;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(TC);            
        
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'd0;
        PWRITE = 1'd1;
        #(TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(TC);   
        
        io_pad_temp = 32'd256;
        #(TC);                          
        
        //RGPIO_IN [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'h0;
        PWRITE = 1'd0;
        #(TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(TC);       
        
        //RGPIO_OE [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'h8;
        PWRITE = 1'd0;
        #(TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(TC);         
                
        //RGPIO_ECLK [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'h20;
        PWRITE = 1'd0;
        #(TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(TC);
        
        //RGPIO_NEC [READ]
        //ACCESS TO IDLE [READ]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'h24;
        PWRITE = 1'd0;
        #(TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(TC);             
        //*/    
        
        
        /*        
        //Data due to io_pad and RGPIO_OUT[sys_clk]          
        PRESET = 1'd0;          
        io_pad_temp = 32'h9876_6789;
        #(2*TC);  
        
        //RGPIO_OUT [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWDATA = 32'h1234_4321;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);          
        
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'h0000_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);                                 
        */
        
            
        /*
        //IRQ
        //RGPIO_OUT [WRITE]
        //ACCESS TO IDLE [WRITE]        
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWDATA = 32'd0;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);   
                
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);        
        
        //RGPIO_PTRIG [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h10;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);        
        
        //RGPIO_INTE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h0c;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);        
        
        //RGPIO_CTRL [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h18;
        PWDATA = 2'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);
         
        //RGPIO_OUT [WRITE]
        //ACCESS TO IDLE [WRITE]    
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);                    
        */
    end
    
    initial
    begin
        #1000;
        $finish;
    end
endmodule

        /*           
        //Data due to io_pad [+ve edge External Clock]                        
        //RGPIO_ECLK [WRITE]      
        //ACCESS TO IDLE  [WRITE]            
        PRESET = 1'd0;   
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h20;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);    
        
        io_pad_temp = 32'd128;
        #(2*TC);
                           
        //RGPIO_OE [WRITE]
        //ACCESS TO IDLE [WRITE]
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'd0;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);             
        */
        
        /*
        //APB
        //IDLE TO SETUP [WRITE]
        PRESET = 1'd0;
        PSEL = 1'd1;
        PADDR = 32'd6;
        PWDATA = 32'd6;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);  
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);         
        //IDLE TO SETUP [READ]
        PSEL = 1'd1;
        PADDR = 32'd6;
        PWRITE = 1'd0;
        #(2*TC);        
        //SETUP TO ACCESS [READ]
        PENABLE = 1'd1;
        #(2*TC);         
        */

        /*
        //Data due to io_pad due to RGPIO_OUT [+ve edge External Clock]  
        //RGPIO_ECLK      
        //ACCESS TO IDLE        
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h20;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);         
        
        //RGPIO_NEC      
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h24;
        PWDATA = 32'd0;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);             
        
        //RGPIO_OUT
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd4;
        PWDATA = 32'd32;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);   
        
        //RGPIO_OE
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd8;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);  
        */            
        
        
        /*
        //Data due to io_pad due to aux_in [-ve edge External Clock]  
        //RGPIO_ECLK      
        //ACCESS TO IDLE        
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h20;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);         
        
        //RGPIO_NEC      
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h24;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);   
                  
        //aux_in
        //ACCESS TO IDLE        
        PRESET = 1'd0;
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'd9;
        aux_in = 32'd64;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);          
        
        //RGPIO_AUX
        //ACCESS TO IDLE
        PSEL = 1'd0;
        PENABLE = 1'd0;        
        #(2*TC);  
        //IDLE TO SETUP [WRITE]
        PSEL = 1'd1;
        PADDR = 32'h14;
        PWDATA = 32'hffff_ffff;
        PWRITE = 1'd1;
        PWRITE = 1'd1;
        #(2*TC);
        //SETUP TO ACCESS [WRITE]
        PENABLE = 1'd1;
        #(2*TC);
        */