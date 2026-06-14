module APB_Slave_IF_TB;

    reg PCLK;
    reg PRESET;
    reg PSEL,PENABLE;
    reg PWRITE;        
    reg [31:0] PADDR;
    reg [31:0] PWDATA;
    reg gpio_inta_o;
    reg [31:0] gpio_dat_o;
   
    wire sys_clk,sys_rst;
    wire gpio_we; 
    wire [31:0] gpio_addr;   
    wire [31:0] gpio_dat_i;    
    wire IRQ;
    wire PREADY;    
    wire [31:0] PRDATA;
    
    APB_Slave_IF DUT(
        PCLK,PRESET,PSEL,PENABLE,PWRITE,PADDR,PWDATA,gpio_inta_o,gpio_dat_o,
        sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,IRQ,PREADY,PRDATA
                    );
          
    parameter Clock_Period = 20;
    
    wire [1:0] STATE = DUT.current_state;
    
    always 
    begin
        PCLK = 1'd0;
        #(Clock_Period/2);
        PCLK = 1'd1;
        #(Clock_Period/2);      
    end          
    
    initial
    begin
        //RESET
        PRESET=1'd1;
        PSEL=1'd0;
        PENABLE=1'd0;
        PWRITE=1'd0;
        PWDATA=32'd0;
        PADDR=32'd0;
        gpio_inta_o=1'd0;
        gpio_dat_o=1'd0;
        #(2*Clock_Period);
        //IDLE TO SETUP [WRITE]
        PRESET=1'd0;
        PSEL=1'd1;
        PADDR=32'd8;
        PWDATA=32'd64;
        PWRITE=1'd1;
        #(2*Clock_Period);
        //SETUP TO ACCESS 
        PENABLE=1'd1;
        #(2*Clock_Period); 
        //ACCESS [READ]
        PADDR=32'd2;
        gpio_dat_o=32'd16;
        PWRITE=1'd0;
        #(2*Clock_Period); 
        //IRQ
        gpio_inta_o=1'd1;
        #(2*Clock_Period);               
        //RESET
        PRESET=1'd1;        
        PSEL=1'd0;
        PENABLE=1'd0;
        PWRITE=1'd0;
        PWDATA=32'd0;
        PADDR=32'd0;
        gpio_inta_o=1'd0;
        gpio_dat_o=1'd0;
        #(2*Clock_Period);  
        //IDLE TO SETUP [READ]
        PRESET=1'd0;
        PSEL=1'd1;
        PADDR=32'd8;
        gpio_dat_o=32'd64;
        PWRITE=1'd0;
        #(2*Clock_Period);
        //SETUP TO ACCESS 
        PENABLE=1'd1;
        #(2*Clock_Period); 
        //ACCESS [WRITE]
        PADDR=32'd2;
        PWDATA=32'd16;
        PWRITE=1'd1;
        #(2*Clock_Period);    
    end

    initial 
    begin
        $monitor("TIME = %0d\n PRESET = %0d , sys_rst = %0d\n PSEL = %0d, PENALBE = %0d\n PWRITE = %0d, gpio_we = %0d \n PADDR = %0d, gpio_addr = %0d \n PWDATA = %0d, gpio_dat_i = %0d \n IRQ = %0d, gpio_inta_o = %0d \n PRDATA = %0d, gpio_dat_o = %0d \n PREADY = %0d, STATE = %0d",$time,PRESET,sys_rst,PSEL,PENABLE,PWRITE,gpio_we,PADDR,gpio_addr,PWDATA,gpio_dat_i,IRQ,gpio_inta_o,PRDATA,gpio_dat_o,PREADY,STATE);
        #1000;
        $finish;
    end

endmodule