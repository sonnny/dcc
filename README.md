
My experimentation of model train dcc that uses RP2040 for dcc station and dcc decoder

youtube demo ---

open source dcc locomotive decoder using RP2040 pico --- https://ilabs.se/product/opendec02/

RP2040 decoder github --- https://github.com/PontusO/RP2040-Decoder

RP2040 dcc station github --- https://github.com/pico-cs/firmware

In the pictures folder there is a picture of dcc track interface to 3.3v RP2040 pico, this screenshot is taken from this link https://wakwak2popo.wordpress.com/2020/12/11/dcc-sniffer/ and works very well with the pico.

the servo code is copied from this link --- https://cocode.se/linux/raspberry/pwm.html

the decoder io is a stripped down version of the open source dcc decoder (https://github.com/gab-k/RP2040-Decoder) with relative motor and function codes removed, it only looks at the speed packet format.









