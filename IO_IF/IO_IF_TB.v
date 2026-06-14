module IO_IF_TB;

    reg [31:0] out_pad_o;
    reg [31:0] oen_padeo_o;
    reg ext_clk_pad_i;
    
    wire [31:0] io_pad;
    
    wire [31:0] in_pad_i;
    wire gpio_eclk;
    
    IO_IF DUT(
                out_pad_o,oen_padeo_o,ext_clk_pad_i,
                io_pad,
                in_pad_i,gpio_eclk
              );
              
   ///*
    reg [31:0] io_pad_temp;
    
    assign io_pad[0] = (oen_padeo_o[0] == 1'd0) ? io_pad_temp[0] : 1'dz;    
    assign io_pad[1] = (oen_padeo_o[1] == 1'd0) ? io_pad_temp[1] : 1'dz;    
    assign io_pad[2] = (oen_padeo_o[2] == 1'd0) ? io_pad_temp[2] : 1'dz;    
    assign io_pad[3] = (oen_padeo_o[3] == 1'd0) ? io_pad_temp[3] : 1'dz;
    assign io_pad[4] = (oen_padeo_o[4] == 1'd0) ? io_pad_temp[4] : 1'dz;    
    assign io_pad[5] = (oen_padeo_o[5] == 1'd0) ? io_pad_temp[5] : 1'dz;    
    assign io_pad[6] = (oen_padeo_o[6] == 1'd0) ? io_pad_temp[6] : 1'dz;    
    assign io_pad[7] = (oen_padeo_o[7] == 1'd0) ? io_pad_temp[7] : 1'dz;
    assign io_pad[8] = (oen_padeo_o[8] == 1'd0) ? io_pad_temp[8] : 1'dz;    
    assign io_pad[9] = (oen_padeo_o[9] == 1'd0) ? io_pad_temp[9] : 1'dz;    
    assign io_pad[10] = (oen_padeo_o[10] == 1'd0) ? io_pad_temp[10] : 1'dz;    
    assign io_pad[11] = (oen_padeo_o[11] == 1'd0) ? io_pad_temp[11] : 1'dz;
    assign io_pad[12] = (oen_padeo_o[12] == 1'd0) ? io_pad_temp[12] : 1'dz;    
    assign io_pad[13] = (oen_padeo_o[13] == 1'd0) ? io_pad_temp[13] : 1'dz;    
    assign io_pad[14] = (oen_padeo_o[14] == 1'd0) ? io_pad_temp[14] : 1'dz;    
    assign io_pad[15] = (oen_padeo_o[15] == 1'd0) ? io_pad_temp[15] : 1'dz;
    assign io_pad[16] = (oen_padeo_o[16] == 1'd0) ? io_pad_temp[16] : 1'dz;    
    assign io_pad[17] = (oen_padeo_o[17] == 1'd0) ? io_pad_temp[17] : 1'dz;    
    assign io_pad[18] = (oen_padeo_o[18] == 1'd0) ? io_pad_temp[18] : 1'dz;    
    assign io_pad[19] = (oen_padeo_o[19] == 1'd0) ? io_pad_temp[19] : 1'dz;
    assign io_pad[20] = (oen_padeo_o[20] == 1'd0) ? io_pad_temp[20] : 1'dz;    
    assign io_pad[21] = (oen_padeo_o[21] == 1'd0) ? io_pad_temp[21] : 1'dz;    
    assign io_pad[22] = (oen_padeo_o[22] == 1'd0) ? io_pad_temp[22] : 1'dz;   
    assign io_pad[23] = (oen_padeo_o[23] == 1'd0) ? io_pad_temp[23] : 1'dz;
    assign io_pad[24] = (oen_padeo_o[24] == 1'd0) ? io_pad_temp[24] : 1'dz;    
    assign io_pad[25] = (oen_padeo_o[25] == 1'd0) ? io_pad_temp[25] : 1'dz;    
    assign io_pad[26] = (oen_padeo_o[26] == 1'd0) ? io_pad_temp[26] : 1'dz;    
    assign io_pad[27] = (oen_padeo_o[27] == 1'd0) ? io_pad_temp[27] : 1'dz;
    assign io_pad[28] = (oen_padeo_o[28] == 1'd0) ? io_pad_temp[28] : 1'dz;    
    assign io_pad[29] = (oen_padeo_o[29] == 1'd0) ? io_pad_temp[29] : 1'dz;    
    assign io_pad[30] = (oen_padeo_o[30] == 1'd0) ? io_pad_temp[30] : 1'dz;    
    assign io_pad[31] = (oen_padeo_o[31] == 1'd0) ? io_pad_temp[31] : 1'dz;
    //*/
            
    initial
    begin
        //initialize
        out_pad_o = 32'd0;
        oen_padeo_o = 32'd0;
        ext_clk_pad_i = 1'd0;
        io_pad_temp = 32'd0;
        #40;
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'hffff_ffff;
        out_pad_o = 32'd64;
        #40;        
        //send data through out_pad_o and enable low
        oen_padeo_o = 32'h0;
        out_pad_o = 32'd64;
        #40;        
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'd15;
        out_pad_o = 32'd28; //io_pad = 12 = in_pad_i
        #40;          
        //send data through out_pad_o and enable low
        oen_padeo_o = 32'h0;
        out_pad_o = 32'd28;
        #40;  
        //external clock        
        ext_clk_pad_i = 1'd1;
        #20;        
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'd7;
        out_pad_o = 32'd28; //io_pad = 4 = in_pad_i
        #40;         
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'd3;
        out_pad_o = 32'd30; //io_pad = 2 = in_pad_i
        #40;                 
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'd3;
        out_pad_o = 32'd29; //io_pad = 1 = in_pad_i
        #40;         
        //send data through out_pad_o and enable high
        oen_padeo_o = 32'd1;
        out_pad_o = 32'd30; //io_pad = 0 = in_pad_i
        #40; 
        ///*        
        //send data through io_pad_temp and enable low
        oen_padeo_o = 32'h0;
        io_pad_temp = 32'd128;
        #40;            
        //send data through io_pad_temp and out_pad_o
        oen_padeo_o = 32'h0000_ffff;
        out_pad_o = 32'h8765_4321;
        io_pad_temp = 32'h1234_5678; //io_pad = 32'h1234_4321 = in_pad_i
        #40;            
        //send data through io_pad_temp and out_pad_o
        oen_padeo_o = 32'hffff_0000;
        out_pad_o = 32'h8765_4321;
        io_pad_temp = 32'h1234_5678; //io_pad = 32'h8765_5678 = in_pad_i
        #40;
        //*/
    end    
              
    initial
    begin
        #1000;
        $finish;
    end
    
endmodule