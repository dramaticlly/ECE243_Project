
void write_pixel(int x, int y, short colour) {
  volatile short *vga_addr=(volatile short*)(0x08000000 + (y<<10) + (x<<1));
  *vga_addr=colour;
}


void clear_screen() {
  int x, y;
  for (x = 0; x < 320; x++) {
    for (y = 0; y < 240; y++) {
	  write_pixel(x,y,0);
	}
  }
}

void write_char(int x, int y, char character) {
  volatile char *vga_charaddr=(volatile char*)(0x09000000 + (y<<7) + (x<<0));
  *vga_charaddr=character;
}

void clear_charscreen() {
  int x, y;
  for (x = 0; x < 80; x++) {
    for (y = 0; y < 60; y++) {
	  write_char(x,y,'\0');
	}
  }
}
 