// decoder_source.dart

const String decoder_source = r"""

/////////// core0.h
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

/////////////// core0.c

//////////////////////////
//   RP2040-Decoder     //
// Gabriel Koppenstein  //
//      core0.c         //
//////////////////////////

#include "core0.h"
#include "ws2812.h"
#include "servo.h"
#include "ssd1306.h"

uint64_t input_bit_buffer = 0;
uint16_t level_table[32] = {0};
absolute_time_t falling_edge_time, rising_edge_time;

char disp_string[256] = " ";

bool get_direction_of_speed_step(uint8_t speed_step){
    // Shift by 7 Bytes to move bit7 into bit0 position and return
    return speed_step >> 7;}


// Bitwise XOR for all Bytes -> when result is: "0000 0000" error check is passed.
bool error_detection(const int8_t number_of_bytes, const uint8_t *const byte_array) {
    uint8_t xor_byte = 0;
    for (int i = 0; i < number_of_bytes; i++) {
        xor_byte = xor_byte ^ byte_array[i];}
    return (0 == xor_byte);}


// Check for long address. Function returns true for long address.
bool is_long_address(uint8_t const number_of_bytes, const uint8_t *const byte_array) {
    if ((byte_array[number_of_bytes - 1] >> 6) == 0b00000011) {
        return true;}
    return false;}


// First checks for idle message and then evaluates address included in byte_array[] which contains the received DCC message
bool address_evaluation(const uint8_t number_of_bytes, const uint8_t *const byte_array) {
    // Check for idle message
    if (byte_array[number_of_bytes - 1] == 255) {
        return false;}
    uint16_t read_address;
    read_address = byte_array[number_of_bytes - 1];
    return MY_ADDRESS == read_address; }


// Evaluate the type of instruction
void instruction_evaluation(const uint8_t number_of_bytes, const uint8_t *const byte_array) {
    // start of transmission -> ... -> command_byte_n -> ... -> command_byte_0 -> ... -> end of transmission
    // The position of command bytes depend on whether the address is long or not
    uint8_t command_byte_start_index;
   
    
    if (is_long_address(number_of_bytes, byte_array)) {
        command_byte_start_index = number_of_bytes - 3;
    }
    else {
        command_byte_start_index = number_of_bytes - 2;
    }
    //const uint8_t command_byte_n = byte_array[command_byte_start_index];
    const uint8_t command_byte_n = byte_array[command_byte_start_index];

    /* Speed control */
    if (command_byte_n == 0b00111111) {
    
        uint8_t speed_data = byte_array[command_byte_start_index - 1];
        
        // always use switch here, if I just use the if condition then
        // ssd1306 doesn't get updated
        
        switch(speed_data){
			case 0x02: gpio_put(25,1); break;
			case 0x82: gpio_put(25,0); break;
			case 0x03: ws2812_display(0x00100010); break;
			case 0x83: ws2812_display(0x00001000); break;
			case 0x04:
			  sprintf(disp_string,"4speed: %x ||2TOGGLE TEST ||1SSD1306", speed_data);    
              ssd1306_display(disp_string);
              break;
			case 0x84:
			  sprintf(disp_string,"4speed: %x ||2TOGGLE TEST ||1SSD1306", speed_data);    
              ssd1306_display(disp_string);
              break;
            case 0x05: servo_low(); busy_wait_ms(100); break;
            case 0x85: servo_high(); busy_wait_ms(100); break;             
       }}}

// Checks for valid message - looking for correct preamble using bitmasks
// returns number of bytes if valid bit-pattern is found. Otherwise -1 is returned.
int8_t verify_dcc_message() {
    int8_t number_of_bytes = -1;
    const uint64_t masked_message_3_bytes = input_bit_buffer & MESSAGE_MASK_3_BYTES;
    if (masked_message_3_bytes == MESSAGE_3_BYTES) number_of_bytes = 3;
    const uint64_t masked_message_4_bytes = input_bit_buffer & MESSAGE_MASK_4_BYTES;
    if (masked_message_4_bytes == MESSAGE_4_BYTES) number_of_bytes = 4;
    const uint64_t masked_message_5_bytes = input_bit_buffer & MESSAGE_MASK_5_BYTES;
    if (masked_message_5_bytes == MESSAGE_5_BYTES) number_of_bytes = 5;
    return number_of_bytes;}

//start of transmission -> byte_n(address byte) -> ... -> byte_0(error detection byte) -> end of transmission
void bits_to_byte_array(const int8_t number_of_bytes, uint8_t byte_array[]) {
    for (uint8_t i = 0; i < number_of_bytes; i++) {
        byte_array[i] = input_bit_buffer >> (i * 9 + 1);
    }}

// Sequence of bits gets evaluated
void evaluate_message() {
    // Check if input buffer contains a valid dcc message
    const int8_t number_of_bytes = verify_dcc_message();
    // number_of_bytes contains the amount of bytes when the message is valid, otherwise -1
    if (number_of_bytes != -1) {
        // Split data into 8Bit array
        uint8_t byte_array[SIZE_BYTE_ARRAY] = {0};
        bits_to_byte_array(number_of_bytes, byte_array);
        // Check for errors
        if (error_detection(number_of_bytes, byte_array)) {
            // Check for matching address
            if (address_evaluation(number_of_bytes, byte_array)) {
                instruction_evaluation(number_of_bytes, byte_array);}}}}


// DCC-Signal (GPIO 21) rising edge interrupt
void track_signal_rise(const unsigned int gpio, const long unsigned int events) {
    // Save current timer value
    rising_edge_time = get_absolute_time();
    // Disable rising edge interrupt and enable falling edge interrupt
    gpio_set_irq_enabled_with_callback(DCC_INPUT_PIN, GPIO_IRQ_EDGE_RISE, false, &track_signal_rise);
    gpio_set_irq_enabled_with_callback(DCC_INPUT_PIN, GPIO_IRQ_EDGE_FALL, true, &track_signal_fall);}


// DCC-Signal (GPIO 21) falling edge interrupt
void track_signal_fall( const unsigned int gpio, const long unsigned int events) {
    // Save current timer value
    falling_edge_time = get_absolute_time();
    // Time difference is equal to the time the signal was in a logical high state
    const int64_t time_logical_high = absolute_time_diff_us(rising_edge_time, falling_edge_time);
    // When logical high was longer than 87us write 0 bit into buffer otherwise 1
    bool bit;
    if (time_logical_high > 87) bit = 0;
    else bit = 1;
    input_bit_buffer <<= 1;
    input_bit_buffer |= bit;
    // evaluate sequence of bits saved in buffer
    evaluate_message();
    // Disable falling edge interrupt and enable rising edge interrupt
    gpio_set_irq_enabled_with_callback(DCC_INPUT_PIN, GPIO_IRQ_EDGE_FALL, false, &track_signal_fall);
    gpio_set_irq_enabled_with_callback(DCC_INPUT_PIN, GPIO_IRQ_EDGE_RISE, true, &track_signal_rise);}

int main() {

  stdio_init_all();
  gpio_init(25); gpio_set_dir(25, GPIO_OUT);
  ssd1306_init();
  ssd1306_blank(0x00);
  ws2812_init();
  servo_init();
  servo_center();

  gpio_init(DCC_INPUT_PIN);
  gpio_set_dir(DCC_INPUT_PIN, GPIO_IN);
  gpio_pull_up(DCC_INPUT_PIN);
  gpio_set_irq_enabled_with_callback(DCC_INPUT_PIN, GPIO_IRQ_EDGE_RISE, true, &track_signal_rise);
  busy_wait_ms(200);

  while (true); }
  
/////////// CMakeLists.txt
cmake_minimum_required(VERSION 3.12)

# Pull in SDK (must be before project)
include(pico_sdk_import.cmake)

project(RP2040-Decoder C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

set(PICO_DECODER_PATH _DOLLAR_SIGN_{PROJECT_SOURCE_DIR})

# Stop the compiler from inling method calls making it easier to debug
set(PICO_DEOPTIMIZED_DEBUG 1)

# Initialize the SDK
pico_sdk_init()

add_executable(
        RP2040-Decoder
        core0.c
        core0.h
        ws2812.c
        ws2812.h
        ws2812.pio
        servo.h
        servo.c
        ssd1306.h
        ssd1306.c)
        
# Multiplier to lengthen XOSC startup delay to accommodate slow-starting oscillator
target_compile_definitions(
        RP2040-Decoder PUBLIC
        PICO_XOSC_STARTUP_DELAY_MULTIPLIER=64
)

# Add pico_multicore which is required for multicore functionality
target_link_libraries(
        RP2040-Decoder
        pico_stdlib
        hardware_pwm
        hardware_adc
        hardware_flash
        hardware_i2c
        hardware_pio
        pico_multicore
        )

pico_generate_pio_header(RP2040-Decoder _DOLLAR_SIGN_{CMAKE_CURRENT_LIST_DIR}/ws2812.pio)        

# disable usb stack
pico_enable_stdio_usb(RP2040-Decoder 0)

# disable uart output (to enable put a 1 instead of the 0)
pico_enable_stdio_uart(RP2040-Decoder 0)

# create map/bin/hex file etc.
pico_add_extra_outputs(RP2040-Decoder)

//////////////// pico_sdk_import.cmake
# This is a copy of <PICO_SDK_PATH>/external/pico_sdk_import.cmake

# This can be dropped into an external project to help locate this SDK
# It should be include()ed prior to project()
      
if (DEFINED ENV{PICO_SDK_PATH} AND (NOT PICO_SDK_PATH))
    set(PICO_SDK_PATH _DOLLAR_SIGN_ENV{PICO_SDK_PATH})
    message("Using PICO_SDK_PATH from environment ('_DOLLAR_SIGN_{PICO_SDK_PATH}')")
endif ()

if (DEFINED ENV{PICO_SDK_FETCH_FROM_GIT} AND (NOT PICO_SDK_FETCH_FROM_GIT))
    set(PICO_SDK_FETCH_FROM_GIT _DOLLAR_SIGN_ENV{PICO_SDK_FETCH_FROM_GIT})
    message("Using PICO_SDK_FETCH_FROM_GIT from environment ('_DOLLAR_SIGN_{PICO_SDK_FETCH_FROM_GIT}')")
endif ()

if (DEFINED ENV{PICO_SDK_FETCH_FROM_GIT_PATH} AND (NOT PICO_SDK_FETCH_FROM_GIT_PATH))
    set(PICO_SDK_FETCH_FROM_GIT_PATH _DOLLAR_SIGN_ENV{PICO_SDK_FETCH_FROM_GIT_PATH})
    message("Using PICO_SDK_FETCH_FROM_GIT_PATH from environment ('_DOLLAR_SIGN_{PICO_SDK_FETCH_FROM_GIT_PATH}')")
endif ()

set(PICO_SDK_PATH "_DOLLAR_SIGN_{PICO_SDK_PATH}" CACHE PATH "Path to the Raspberry Pi Pico SDK")
set(PICO_SDK_FETCH_FROM_GIT "_DOLLAR_SIGN_{PICO_SDK_FETCH_FROM_GIT}" CACHE BOOL "Set to ON to fetch copy of SDK from git if not otherwise locatable")
set(PICO_SDK_FETCH_FROM_GIT_PATH "_DOLLAR_SIGN_{PICO_SDK_FETCH_FROM_GIT_PATH}" CACHE FILEPATH "location to download SDK")

if (NOT PICO_SDK_PATH)
    if (PICO_SDK_FETCH_FROM_GIT)
        include(FetchContent)
        set(FETCHCONTENT_BASE_DIR_SAVE _DOLLAR_SIGN_{FETCHCONTENT_BASE_DIR})
        if (PICO_SDK_FETCH_FROM_GIT_PATH)
            get_filename_component(FETCHCONTENT_BASE_DIR "_DOLLAR_SIGN_{PICO_SDK_FETCH_FROM_GIT_PATH}" REALPATH BASE_DIR "_DOLLAR_SIGN_{CMAKE_SOURCE_DIR}")
        endif ()
        FetchContent_Declare(
                pico_sdk
                GIT_REPOSITORY https://github.com/raspberrypi/pico-sdk
                GIT_TAG master
        )
        if (NOT pico_sdk)
            message("Downloading Raspberry Pi Pico SDK")
            FetchContent_Populate(pico_sdk)
            set(PICO_SDK_PATH _DOLLAR_SIGN_{pico_sdk_SOURCE_DIR})
        endif ()
        set(FETCHCONTENT_BASE_DIR _DOLLAR_SIGN_{FETCHCONTENT_BASE_DIR_SAVE})
    else ()
        message(FATAL_ERROR
                "SDK location was not specified. Please set PICO_SDK_PATH or set PICO_SDK_FETCH_FROM_GIT to on to fetch from git."
                )
    endif ()
endif ()

get_filename_component(PICO_SDK_PATH "_DOLLAR_SIGN_{PICO_SDK_PATH}" REALPATH BASE_DIR "_DOLLAR_SIGN_{CMAKE_BINARY_DIR}")
if (NOT EXISTS _DOLLAR_SIGN_{PICO_SDK_PATH})
    message(FATAL_ERROR "Directory '_DOLLAR_SIGN_{PICO_SDK_PATH}' not found")
endif ()

set(PICO_SDK_INIT_CMAKE_FILE _DOLLAR_SIGN_{PICO_SDK_PATH}/pico_sdk_init.cmake)
if (NOT EXISTS _DOLLAR_SIGN_{PICO_SDK_INIT_CMAKE_FILE})
    message(FATAL_ERROR "Directory '_DOLLAR_SIGN_{PICO_SDK_PATH}' does not appear to contain the Raspberry Pi Pico SDK")
endif ()

set(PICO_SDK_PATH _DOLLAR_SIGN_{PICO_SDK_PATH} CACHE PATH "Path to the Raspberry Pi Pico SDK" FORCE)

include(_DOLLAR_SIGN_{PICO_SDK_INIT_CMAKE_FILE})


""";
