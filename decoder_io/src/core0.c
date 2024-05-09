

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
