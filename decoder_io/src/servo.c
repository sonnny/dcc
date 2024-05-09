// servo.c
// https://cocode.se/linux/raspberry/pwm.html
#include "servo.h"

struct servo_type servo;

uint slice;
uint channel;

void servo_init(){
  gpio_set_function(6, GPIO_FUNC_PWM);
  slice = pwm_gpio_to_slice_num(6);
  channel = pwm_gpio_to_channel(6);
  pwm_set_clkdiv(slice, 256.0f);
  pwm_set_wrap(slice, 9804);
  pwm_set_enabled(slice, true);}
  
void servo_center(){
  pwm_set_chan_level(slice, channel, 490);}
  
void servo_low(){
  pwm_set_chan_level(slice, channel, 735); }
 
void servo_high(){
  pwm_set_chan_level(slice, channel, 1176); }
