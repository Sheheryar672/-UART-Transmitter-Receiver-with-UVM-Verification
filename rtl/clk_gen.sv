
 module clk_gen(
    input  logic clk, rst,
    input  logic [16:0] i_baud,
    output logic o_tx_clk, o_rx_clk
);


///////////////////////////
int tx_max = 0, rx_max = 0;  
int tx_cnt = 0, rx_cnt = 0;

logic rx_clk, tx_clk;

//////////////////////// update value of tx_max and rx_max
always @(posedge clk) begin
    if(rst) begin
        tx_max <= 0;
        rx_max <= 0;
    end else begin
        case (i_baud)
            4800: begin 
                tx_max <= 14'd10416; /// --> 50 MHz / 4800
                rx_max <= 11'd651;  /// 10416/16 --> sampling from the middle
            end
            9600: begin  
                tx_max <= 14'd5208;
                rx_max <= 11'd325;
            end
            14400: begin 
                tx_max <= 14'd3472;
                rx_max <= 11'd217;
            end
            19200: begin
                tx_max <= 14'd2604;
                rx_max <= 11'd163;
            end
            38400: begin
                tx_max <= 14'd1302;
                rx_max <= 11'd81;
            end
            57600: begin 
                tx_max <= 14'd868;
                rx_max <= 11'd54;
            end

            default: begin 
                tx_max <= 14'd5208; /// baud rate 9600
                rx_max <= 11'd325;
            end 
        endcase
    end
end

//////////////////////// tx clk generation
always @(posedge clk) begin
    if (rst) begin
        tx_cnt <= 0;
        tx_max <= 0;
        tx_clk <= 0;
    end else begin
        if (tx_cnt <= tx_max / 2) begin
            tx_cnt <= tx_cnt + 1;
        end else begin
            tx_cnt <= 0;
            tx_clk <= ~tx_clk;
        end
    end
end

///////////////////////// rx pulse generation
always@(posedge clk) begin
    if (rst) begin
        rx_cnt <= 0;
        rx_max <= 0;
        rx_clk <= 0;
    end else begin
        if(rx_cnt < rx_max / 2) begin 
            rx_cnt <= rx_cnt + 1;
        end else begin
            rx_cnt <= 0;
            rx_clk <= ~rx_clk;
        end
    end
end

/////////////////////////////////////
assign o_rx_clk = rx_clk;
assign o_tx_clk = tx_clk;

endmodule

