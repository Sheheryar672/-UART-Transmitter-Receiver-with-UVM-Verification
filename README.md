# UART Transmitter & Receiver (UVM Verified)

## Overview  
Universal Asynchronous Receiver-Transmitter (**UART**) is a serial communication protocol used for asynchronous data exchange between devices. It operates without a shared clock, using start and stop bits to frame data transmission. This project implements a **UART Transmitter & Receiver**, which is verified using **UVM**.
## Features  
- **Supports multiple baud rates:** 4800, 9600, 14400, 19200, 38400, 57600  
- **Configurable data bits:** 5, 6, 7, and 8  
- **Supports parity:** Odd & Even  
- **Frame error detection**  
- **Configurable stop bits:** 1 or 2

# Makefile Instructions

This project contains a Makefile designed to compile and simulate and display the waveform of Uart Rx and Tx.

## Prerequisites

Ensure that QuestaSim with uvm-1.2 is installed and accessible in your system's PATH.

## Usage

Use the following commands for Makefile:

- **Compile and Run UVM Testbench**
  ```bash
  make run_tb

- **Display Waveform**
  ```bash
  make wave

- **CLEAN_UP**
  ```bash
  make clean

