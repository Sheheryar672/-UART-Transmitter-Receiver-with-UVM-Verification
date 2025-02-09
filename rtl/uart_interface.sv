
interface uart_if;
    logic clk, rst;
    logic [7:0] i_tx_data;
    logic [3:0] i_len;
    logic [16:0] i_baud;
    logic i_tx_str, i_rx_str;
    logic i_parity_ty, i_parity_en, i_stop2;
    logic o_tx_done, o_rx_done;
    logic o_tx_er, o_rx_er;
    logic [7:0] o_rx;
endinterface


