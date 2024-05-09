#ifndef _SERVO_H
#define _SERVO_H

#include "pico/stdlib.h"
#include "hardware/pwm.h"
#include "hardware/clocks.h"

struct servo_type{
  uint gpio;
  uint slice;
  uint chan;
  uint speed;
  uint resolution;
  bool on;
  bool invert;};

void servo_init();
void servo_low();
void servo_high();
void servo_center();

#endif
