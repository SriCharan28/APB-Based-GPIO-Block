module APB_GPIO
(
PCLK,PRESET,PSEL,PENABLE,PWRITE,PADDR,PWDATA,aux_in,ext_clk_pad_i,
io_pad,
PREADY,IRQ,PRDATA
);

    input wire PCLK;
    input wire PRESET;
    input wire PSEL,PENABLE;
    input wire PWRITE;
    input wire [31:0] PADDR;
    input wire [31:0] PWDATA;
    input wire [31:0] aux_in;
    input wire ext_clk_pad_i;
    
    inout wire [31:0] io_pad;
    
    output wire PREADY;
    output wire IRQ;
    output wire [31:0] PRDATA;
    
    //Internal Signals    
    wire sys_clk; //APB_Slave_IF,GPIO_Register,AUX_IF
    wire sys_rst; //APB_Slave_IF,GPIO_Register,AUX_IF
    wire gpio_inta_o; //APB_Slave_IF,GPIO_Register    
    wire gpio_we; //APB_Slave_IF,GPIO_Register
    wire [31:0] gpio_dat_o; //APB_Slave_IF,GPIO_Register
    wire [31:0] gpio_addr; //APB_Slave_IF,GPIO_Register
    wire [31:0] gpio_dat_i; //APB_Slave_IF,,GPIO_Register
    wire gpio_eclk; //GPIO_Register,IO_IF
    wire [31:0] aux_i; //GPIO_Register,AUX_IF
    wire [31:0] in_pad_i; //GPIO_Register,IO_IF
    wire [31:0] out_pad_o; //GPIO_Register,IO_IF 
    wire [31:0] oen_padeo_o; //GPIO_Register,IO_IF
    
    APB_Slave_IF DUT1(
                        PCLK,PRESET,PSEL,PENABLE,PWRITE,PADDR,PWDATA,gpio_inta_o,gpio_dat_o,
                        sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,IRQ,PREADY,PRDATA
                      );

    GPIO_Regiser DUT2(
                        gpio_eclk,sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,aux_i,in_pad_i,
                        gpio_inta_o,gpio_dat_o,out_pad_o,oen_padeo_o
                     );

    AUX_IF DUT3(
                sys_clk,sys_rst,aux_in,
                aux_i
                );

    IO_IF DUT4(
                out_pad_o,oen_padeo_o,ext_clk_pad_i,
                io_pad,
                in_pad_i,gpio_eclk
              );

endmodule
