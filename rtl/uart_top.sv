

 module uart_top(
    input  logic clk, rst,
    input  logic [7:0] i_tx_data,
    input  logic [3:0] i_len,
    input  logic [16:0] i_baud,  
    input  logic i_tx_str, i_rx_str, 
    input  logic i_parity_ty, i_parity_en, i_stop2,
    output logic o_tx_done, o_rx_done,
    output logic o_tx_er, o_rx_er,
    output logic [7:0] o_rx 
 );

 logic tx_clk, rx_clk;
 logic tx_rx;
 
 clk_gen c_gen (clk, rst, i_baud, tx_clk, rx_clk);

 uart_tx u_tx (rst, tx_clk, i_tx_str, i_tx_data, i_len, i_parity_ty, i_parity_en, i_stop2, tx_rx, o_tx_done, o_tx_er);

 uart_rx u_rx (rst, rx_clk, tx_rx, i_rx_str, i_len, i_parity_ty, i_parity_en, i_stop2, o_rx, o_rx_done, o_rx_er);

 endmodule