// ssd1306.c
#include "ssd1306.h"

uint8_t fonttable5x7[1080] = {
  0x00, 0x00, 0x00, 0x00, 0x00, // SPACE
  0x00, 0x00, 0x5F, 0x00, 0x00, // !
  0x00, 0x03, 0x00, 0x03, 0x00, // "
  0x14, 0x3E, 0x14, 0x3E, 0x14, // #
  0x24, 0x2A, 0x7F, 0x2A, 0x12, // $
  0x43, 0x33, 0x08, 0x66, 0x61, // %
  0x36, 0x49, 0x55, 0x22, 0x50, // &
  0x00, 0x05, 0x03, 0x00, 0x00, // '
  0x00, 0x1C, 0x22, 0x41, 0x00, // (
  0x00, 0x41, 0x22, 0x1C, 0x00, // )
  0x14, 0x08, 0x3E, 0x08, 0x14, // *
  0x08, 0x08, 0x3E, 0x08, 0x08, // +
  0x00, 0x50, 0x30, 0x00, 0x00, // ,
  0x08, 0x08, 0x08, 0x08, 0x08, // -
  0x00, 0x60, 0x60, 0x00, 0x00, // .
  0x20, 0x10, 0x08, 0x04, 0x02, // /

  0x3E, 0x51, 0x49, 0x45, 0x3E, // 0
  0x00, 0x04, 0x02, 0x7F, 0x00, // 1
  0x42, 0x61, 0x51, 0x49, 0x46, // 2
  0x22, 0x41, 0x49, 0x49, 0x36, // 3
  0x18, 0x14, 0x12, 0x7F, 0x10, // 4
  0x27, 0x45, 0x45, 0x45, 0x39, // 5
  0x3E, 0x49, 0x49, 0x49, 0x32, // 6
  0x01, 0x01, 0x71, 0x09, 0x07, // 7
  0x36, 0x49, 0x49, 0x49, 0x36, // 8
  0x26, 0x49, 0x49, 0x49, 0x3E, // 9
  0x00, 0x36, 0x36, 0x00, 0x00, // :
  0x00, 0x56, 0x36, 0x00, 0x00, // ;
  0x08, 0x14, 0x22, 0x41, 0x00, // <
  0x14, 0x14, 0x14, 0x14, 0x14, // =
  0x00, 0x41, 0x22, 0x14, 0x08, // >
  0x02, 0x01, 0x51, 0x09, 0x06, // ?

  0x3E, 0x41, 0x59, 0x55, 0x5E, // @
  0x7E, 0x09, 0x09, 0x09, 0x7E, // A
  0x7F, 0x49, 0x49, 0x49, 0x36, // B
  0x3E, 0x41, 0x41, 0x41, 0x22, // C
  0x7F, 0x41, 0x41, 0x41, 0x3E, // D
  0x7F, 0x49, 0x49, 0x49, 0x41, // E
  0x7F, 0x09, 0x09, 0x09, 0x01, // F
  0x3E, 0x41, 0x41, 0x49, 0x3A, // G
  0x7F, 0x08, 0x08, 0x08, 0x7F, // H
  0x00, 0x41, 0x7F, 0x41, 0x00, // I
  0x30, 0x40, 0x40, 0x40, 0x3F, // J
  0x7F, 0x08, 0x14, 0x22, 0x41, // K
  0x7F, 0x40, 0x40, 0x40, 0x40, // L
  0x7F, 0x02, 0x0C, 0x02, 0x7F, // M
  0x7F, 0x02, 0x04, 0x08, 0x7F, // N
  0x3E, 0x41, 0x41, 0x41, 0x3E, // O

  0x7F, 0x09, 0x09, 0x09, 0x06, // P
  0x1E, 0x21, 0x21, 0x21, 0x5E, // Q
  0x7F, 0x09, 0x09, 0x09, 0x76, // R
  0x26, 0x49, 0x49, 0x49, 0x32, // S
  0x01, 0x01, 0x7F, 0x01, 0x01, // T
  0x3F, 0x40, 0x40, 0x40, 0x3F, // U
  0x1F, 0x20, 0x40, 0x20, 0x1F, // V
  0x7F, 0x20, 0x10, 0x20, 0x7F, // W
  0x41, 0x22, 0x1C, 0x22, 0x41, // X
  0x07, 0x08, 0x70, 0x08, 0x07, // Y
  0x61, 0x51, 0x49, 0x45, 0x43, // Z
  0x00, 0x7F, 0x41, 0x00, 0x00, // [
  0x02, 0x04, 0x08, 0x10, 0x20, // backslash
  0x00, 0x00, 0x41, 0x7F, 0x00, // ]
  0x04, 0x02, 0x01, 0x02, 0x04, // ^
  0x40, 0x40, 0x40, 0x40, 0x40, // _

  0x00, 0x01, 0x02, 0x04, 0x00, // `
  0x20, 0x54, 0x54, 0x54, 0x78, // a
  0x7F, 0x44, 0x44, 0x44, 0x38, // b
  0x38, 0x44, 0x44, 0x44, 0x44, // c
  0x38, 0x44, 0x44, 0x44, 0x7F, // d
  0x38, 0x54, 0x54, 0x54, 0x18, // e
  0x04, 0x04, 0x7E, 0x05, 0x05, // f
  0x08, 0x54, 0x54, 0x54, 0x3C, // g
  0x7F, 0x08, 0x04, 0x04, 0x78, // h
  0x00, 0x44, 0x7D, 0x40, 0x00, // i
  0x20, 0x40, 0x44, 0x3D, 0x00, // j
  0x7F, 0x10, 0x28, 0x44, 0x00, // k
  0x00, 0x41, 0x7F, 0x40, 0x00, // l
  0x7C, 0x04, 0x78, 0x04, 0x78, // m
  0x7C, 0x08, 0x04, 0x04, 0x78, // n
  0x38, 0x44, 0x44, 0x44, 0x38, // o

  0x7C, 0x14, 0x14, 0x14, 0x08, // p
  0x08, 0x14, 0x14, 0x14, 0x7C, // q
  0x00, 0x7C, 0x08, 0x04, 0x04, // r
  0x48, 0x54, 0x54, 0x54, 0x20, // s
  0x04, 0x04, 0x3F, 0x44, 0x44, // t
  0x3C, 0x40, 0x40, 0x20, 0x7C, // u
  0x1C, 0x20, 0x40, 0x20, 0x1C, // v
  0x3C, 0x40, 0x30, 0x40, 0x3C, // w
  0x44, 0x28, 0x10, 0x28, 0x44, // x
  0x0C, 0x50, 0x50, 0x50, 0x3C, // y
  0x44, 0x64, 0x54, 0x4C, 0x44, // z
  0x00, 0x08, 0x36, 0x41, 0x41, // {
  0x00, 0x00, 0x7F, 0x00, 0x00, // |
  0x41, 0x41, 0x36, 0x08, 0x00, // }
  0x02, 0x01, 0x02, 0x04, 0x02  // ~
};

