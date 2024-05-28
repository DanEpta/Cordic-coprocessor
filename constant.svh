//`include "function_case_tb.sv"

// Значения в радианах для арктангенса (arctg(2^i)) для 16 итераций алгоритма 
// умноженное на 32 768 (2^16 / 2)
`define TANAGLE_0   17'd25736; // 1/1
`define TANAGLE_1   17'd15192; // 1/2
`define TANAGLE_2   17'd8028; // 1/4
`define TANAGLE_3   17'd4074; // 1/8
`define TANAGLE_4   17'd2045; // 1/16
`define TANAGLE_5   17'd1024; // 1/32
`define TANAGLE_6   17'd512; // 1/64
`define TANAGLE_7   17'd256; // 1/128
`define TANAGLE_8   17'd128; // 1/256
`define TANAGLE_9   17'd64; // 1/512
`define TANAGLE_10  17'd32; // 1/1024
`define TANAGLE_11  17'd16; // 1/2048
`define TANAGLE_12  17'd8; // 1/4096
`define TANAGLE_13  17'd4; // 1/8192
`define TANAGLE_14  17'd2; // 1/16384
`define TANAGLE_15  17'd1; // 1/32768

// Значения в градусах для арктангенса (arctg(2^i)) для 16 итераций алгоритма 
// умноженное на 32 768 (2^16 / 2)
// 18 бит знак С 17 по 12 целое число, а дальше дробь
`define TANAGLE_grad_0   19'b0101101000000000000; // 1/1 45 градусов
`define TANAGLE_grad_1   19'b0011010100110011001; // 1/2 26,6° градусов
`define TANAGLE_grad_2   19'b0001110000010100011; // 1/4 14,04 градусов
`define TANAGLE_grad_3   19'b0000111111010111000; // 1/8 7,92 градусов
`define TANAGLE_grad_4   19'b0000011111110000101; // 1/16 3,97 градусов
`define TANAGLE_grad_5   19'b0000001111111010111; // 1/32 1,99 градусов
`define TANAGLE_grad_6   19'b0000000111111010111; // 1/64 0,99 градусов
`define TANAGLE_grad_7   19'b0000000011111010111; // 1/128 0,49 градусов
`define TANAGLE_grad_8   19'b0000000001110000101; // 1/256 0,22 градусов
`define TANAGLE_grad_9   19'b0000000000111000010; // 1/512 0,11 градусов
`define TANAGLE_grad_10  19'b0000000000011110101; // 1/1024 0,06 градусов
`define TANAGLE_grad_11  19'b0000000000001111010; // 1/2048 0,03 градусов
`define TANAGLE_grad_12  19'b0000000000000110101; // 1/4096 0,013 градусов
`define TANAGLE_grad_13  19'b0000000000000011100; // 1/8192 0,007 градусов
`define TANAGLE_grad_14  19'b0000000000000001100; // 1/16384 0.003 градусов
`define TANAGLE_grad_15  19'b0000000000000000100; // 1/32768 0.001 градусов