#ifndef _SSD1306_H
#define _SSD1306_H

// ssd1306 from https://github.com/baetis-ma/rpi-pico-projects/blob/master/imu-pico/include/ssd1306.h
//#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/i2c.h"

void ssd1306_init();
int ssd1306_display(char *s);
int ssd1306_blank(uint8_t c);
#endif
