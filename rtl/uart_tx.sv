

 module uart_tx(
    input  logic rst, i_tx_clk, i_tx_str, 
    input  logic [7:0] i_tx_data,
    input  logic [3:0] i_len,    
    input  logic i_parity_ty,     /// 1 --> odd, 0 --> even
    input  logic i_parity_en,
    input  logic i_stop2,   /// 0 --> 1 stop bit, 2 --> 2 stop bits
    output logic o_tx, o_tx_done, o_tx_er
 );

 logic [7:0] tx_reg;
 logic parity_bit = 0;
 integer cnt = 0;

 typedef enum logic [2:0] {idle, start_bit, send_data, send_parity, stop1_bit, stop2_bit, done} state_ty;
 state_ty state = idle, next_state = idle;
 
 //////////////////////////////// parity generator
 always@(posedge i_tx_clk) begin
    if(i_parity_ty == 1'b1) begin   /// odd parity
        case(i_len)
            4'd5 : parity_bit <= ^(i_tx_data[4:0]); 
            4'd6 : parity_bit <= ^(i_tx_data[5:0]);
            4'd7 : parity_bit <= ^(i_tx_data[6:0]);
            4'd8 : parity_bit <= ^(i_tx_data[7:0]);
            default : parity_bit <= 1'b0;
        endcase
    end else begin  /// even parity
        case(i_len)
            4'd5 : parity_bit <= ~^(i_tx_data[4:0]); 
            4'd6 : parity_bit <= ~^(i_tx_data[5:0]);
            4'd7 : parity_bit <= ~^(i_tx_data[6:0]);
            4'd8 : parity_bit <= ~^(i_tx_data[7:0]);
            default : parity_bit <= 1'b0; 
        endcase
    end
 end

 //////////////////////// reset sensor
 always@(posedge i_tx_clk) begin
    if (rst)
        state <= idle;
    else
        state <= next_state;
 end


 ///////////////////////// next state decoder + output decoder
 always@(*) begin
    case(state)
        
        idle: begin
            o_tx_done = 1'b0;
            o_tx = 1'b1;
            o_tx_er =  1'b0;
            tx_reg = {(8){1'b0}};
            
            if(i_tx_str) 
                next_state = start_bit;
            else
                next_state = idle;
        end

        start_bit: begin
            tx_reg = i_tx_data;
            o_tx = 1'b0;    /// start_bit
            next_state = send_data;
        end

        send_data: begin
            if (cnt < i_len - 1) begin
                next_state = send_data;
                o_tx = tx_reg[cnt];
            end else if (i_parity_en) begin
                o_tx = tx_reg[cnt];
                next_state = send_parity;
            end else begin
                o_tx = tx_reg[cnt];
                next_state = stop1_bit;
            end
        end

        send_parity: begin
            o_tx = parity_bit;
            next_state = stop1_bit;
        end

        stop1_bit: begin
            o_tx = 1'b1;

            if(i_stop2) 
                next_state = stop2_bit;
            else 
                next_state = done;
        end

        stop2_bit: begin
            o_tx = 1'b1;
            next_state = done;
        end

        done: begin
            o_tx_done = 1'b1;
            next_state = idle;
        end
        
        default: next_state = idle;
    endcase
 end

 /////////////////////////////////////////
 always@(posedge i_tx_clk) begin
    case(state)
        idle: cnt <= 0;
        start_bit: cnt <= 0;
        send_data: cnt <= cnt + 1;
        send_parity: cnt <= 0;
        stop1_bit: cnt <= 0;
        stop2_bit: cnt <= 0;
        done: cnt <= 0;
        default: cnt <= 0;
    endcase
 end

 endmodule