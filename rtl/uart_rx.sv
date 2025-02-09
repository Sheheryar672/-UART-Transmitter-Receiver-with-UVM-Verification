
module uart_rx(
    input  logic rst, i_rx_clk, i_rx, i_rx_str,
    input  logic [3:0] i_len,
    input  logic i_parity_ty, i_parity_en,
    input  logic i_stop2,
    output logic [7:0] o_rx,
    output logic o_rx_done, 
    output logic o_rx_er    /// parity and stop bit error
);

logic parity = 0;
logic [7:0] data_temp = 0;
int cnt = 0, bit_cnt = 0;

typedef enum bit [2:0] {idle, start_bit, recv_data, check_parity, check_stop1, check_stop2, done} state_ty;
state_ty state, next_state;

////////////////////// rst dectector
always@(posedge i_rx_clk) begin     
    if(rst)
        state <= idle;
    else 
        state <= next_state; 
end

/////////////////////////////// next_state decoder + output
always@(*) begin        /// --> combinational
    case(state)

        idle: begin
            o_rx = 1'b1;
            o_rx_done = 1'b0;
            o_rx_er = 1'b0;

            if(i_rx_str &&  !i_rx)
                next_state = start_bit;
            else
                next_state = idle;
        end

        start_bit: begin
            if (cnt == 7 && i_rx) begin     /// in case of error
                next_state = idle;
            end else if (cnt == 15) begin
                next_state = recv_data;
            end else begin
                next_state = start_bit;
            end
        end

        recv_data: begin
            if(cnt == 7) begin
                data_temp = {i_rx, data_temp[7:1]};
            end else if (cnt == 15 && bit_cnt == (i_len - 1)) begin
                case(i_len)
                    4'd5: o_rx = data_temp[7:3];
                    4'd6: o_rx = data_temp[7:2];
                    4'd7: o_rx = data_temp[7:1];
                    4'd8: o_rx = data_temp[7:0];
                    default: o_rx = 8'h00;
                endcase

                ///////////////////////// parity logic
                if(i_parity_ty)
                    parity = ^data_temp;
                else 
                    parity = ~^data_temp;
                
                //////////////////////////
                if(i_parity_en)
                    next_state = check_parity;
                else 
                    next_state = check_stop1;
            end else begin
                next_state = recv_data;
            end                
        end

        check_parity: begin
            if(cnt == 7) begin
                if(i_rx == parity)
                    o_rx_er = 1'b0; /// parity error
                else  
                    o_rx_er = 1'b1;
            end else if (cnt == 15) begin
                next_state = check_stop1;
            end else begin
                next_state = check_parity;
            end
        end

        check_stop1: begin
            if(cnt == 7) begin
                if(i_rx != 1'b1)
                    o_rx_er = 1'b1;
                else 
                    o_rx_er = 1'b0;
            end else if (cnt == 15) begin
                if(i_stop2)
                    next_state = check_stop2;
                else 
                    next_state = done; 
            end else begin
                next_state = check_stop1;
            end
        end

        check_stop2: begin
            if(cnt == 7) begin
                if(i_rx != 1'b1)
                    o_rx_er = 1'b1;
                else 
                    o_rx_er = 1'b0;     
            end else if (cnt == 15) begin
                next_state = done;
            end else begin
                next_state = check_stop2;
            end
        end
        
        done: begin
            o_rx_done = 1'b1;
            next_state = idle;
            o_rx_er = 1'b0;
        end
    endcase
end

//////////////////////////////////// counter
always@(posedge i_rx_clk) begin
    case(state)
        idle: begin
            cnt <= 0;
            bit_cnt <= 0;
        end

        start_bit: begin
            if(cnt < 15) 
                cnt <= cnt + 1;
            else 
                cnt <= 0;
        end

        recv_data: begin
            if(cnt < 15) begin
                cnt <= cnt + 1;
            end else begin 
                cnt <= 0;
                bit_cnt <= bit_cnt + 1;
            end
        end

        check_parity:  begin
            if(cnt < 15) 
                cnt <= cnt + 1;
            else 
                cnt <= 0;
        end

        check_stop1:  begin
            if(cnt < 15) 
                cnt <= cnt + 1;
            else 
                cnt <= 0;
        end

        check_stop2:  begin
            if(cnt < 15) 
                cnt <= cnt + 1;
            else 
                cnt <= 0;
        end

        done: begin
            cnt <= 0;
            bit_cnt <= 0;
        end
    endcase
end
endmodule