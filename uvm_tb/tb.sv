`include "uvm_macros.svh"
import uvm_pkg::*;

///////////////////////////////////////////////////////
class uart_config extends uvm_object;   /// for configuring agent type
    `uvm_object_utils(uart_config)

    function new (string inst = "uart_config");
        super.new(inst);
    endfunction

    uvm_active_passive_enum is_active = UVM_ACTIVE;

endclass

///////////////////////////////// defined all test cases
typedef enum bit [3:0] {rand_baud_stop1, rand_len_stop1, len5wp, len6wp, len7wp, len8wp, len5wop, len6wop, len7wop, len8wop, rand_baud_stop2, rand_len_stop2} oper_mode;

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    rand oper_mode op;
         logic i_tx_str, i_rx_str;
         logic rst;
    rand logic [7:0] i_tx_data;
    rand logic [16:0] i_baud;
    rand logic [3:0]  i_len;
    rand logic i_parity_ty, i_parity_en;
         logic i_stop2;
         logic o_tx_done, o_rx_done;
         logic o_tx_er, o_rx_er;
         logic [7:0] o_rx;
         

    constraint baud_c { i_baud inside {4800, 9600, 14400, 19200, 38400, 57600}; }
    constraint len_c { i_len inside {5, 6 , 7, 8}; }
    
    function new (input string inst = "transaction");
        super.new(inst);
    endfunction

endclass : transaction

/////////////////////////////////////////////////// sequences

/// raud_baud_stop1
////////////////////////////// random baud - fixed lenght = 8 - parity enable - parity type random - single stop bit
class rand_baud_st1 extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_st1)

    transaction tr;

    function new (input string inst = "rand_baud_st1");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = rand_baud_stop1;
            tr.i_len = 8;
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);
        end
        
    endtask

endclass

/// rand_baud_stop2
//////////////////// rand baud - fixed lenght = 8 - parity enabled - parity type random - 2 stop bits
class rand_baud_st2 extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_st2)

    transaction tr;

    function new (input string inst = "rand_baud_st2");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = rand_baud_stop2;
            tr.i_len = 8;
            tr.i_parity_en = 1;
            tr.i_stop2 = 1;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);
        end
        
    endtask

endclass

/// len5wp
/////////////////// fixed length = 5 - random baud - parity enabled - 1 stop bit
class rand_baud_len5wp extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len5wp)

    transaction tr;

    function new (input string inst  = "rand_baud_len5wp");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len5wp;
            tr.i_len = 5;
            tr.i_tx_data = {3'b000, tr.i_tx_data[7:3]}; 
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len6wp
/////////////////// fixed length = 6 - random baud - parity enabled - 1 stop bit
class rand_baud_len6wp extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len6wp)

    transaction tr;

    function new (input string inst  = "rand_baud_len6wp");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len6wp;
            tr.i_len = 6;
            tr.i_tx_data = {2'b00, tr.i_tx_data[7:2]}; 
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len7wp
/////////////////// fixed length = 7 - random baud - parity enabled - 1 stop bit
class rand_baud_len7wp extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len7wp)

    transaction tr;

    function new (input string inst  = "rand_baud_len7wp");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len7wp;
            tr.i_len = 7;
            tr.i_tx_data = {1'b0, tr.i_tx_data[7:1]}; 
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len8wp
/////////////////// fixed length = 8 - random baud - parity enabled - 1 stop bit
class rand_baud_len8wp extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len8wp)

    transaction tr;

    function new (input string inst  = "rand_baud_len8wp");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len8wp;
            tr.i_len = 8;
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len5wop
/////////////////// fixed length = 5 - random baud - parity disabled - 1 stop bit
class rand_baud_len5wop extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len5wop)

    transaction tr;

    function new (input string inst  = "rand_baud_len5wop");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len5wop;
            tr.i_len = 5;
            tr.i_tx_data = {3'b000, tr.i_tx_data[7:3]}; 
            tr.i_parity_en = 0;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len6wop
/////////////////// fixed length = 6 - random baud - parity disabled - 1 stop bit
class rand_baud_len6wop extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len6wop)

    transaction tr;

    function new (input string inst  = "rand_baud_len6wop");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len6wop;
            tr.i_len = 6;
            tr.i_tx_data = {2'b00, tr.i_tx_data[7:2]}; 
            tr.i_parity_en = 0;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len7wop
/////////////////// fixed length = 7 - random baud - parity disabled - 1 stop bit
class rand_baud_len7wop extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len7wop)

    transaction tr;

    function new (input string inst  = "rand_baud_len7wop");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len7wop;
            tr.i_len = 7;
            tr.i_tx_data = {1'b0, tr.i_tx_data[7:1]}; 
            tr.i_parity_en = 0;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// len8wop
/////////////////// fixed length = 8 - random baud - parity disabled - 1 stop bit
class rand_baud_len8wop extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_baud_len8wop)

    transaction tr;

    function new (input string inst  = "rand_baud_len8wop");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = len8wop;
            tr.i_len = 8;
            tr.i_parity_en = 0;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;
            finish_item(tr);          
        end
        
    endtask
