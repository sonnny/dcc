
#pragma once
#include "string.h"
#include "pico/float.h"
#include "pico/stdlib.h"
#include "pico/multicore.h"
#include "pico/printf.h"
#include "hardware/pwm.h"
#include "hardware/adc.h"
#include "hardware/flash.h"
#include "hardware/i2c.h"

#define SIZE_BYTE_ARRAY 5
#define MESSAGE_3_BYTES 0b11111111110000000000000000000000000001
#define MESSAGE_MASK_3_BYTES 0b11111111111000000001000000001000000001
#define MESSAGE_4_BYTES 0b11111111110000000000000000000000000000000000001
#define MESSAGE_MASK_4_BYTES 0b11111111111000000001000000001000000001000000001
#define MESSAGE_5_BYTES 0b11111111110000000000000000000000000000000000000000000001
#define MESSAGE_MASK_5_BYTES 0b11111111111000000001000000001000000001000000001000000001
const uint32_t clr_bit_arr[6] = {
        0b11111111111111111111111111100000, // Clear Bits 0-4 (F0-F4)
        0b11111111111111111111111000011111, // Clear Bits 5-8 (F5-F8)
        0b11111111111111111110000111111111, // Clear Bits 9-12 (F9-F12)
        0b11111111111000000001111111111111, // Clear Bits 13-20 (F13-F20)
        0b11100000000111111111111111111111, // Clear Bits 21-28 (F21-F28)
        0b00011111111111111111111111111111, // Clear Bits 29-31 (F29-F31)
};

// Constant Value of 125 x 10^6
#define _125M 125000000
#define MY_ADDRESS            13
#define DCC_INPUT_PIN         9u

#define ProgramInstrVerifyBit  0b10
#define ProgramInstrVerifyByte 0b01
#define ProgramInstrWriteByte  0b11
#define ProgramCmd(instr, adrmsbits) ((instr<<2) | (adrmsbits))

bool error_detection(int8_t number_of_bytes, const uint8_t * byte_array);
bool is_long_address(uint8_t number_of_bytes, const uint8_t byte_array[]);
bool address_evaluation(uint8_t number_of_bytes,const uint8_t byte_array[]);
void instruction_evaluation(uint8_t number_of_bytes,const uint8_t byte_array[]);
int8_t verify_dcc_message();
void bits_to_byte_array(int8_t number_of_bytes,uint8_t byte_array[]);
void evaluate_message();
void track_signal_rise(unsigned int gpio, long unsigned int events);
void track_signal_fall(unsigned int gpio, long unsigned int events);