void ssd1306_init(){
  i2c_init(i2c1, 400*1000);
  gpio_set_function(18, GPIO_FUNC_I2C);
  gpio_set_function(19, GPIO_FUNC_I2C);
  gpio_pull_up(18);
  gpio_pull_up(19);
  uint8_t data[] = { 0x00, 0xae, 0xd5, 0x80, 0xa8, 0x3f, 0xd3, 0x00, 0x40, 0x8d, 0x14, 0x20, 0x00, 0xa1, 0xc8, 0xda, 0x12, 0x81, 0xcf, 0xd9, 0xf1, 0xdb, 0x40, 0xa4, 0xa6, 0xaf };
  i2c_write_blocking( i2c1, 0x3c, data, 26, true);
}

int ssd1306_blank(uint8_t val)
{
   int len = 1024;
   uint8_t *data = malloc (len+1);
   data[0] = 0x40;
   for(int i=0; i<len+1; i++){ data[i] = val; }
   i2c_write_blocking( i2c1, 0x3c, data, len/2, true);
   free(data);
   return(0);
}

int ssd1306_display( char *disp_string )
{
   int len = 2048;
   //int len = 1024;
   int framebuf_ptr = 0;
   int line = 0;
   int size = 1;
   char f0;
   char f1;
   char ft;

   //setup and clear framebuffer;
   uint8_t *framebuffer = malloc(len);
   for(int i=0; i<len; i++){ framebuffer[i]= (uint8_t)0x00; }

   for (int n=0; n< strlen( disp_string); n++) {
      if(disp_string[n] == '|') { framebuf_ptr = 128 * ++line; }
      else if(disp_string[n]=='1' && framebuf_ptr%128 == 0){size = 1;++framebuf_ptr;}
      else if(disp_string[n]=='2' && framebuf_ptr%128 == 0){size = 2;++framebuf_ptr;}
      else if(disp_string[n]=='4' && framebuf_ptr%128 == 0){size = 4;++framebuf_ptr;}
      else if(size == 1){
         for(int a=0; a < 5; a++){
             framebuffer[framebuf_ptr++] = fonttable5x7[(a + 5*(disp_string[n]-' ' ))%1024]; }
         framebuf_ptr++; }
      else if(size == 2 || size == 4){ //twice as wide
          for(int a=0; a < 5; a++){
             framebuffer[framebuf_ptr++] = fonttable5x7[(a + 5*(disp_string[n]-' ' ))%1024];
             framebuffer[framebuf_ptr++] = fonttable5x7[(a + 5*(disp_string[n]-' ' ))%1024];
             if(size == 4){ //twice as big
                 f0 = 0; f1 = 0;
                 ft = fonttable5x7[a + 5*(disp_string[n]-' ')] ;
                 if((ft >> 7) & 1) f0 = 0xc0;
                 if((ft >> 6) & 1) f0 = f0 + 0x30;
                 if((ft >> 5) & 1) f0 = f0 + 0x0c;
                 if((ft >> 4) & 1) f0 = f0 + 0x03;
                 if((ft >> 3) & 1) f1 = 0xc0;
                 if((ft >> 2) & 1) f1 = f1 + 0x30;
                 if((ft >> 1) & 1) f1 = f1 + 0x0c;
                 if((ft >> 0) & 1) f1 = f1 + 0x03;
                 framebuffer[framebuf_ptr - 1] = f1;
                 framebuffer[framebuf_ptr - 2] = f1;
                 framebuffer[128+ (framebuf_ptr - 1)] = f0;
                 framebuffer[128+ (framebuf_ptr - 2)] = f0;
             }
          }
       framebuf_ptr++; }
   }
   uint8_t *data = malloc (len+1);
   data[0] = 0x40;
   for(int i=0; i<len; i++){ data[i+1] = framebuffer[i]; }

   i2c_write_blocking( i2c1, 0x3c, data, len/2+1, true);
   free(framebuffer);
   free(data);
   return(0);
}
