module APB_Slave_IF
(
PCLK,PRESET,PSEL,PENABLE,PWRITE,PADDR,PWDATA,gpio_inta_o,gpio_dat_o,
sys_clk,sys_rst,gpio_we,gpio_addr,gpio_dat_i,IRQ,PREADY,PRDATA
);
    input wire PCLK;
    input wire PRESET;
    input wire PSEL,PENABLE;
    input wire PWRITE;        
    input wire [31:0] PADDR;
    input wire [31:0] PWDATA;
    input wire gpio_inta_o;
    input wire [31:0] gpio_dat_o;
    
    output wire sys_clk,sys_rst;
    output reg gpio_we; 
    output wire [31:0] gpio_addr;   
    output reg [31:0] gpio_dat_i;    
    output wire IRQ;
    output wire PREADY;    
    output reg [31:0] PRDATA;
    
    parameter [1:0] IDLE = 2'd0, SETUP = 2'd1, ACCESS = 2'd2;
    
    reg [1:0] current_state,next_state;
    
    assign sys_clk = PCLK;
    assign sys_rst = PRESET;
    assign gpio_addr = PADDR;
    assign IRQ = gpio_inta_o;
    assign PREADY = ((current_state == ACCESS) || ((PRESET == 1'd1) && (current_state == IDLE ))) ? 1'd1 : 1'd0; 
    
    always@(posedge PCLK)
    begin
        if(PRESET)
        begin
            current_state <= IDLE;
        end
        else
        begin
            current_state <= next_state;
        end
    end
    
    always@*
    begin
        case(current_state)
            IDLE:
                begin
                    if(PENABLE == 1'd0 && PSEL == 1'd1)
                    begin
                        next_state = SETUP;
                    end
                    else
                    begin
                        next_state = IDLE;
                    end
                end
            SETUP:                
                begin
                    if(PENABLE == 1'd1 && PSEL == 1'd1)
                    begin
                        next_state = ACCESS;
                    end
                    else
                    begin
                        next_state = SETUP;
                    end
                end
            ACCESS:                
                begin
                    case(PSEL)
                        1'd0:next_state = IDLE;
                        1'd1:next_state = SETUP;
                    endcase
                end
            default:next_state = IDLE;
        endcase
    end
    
    always@*
    begin
        if(current_state == ACCESS && PWRITE == 1'd1)
        begin
            gpio_we = 1'd1;
            gpio_dat_i = PWDATA;
            PRDATA = 1'd0;
        end
        else if(current_state == ACCESS && PWRITE == 1'd0)
        begin
            gpio_we = 1'd0;
            gpio_dat_i = 1'd0;
            PRDATA = gpio_dat_o;
        end 
        else
        begin
            gpio_we = 1'd0;
            gpio_dat_i = 1'd0;
            PRDATA = 1'd0;        
        end
    end
    
endmodule