endclass

/// raud_len_stop1
////////////////////////////// random baud - random length - parity enable - parity type random - single stop bit
class rand_len_st1 extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_len_st1)

    transaction tr;

    function new (input string inst = "rand_len_st1");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = rand_len_stop1;
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;

              if(tr.i_len == 5) 
                  tr.i_tx_data = {3'b000, tr.i_tx_data[7:3]}; 
              else if(tr.i_len == 6)
                  tr.i_tx_data = {2'b00, tr.i_tx_data[7:2]}; 
              else if(tr.i_len == 7)
                  tr.i_tx_data = {1'b0, tr.i_tx_data[7:1]}; 
            
            finish_item(tr);
        end
        
    endtask

endclass

/// raud_len_stop2
////////////////////////////// random baud - random lenght - parity enable - parity type random - double stop bit
class rand_len_st2 extends uvm_sequence #(transaction);
    `uvm_object_utils(rand_len_st2)

    transaction tr;

    function new (input string inst = "rand_len_st2");
        super.new(inst);
    endfunction

    virtual task body();
        repeat(5) begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.op = rand_len_stop2;
            tr.i_parity_en = 1;
            tr.i_stop2 = 0;
            tr.i_rx_str = 1;
            tr.i_tx_str = 1;
            tr.rst = 0;

            if(tr.i_len == 5) 
                tr.i_tx_data = {3'b000, tr.i_tx_data[7:3]}; 
            else if(tr.i_len == 6)
                tr.i_tx_data = {2'b00, tr.i_tx_data[7:2]}; 
            else if(tr.i_len == 7)
                tr.i_tx_data = {1'b0, tr.i_tx_data[7:1]};

            finish_item(tr);
        end
        
    endtask

endclass

///////////////////////////////////////////////////////////////////////////////
class seq_library extends uvm_sequence_library #(transaction);
    `uvm_object_utils(seq_library)
    `uvm_sequence_library_utils(seq_library)

    function new (string inst = "seq_library");
        super.new(inst);

        add_typewide_sequence(rand_baud_st1::get_type());
        add_typewide_sequence(rand_baud_st2::get_type());
        add_typewide_sequence(rand_baud_len5wp::get_type());
        add_typewide_sequence(rand_baud_len6wp::get_type());
        add_typewide_sequence(rand_baud_len7wp::get_type());
        add_typewide_sequence(rand_baud_len8wp::get_type());
        add_typewide_sequence(rand_baud_len5wop::get_type());
        add_typewide_sequence(rand_baud_len6wop::get_type()); 
        add_typewide_sequence(rand_baud_len7wop::get_type());
        add_typewide_sequence(rand_baud_len8wop::get_type());
        add_typewide_sequence(rand_len_st1::get_type());
        add_typewide_sequence(rand_len_st2::get_type());
    
    endfunction

endclass : seq_library

///////////////////////////////////////////////////////////////////////////////
class drv extends uvm_driver #(transaction);
    `uvm_component_utils(drv)

    virtual uart_if uif;
    transaction tr;

    function new (input string inst = "drv", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = transaction::type_id::create("tr");

        if(!uvm_config_db #(virtual uart_if) :: get(this,"","uif",uif))
            `uvm_error("DRV", "Unable to access the Interface!!!");
    endfunction

    ///////////////////// reset task
    task reset_dut();
        repeat(5) begin
            
            uif.rst         <= 1'b1;   /// active high reset
            uif.i_tx_str    <= 1'b0;
            uif.i_rx_str    <= 1'b0;
            uif.i_tx_data   <= 8'h00;
            uif.i_baud      <= 16'h0000;
            uif.i_len       <= 4'h0;
            uif.i_parity_en <= 1'b0;
            uif.i_parity_ty <= 1'b0;
            uif.i_stop2     <= 1'b0;
            
            `uvm_info("DRV", "System Reseted", UVM_MEDIUM);
            @(posedge uif.clk);
        end
    endtask

    task drive();
        reset_dut();
        
        forever begin
            seq_item_port.get_next_item(tr);
                
                uif.rst         <= 1'b0;
                uif.i_tx_str    <= tr.i_tx_str;
                uif.i_rx_str    <= tr.i_rx_str;
                uif.i_tx_data   <= tr.i_tx_data;
                uif.i_baud      <= tr.i_baud;
                uif.i_len       <= tr.i_len;
                uif.i_parity_en <= tr.i_parity_en;
                uif.i_parity_ty <= tr.i_parity_ty;
                uif.i_stop2     <= tr.i_stop2;

            `uvm_info("DRV", $sformatf("Baud: %0d, Len: %0d, Par_ty: %0d, Par_en: %0d, Stop: %0d, Tx_data: %0d", tr.i_baud, tr.i_len, tr.i_parity_ty, tr.i_parity_en, tr.i_stop2, tr.i_tx_data), UVM_NONE);

                @(posedge uif.clk);
                @(posedge uif.o_tx_done);
                @(posedge uif.o_rx_done);

            seq_item_port.item_done();
        end
    endtask

    virtual task run_phase(uvm_phase phase);
        drive();
    endtask

endclass

///////////////////////////////////////////////////////////////////////
class mon extends uvm_monitor;
    `uvm_component_utils(mon)

    virtual uart_if uif;
    uvm_analysis_port #(transaction) send;
    transaction tr;

    function new (input string inst = "mon", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = transaction::type_id::create("tr");
        send = new("send", this);

        if(!uvm_config_db #(virtual uart_if) :: get (this, "", "uif", uif))
            `uvm_error("MON", "Unable to access Interface!!!");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge uif.clk)

            if(uif.rst) begin
                tr.rst = 1'b1;
                `uvm_info("MON", "System Reset Detected", UVM_NONE);
                send.write(tr);
            end else begin
                @(posedge uif.o_tx_done);
                
                tr.rst         = 1'b0;
                tr.i_tx_str    = uif.i_tx_str;
                tr.i_rx_str    = uif.i_rx_str;
                tr.i_tx_data   = uif.i_tx_data;
                tr.i_baud      = uif.i_baud;
                tr.i_len       = uif.i_len;
                tr.i_parity_en = uif.i_parity_en;
                tr.i_parity_ty = uif.i_parity_ty;
                tr.i_stop2     = uif.i_stop2;
                
                @(posedge uif.o_rx_done);
                tr.o_rx = uif.o_rx;

                `uvm_info("MON", $sformatf("Baud: %0d, Len: %0d, Par_ty: %0d, Par_en: %0d, Stop: %0d, Tx_data: %0d, RX_data: %0d", tr.i_baud, tr.i_len, tr.i_parity_ty, tr.i_parity_en, tr.i_stop2, tr.i_tx_data, tr.o_rx), UVM_NONE);
                send.write(tr);
            end 
        end
    endtask

endclass

//////////////////////////////////////////////////////////////////////////
class sco extends uvm_scoreboard;
    `uvm_component_utils(sco)

    int test_pass = 0, test_fail = 0;

    uvm_analysis_imp #(transaction, sco) recv;

    function new (input string inst = "sco", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        recv = new("recv", this);
    endfunction

    virtual function void write(transaction tr);
        `uvm_info("SCO", $sformatf("Baud: %0d, Len: %0d, Par_ty: %0d, Par_en: %0d, Stop: %0d, Tx_data: %0d, RX_data: %0d", tr.i_baud, tr.i_len, tr.i_parity_ty, tr.i_parity_en, tr.i_stop2, tr.i_tx_data, tr.o_rx), UVM_NONE)
        
        if(tr.rst == 1) begin
            `uvm_info("SCO", "System Reset", UVM_NONE);
        end else if (tr.i_tx_data == tr.o_rx) begin
            `uvm_info("SCO", "Test Passed", UVM_NONE);
            test_pass++;
        end else begin 
            `uvm_info("SCO", "Test Failed!!!", UVM_NONE);
            test_fail++;
        end

        $display("----------------------------------------------------------------------------------------------");
    endfunction

endclass

/////////////////////////////////////////////////////////////////////////////////////////
class agent extends uvm_agent;
    `uvm_component_utils(agent)

    uart_config cfg;
    drv d;
    mon m;
    uvm_sequencer #(transaction) seqr;

    function new (input string inst = "agent", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg = uart_config::type_id::create("cfg");
        m = mon::type_id::create("m", this);
        if(cfg.is_active == UVM_ACTIVE) begin
            seqr = uvm_sequencer #(transaction)::type_id::create("seqr", this);
            d = drv::type_id::create("d", this);
        end 
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        if(cfg.is_active == UVM_ACTIVE)
            d.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass

//////////////////////////////////////////////////////////////////////////////////////////
class env extends uvm_env;
    `uvm_component_utils(env)

    sco s;
    agent a;

    function new (input string inst = "env", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        s = sco::type_id::create("s", this);
        a = agent::type_id::create("a", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a.m.send.connect(s.recv);
    endfunction

endclass

///////////////////////////////////////////////////////////////////////////////////////
class test extends uvm_test;
    `uvm_component_utils(test)

    env e;
    seq_library seqlib;

    function new (input string inst = "test", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        e = env::type_id::create("e", this);
        
        ///////////////////////////
        seqlib = seq_library::type_id::create("seqlib");
        seqlib.selection_mode = UVM_SEQ_LIB_RANDC;
        seqlib.min_random_count = 12;
        seqlib.max_random_count = 30;
        seqlib.init_sequence_library();
        seqlib.print();
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            
            assert(seqlib.randomize());
            seqlib.start(e.a.seqr);
            
            $display("Total Test Passed:%0d", e.s.test_pass);
            $display("Total Test Failed:%0d", e.s.test_fail);
            phase.phase_done.set_drain_time(this, 100ns);
        
        phase.drop_objection(this);
    endtask

endclass

module tb();

    uart_if uif();
    
    uart_top dut (
        uif.clk, uif.rst,
        uif.i_tx_data,
        uif.i_len,
        uif.i_baud,  
        uif.i_tx_str, uif.i_rx_str, 
        uif.i_parity_ty, uif.i_parity_en, uif.i_stop2,
        uif.o_tx_done, uif.o_rx_done,
        uif.o_tx_er, uif.o_rx_er,
        uif.o_rx 
     );

     initial begin
        uif.clk <= 0;
     end

     always #10 uif.clk = ~uif.clk;

     initial begin
        uvm_config_db #(virtual uart_if) :: set(null, "*", "uif", uif);
        run_test("test");
    end

     
endmodule