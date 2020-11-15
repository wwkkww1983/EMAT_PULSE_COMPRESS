/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "xil_types.h"
#include "string.h"

#define BYTES_PIXEL     3
/*
 * Color definitions
 */
#define YELLOW           0
#define CYAN             1
#define GREEN            2
#define MAGENTA          3
#define RED              4
#define BLUE             5
#define WRITE            6
#define DARK_YELLOW      7

#define UNSIGNEDCHAR     0
#define CHAR             1
#define UNSIGNEDSHORT    2
#define SHORT            3
#define FLOAT			 4


/*
 * struct define
 * pixel color data
 * RGB888
 */
typedef struct {
	u8 rBlue;
	u8 rGreen;
	u8 rRed;
}colorPoint;
/*
 * register a column of a frame of data
 */
u8 CurrsorTempBuffer[360 * 3];
/*
 * Char buffer
 */
u8 CharBuffer[32 * 64 * 3];

/*
 * Functions declaration
 */
void draw_grid(u32 width, u32 height, u8 *CanvasBufferPtr) ;
void draw_wave(u32 width, u32 height, void *BufferPtr, u8 *CanvasBufferPtr,  u8 Sign, u8 Bits, u8 color, u16 coe) ;
void draw_point(u8 *PointBufferPtr, u32 hor_x, u32 ver_y, u32 width, u8 wBlue, u8 wGreen, u8 wRed);
void draw_currsor(u32 hor_x,u32 hor_x_b, u32 width, u32 height, u8 *CanvasBufferPtr, u8 Blue, u8 Green, u8 Red);
void get_point(u8 *PointBufferPtr, u32 hor_x, u32 ver_y, u32 width) ;
void show_char(u32 hor_x, u32 ver_y, u8 charToDisp, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed);
void show_string(u32 hor_x, u32 ver_y, u8 *strToPtr, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed);
void show_num(u32 hor_x, u32 ver_y, u32 num, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed);
void show_float(u32 hor_x, u32 ver_y, double num, u8 *frame, u8 length, u8 total_length, u8 wBlue, u8 wGreen, u8 wRed);
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr) ;
u32 Pow(u8 m, u8 n);
u32 LenOfNum(u32 n);


