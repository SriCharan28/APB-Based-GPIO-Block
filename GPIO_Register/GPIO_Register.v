module GPIO_Regiser
(
gpio_eclk,sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,aux_i,in_pad_i,
gpio_inta_o,gpio_dat_o,out_pad_o,oen_padeo_o
);
    input wire gpio_eclk,sys_clk;
    input wire sys_rst;
    input wire gpio_we;
    input wire [31:0] gpio_addr;
    input wire [31:0] gpio_dat_i,aux_i,in_pad_i;
    
    output wire gpio_inta_o;
    output wire [31:0] out_pad_o;
    output wire [31:0] oen_padeo_o;
    output reg [31:0] gpio_dat_o;
    
    reg [1:0] RGPIO_CTRL;
    reg [31:0] RGPIO_PTRIG,RGPIO_INTE,RGPIO_INTS;
    reg [31:0] RGPIO_ECLK,RGPIO_NEC;
    reg [31:0] RGPIO_OUT,RGPIO_AUX;
    reg [31:0] RGPIO_OE;    
    reg [31:0] RGPIO_IN;
    
   reg [31:0] pedge_ext_data,nedge_ext_data;
   wire [31:0] ext_data,in_data;
   
    parameter [5:0] RGPIO_IN_ADDR = 6'h00, 
                    RGPIO_OUT_ADDR = 6'h04,
                    RGPIO_OE_ADDR = 6'h08,                     
                    RGPIO_INTE_ADDR = 6'h0c, 
                    RGPIO_PTRIG_ADDR = 6'h10,                    
                    RGPIO_AUX_ADDR = 6'h14, 
                    RGPIO_CTRL_ADDR = 6'h18,                   
                    RGPIO_INTS_ADDR = 6'h1c, 
                    RGPIO_ECLK_ADDR = 6'h20,                    
                    RGPIO_NEC_ADDR = 6'h24;
 
   //RGPIO_OUT                 
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_OUT <= 32'd0;
        end
        else if((gpio_addr == RGPIO_OUT_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_OUT <= gpio_dat_i;
        end
        else
        begin
            RGPIO_OUT <= RGPIO_OUT;
        end
   end
                    
   //RGPIO_OE              
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_OE <= 32'd0;
        end
        else if((gpio_addr == RGPIO_OE_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_OE <= gpio_dat_i;
        end
        else
        begin
            RGPIO_OE <= RGPIO_OE;
        end
   end
   
   //RGPIO_INTE                 
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_INTE <= 32'd0;
        end
        else if((gpio_addr == RGPIO_INTE_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_INTE <= gpio_dat_i;
        end
        else
        begin
            RGPIO_INTE <= RGPIO_INTE;
        end
   end
   
   //RGPIO_PTRIG                
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_PTRIG <= 32'd0;
        end
        else if((gpio_addr == RGPIO_PTRIG_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_PTRIG <= gpio_dat_i;
        end
        else
        begin
            RGPIO_PTRIG <= RGPIO_PTRIG;
        end
   end
                    
   //RGPIO_AUX                 
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_AUX <= 32'd0;
        end
        else if((gpio_addr == RGPIO_AUX_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_AUX <= gpio_dat_i;
        end
        else
        begin
            RGPIO_AUX <= RGPIO_AUX;
        end
   end
   
   //RGPIO_ECLK                
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_ECLK <= 32'd0;
        end
        else if((gpio_addr == RGPIO_ECLK_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_ECLK <= gpio_dat_i;
        end
        else
        begin
            RGPIO_ECLK <= RGPIO_ECLK;
        end
   end
   
   //RGPIO_NEC             
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_NEC <= 32'd0;
        end
        else if((gpio_addr == RGPIO_NEC_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_NEC <= gpio_dat_i;
        end
        else
        begin
            RGPIO_NEC <= RGPIO_NEC;
        end
   end

   //RGPIO_CTRL               
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_CTRL <= 2'd0;
        end
        else if((gpio_addr == RGPIO_CTRL_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_CTRL <= gpio_dat_i[1:0];
        end
        else if(RGPIO_CTRL[0]==1'd1)
        begin
            RGPIO_CTRL[1] <= RGPIO_CTRL[1] | gpio_inta_o;
        end
        else
        begin
            RGPIO_CTRL <= RGPIO_CTRL;
        end
   end 
      
   //RGPIO_IN          
   always@(posedge gpio_eclk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            pedge_ext_data <= 32'd0;
        end
        else
        begin
             pedge_ext_data <= in_pad_i;       
        end
   end 
   
   always@(negedge gpio_eclk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            nedge_ext_data <= 32'd0;
        end
        else
        begin
             nedge_ext_data <= in_pad_i;       
        end
   end 
   
   //assign ext_data = (|RGPIO_NEC == 1'd1) ? nedge_ext_data : pedge_ext_data;
  
  // assign in_data = (|RGPIO_ECLK == 1'd1) ? ext_data : in_pad_i;
   
   assign ext_data = (~RGPIO_NEC & pedge_ext_data) | (RGPIO_NEC & nedge_ext_data);
 
   assign in_data = (~RGPIO_ECLK & in_pad_i) | (RGPIO_ECLK & ext_data);   
     
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_IN <= 32'd0;
        end
        else
        begin
            RGPIO_IN <= in_data;
        end
   end 
   
   //RGPIO_INTS               
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            RGPIO_INTS <= 32'd0;
        end
        else if((gpio_addr == RGPIO_INTS_ADDR) && (gpio_we == 1'd1))
        begin
            RGPIO_INTS <= gpio_dat_i;
        end
        else if(RGPIO_CTRL[0]==1'd1)
        begin
            RGPIO_INTS <= (RGPIO_INTS | (((in_data ^ RGPIO_IN) & (~(in_data ^ RGPIO_PTRIG))) & RGPIO_INTE));
        end
        else
        begin
            RGPIO_INTS <= RGPIO_INTS;
        end
   end    
   
   //gpio_dat_o
   always@(posedge sys_clk,posedge sys_rst)
   begin
        if(sys_rst == 1'd1)
        begin
            gpio_dat_o <= 32'd0;
        end
        else
        begin
            case(gpio_addr)
                RGPIO_IN_ADDR : gpio_dat_o <= RGPIO_IN;                 
                RGPIO_OUT_ADDR : gpio_dat_o <= RGPIO_OUT;                 
                RGPIO_OE_ADDR : gpio_dat_o <= RGPIO_OE;                 
                RGPIO_INTE_ADDR : gpio_dat_o <= RGPIO_INTE;                 
                RGPIO_PTRIG_ADDR : gpio_dat_o <= RGPIO_PTRIG;                 
                RGPIO_AUX_ADDR : gpio_dat_o <= RGPIO_AUX;                 
                RGPIO_CTRL_ADDR : gpio_dat_o <= RGPIO_CTRL;                 
                RGPIO_INTS_ADDR : gpio_dat_o <= RGPIO_INTS;                 
                RGPIO_ECLK_ADDR : gpio_dat_o <= RGPIO_ECLK;                 
                RGPIO_NEC_ADDR : gpio_dat_o <= RGPIO_NEC; 
                default : gpio_dat_o <= RGPIO_IN;
            endcase
        end
   end
   //oen_padoe_o
   assign oen_padeo_o = RGPIO_OE;
   
   //gpio_inta_o
   assign gpio_inta_o = ((|RGPIO_INTS) == 1'd1) ? RGPIO_CTRL[0] : 1'd0;
   
   //out_pad_o
   //assign out_pad_o = (|RGPIO_AUX == 1'd1) ? aux_i : RGPIO_OUT;
   assign out_pad_o = (~RGPIO_AUX & RGPIO_OUT) | (RGPIO_AUX & aux_i);
   
endmodule
