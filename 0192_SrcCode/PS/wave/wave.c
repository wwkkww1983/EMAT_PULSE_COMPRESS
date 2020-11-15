/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */
#include "wave.h"
#include "math.h"
#include "mycode.h"
#include "xil_cache.h"
#include "stdio.h"

/*
 *  Canvas description
 *
 *				|
 * 				|
 *			---------------------------------------------------->  hor_x
 *				|	   							           |
 *				|                                          |
 *              |               width                      |
 *              |      --------------------------          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |         Canvas         | height   |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      |                        |          |
 *              |      --------------------------          |
 *              |                                          |
 *              |                              frame       |
 *				--------------------------------------------
 *				|
 *				ver_y
 */


/*
 * Character pixel definition
 */
#define NUM_OF_WIDTH	 32				//Number of pixels in character width direction
#define NUM_OF_HEIGHT	 64				//Number of pixels in character height direction
#define NUM_OF_CHAR		 256			//The number of bytes corresponding to the characters in the font

/*
 * Draw wave on canvas
 *
 *@param BufferPtr        data buffer for drawing wave
 *@param CanvasBufferPtr  this is CanvasBuffer pointer, draw wave on CanvasBuffer
 *@param Sign             data sign: unsigned char 0; char 1; unsigned short 2 ;short 3
 *@param Bits             data valid bits
 *@param color            color select for wave
 *@param coe              coefficient
 *
 *@note  this function draw line between two point through checking last data and current data value,
 *		 convert data to u8 by adder and coe
 */

colorPoint cP1;

void draw_wave(u32 width, u32 height,  void *BufferPtr, u8 *CanvasBufferPtr, u8 Sign, u8 Bits, u8 color, u16 coe)
{
	u8 last_data ;
		u8 curr_data ;
		u32 i,j ;
		u8 wRed, wBlue, wGreen;
		u16 adder ;

		char *CharBufferPtr ;
		short *ShortBufferPtr ;

		if(Sign == UNSIGNEDCHAR || Sign == CHAR)
			CharBufferPtr = (char *)BufferPtr ;
		else
			ShortBufferPtr = (short *)BufferPtr ;



		float data_coe = 1.00/coe ;

		switch(color)
		{
		case 0 : wRed = 255; wGreen = 255;	wBlue = 0;	    break ;     //YELLOW color
		case 1 : wRed = 0;   wGreen = 255;	wBlue = 255;	break ;     //CYAN color
		case 2 : wRed = 0;   wGreen = 255;	wBlue = 0;	    break ;     //GREEN color
		case 3 : wRed = 255; wGreen = 0;	wBlue = 255;	break ;     //MAGENTA color
		case 4 : wRed = 255; wGreen = 0;	wBlue = 0;	    break ;     //RED color
		case 5 : wRed = 0;   wGreen = 0;	wBlue = 255;	break ;     //BLUE color
		case 6 : wRed = 255; wGreen = 255;	wBlue = 255 ;	break ;     //WRITE color
		case 7 : wRed = 150; wGreen = 150;	wBlue = 0;	    break ;     //DARK_YELLOW color
		default: wRed = 255; wGreen = 255;  wBlue = 0;	    break ;
		}
		/* if sign is singed, adder will be 1/2 of 2^Bits, for example, Bits equals to 8, adder will be 2^8/2 = 128 */
		if (Sign == CHAR || Sign == SHORT)
			adder = pow(2, Bits)/2 ;
		else
			adder = 0 ;

		for(i = 0; i < width ; i++)
		{
			/* Convert char data to u8 */
			if (i == 0)
			{
				if(Sign == UNSIGNEDCHAR || Sign == CHAR)
				{
					last_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
					curr_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
				}
				else
				{
					last_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
					curr_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
				}
			}
			else
			{
				if(Sign == UNSIGNEDCHAR || Sign == CHAR)
				{
					last_data = (u8)(CharBufferPtr[i-1] + adder)*data_coe ;
					curr_data = (u8)(CharBufferPtr[i] + adder)*data_coe ;
				}
				else
				{
					last_data = (u8)((u16)(ShortBufferPtr[i-1] + adder)*data_coe) ;
					curr_data = (u8)((u16)(ShortBufferPtr[i] + adder)*data_coe) ;
				}
			}
			/* Compare last data value and current data value, draw point between two point */
			if (curr_data >= last_data)
			{
				for (j = 0 ; j < (curr_data - last_data + 1) ; j++)
					draw_point(CanvasBufferPtr, i, (height - 1 - curr_data) + j, width, wBlue, wGreen, wRed) ;
			}
			else
			{
				for (j = 0 ; j < (last_data - curr_data + 1) ; j++)
					draw_point(CanvasBufferPtr, i, (height - 1 - last_data) + j, width, wBlue, wGreen, wRed) ;
			}
		}
}


/*
 * Draw point on point buffer
 *
 *@param PointBufferPtr     point buffer pointer
 *@param hor_x  			horizontal position
 *@param ver_y              vertical position
 *@param width              canvas width
 *
 *@note  the @width is the width of point buffer
 */
void draw_point(u8 *PointBufferPtr, u32 hor_x, u32 ver_y, u32 width, u8 wBlue, u8 wGreen, u8 wRed)
{
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 0] = wBlue;
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 1] = wGreen;
	PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 2] = wRed;
}
/*
 * Get the RGB value of each pixel
 *
 *@param PointBufferPtr     point buffer pointer
 *@param hor_x  			horizontal position
 *@param ver_y              vertical position
 *
 *@note  the @width is the width of point buffer
 */
void get_point(u8 *PointBufferPtr, u32 hor_x, u32 ver_y, u32 width) {
	cP1.rBlue = PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 0];
	cP1.rGreen = PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 1];
	cP1.rRed = PointBufferPtr[(hor_x + ver_y*width)*BYTES_PIXEL + 2];
}
/*
 * Draw grid on point buffer
 *
 *@param width              canvas width
 *@param height             canvas height
 *@param CanvasBufferPtr    canvas buffer pointer
 *
 *@note  in horizontal direction, every 32 vertical lines, draw one point in every 4 point
 *       in vertical direction, every 32 horizontal points, draw one point in every 4 point
 */
void draw_grid(u32 width, u32 height, u8 *CanvasBufferPtr)
{

	u32 xcoi, ycoi;
	u8 wRed, wBlue, wGreen;
	/*
	 * overlay grid on canvas, background set to black color, grid color is gray.
	 */
	for(ycoi = 0; ycoi < height; ycoi++)
	{
		for(xcoi = 0; xcoi < width; xcoi++)
		{

			if (((ycoi == 0 || (ycoi+1)%32 == 0) && (xcoi == 0 || (xcoi+1)%4 == 0))
					|| ((xcoi == 0 || (xcoi+1)%32 == 0) && (ycoi+1)%4 == 0))
			{
				/* gray */
				wRed = 0;
				wGreen = 0;
				wBlue = 0;
			}
			else
			{
				/* Black */
				wRed = 255;
				wGreen = 255;
				wBlue = 255;
			}
			draw_point(CanvasBufferPtr, xcoi, ycoi, width, wBlue, wGreen, wRed);
		}
	}
}
/*
 * Draw a cursor in a certain column on a frame
 *
 *@param hor_x  			horizontal position
 *@param hor_x_b            The horizontal position of the previous cursor
 *@param width				canvas width
 *@param height				canvas height
 *
 */
void draw_currsor(u32 hor_x, u32 hor_x_b, u32 width, u32 height, u8 *CanvasBufferPtr, u8 Blue, u8 Green, u8 Red) {
	u32  ycoi;
	u8 wRed, wBlue, wGreen;
	wRed = Red;
	wBlue = Blue;
	wGreen = Green;
	if(hor_x == 0 && hor_x_b == 0) {
		for(int i = 0; i < height; i++) {
			get_point(CanvasBufferPtr, hor_x, i, width);
			draw_point(CurrsorTempBuffer, 0, i, 1, cP1.rBlue, cP1.rGreen, cP1.rRed);
		}
	}
	else {
		for(int i = 0; i < height; i++) {
			get_point(CurrsorTempBuffer, 0, i, 1);
			draw_point(CanvasBufferPtr, hor_x_b, i, width, cP1.rBlue, cP1.rGreen, cP1.rRed);
			get_point(CanvasBufferPtr, hor_x, i, width);
			draw_point(CurrsorTempBuffer, 0, i, 1, cP1.rBlue, cP1.rGreen, cP1.rRed);
		}
	}
	for (ycoi = 0; ycoi < height; ycoi++) {
		draw_point(CanvasBufferPtr, hor_x, ycoi, width, wBlue, wGreen, wRed);
	}
}
/*
 * Display a char
 *
 *@param charToDisp		char to display
 *@param frame			frame buffer pointer
 *
 */
void show_char(u32 hor_x, u32 ver_y, u8 charToDisp, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed) {

	u32 temp,t1,t;
	u32 x = 0;
	u32 y = 0;
	charToDisp = charToDisp-' ';

	for(t=0; t < NUM_OF_CHAR; t++) {
		temp=ASCII9045[charToDisp][t];
		for(t1=0; t1<8; t1++)
		{
			if(temp & 0x80) {
				draw_point(CharBuffer, x, y, NUM_OF_WIDTH, wBlue, wGreen, wRed);
			}
			else {
				draw_point(CharBuffer, x, y, NUM_OF_WIDTH, 255, 255, 255);
			}
			temp <<= 1;
			x++;
			if(x == NUM_OF_WIDTH) {
				x = 0;
				y++;
				break;
			}
		}
	}
	frame_copy(NUM_OF_WIDTH, NUM_OF_HEIGHT, 1920*3, hor_x, ver_y, frame, CharBuffer);
}
/*
 * Display a string
 *
 *@param strPtr			String pointer
 *@param frame			Frame pointer
 */
void show_string(u32 hor_x, u32 ver_y, u8 *strPtr, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed) {
    while((*strPtr <= '~')&&(*strPtr >= ' '))
    {
    	show_char(hor_x, ver_y, *strPtr, frame, wBlue, wGreen, wRed);
    	hor_x += NUM_OF_WIDTH;
    	strPtr++;
    }
}
/*
 *	Power function
 *	return m^n
 */
u32 Pow(u8 m, u8 n) {
	u32 result = 1;
	while(n--)result *= m;
	return result;
}
/*
 * Calculate the length of an integer
 */
u32 LenOfNum(u32 n) {
	u32 count = 0;
	do {
		n /= 10;
		count++;
	}while(n != 0);
	return count;
}
/*
 * Show a num
 */
void show_num(u32 hor_x, u32 ver_y, u32 num, u8 *frame, u8 wBlue, u8 wGreen, u8 wRed) {
	u8 t,temp;
	u8 len;
	len = LenOfNum(num);
	for(t=0;t<len;t++)
	{
		temp=(num / Pow(10, len-t-1)) % 10;
		show_char(hor_x + ((NUM_OF_WIDTH - 2) * t), ver_y, temp + '0', frame, wBlue, wGreen, wRed);
	}
	for(t = len; t < 7 - len; t++) {
		show_char(hor_x + ((NUM_OF_WIDTH - 2) * t), ver_y, ' ', frame, 0, 0, 0);
	}
}
/*
 * Show a float
 *@param length 			Decimal places
 *@param total_length		Total number of (pixels * 32)
 */
void show_float(u32 hor_x, u32 ver_y, double num, u8 *frame, u8 length, u8 total_length, u8 wBlue, u8 wGreen, u8 wRed) {
	u32 t;
	int num_int = num;
	double num_float = num - num_int;
	/*显示整数部分*/
	u32 len = LenOfNum(num_int);
	show_num(hor_x, ver_y, num_int, frame, wBlue, wGreen, wRed);
	hor_x += (NUM_OF_WIDTH - 2) * len;
	show_char(hor_x, ver_y, '.',frame, wBlue, wGreen, wRed);
	for (t = 1; t <= length; t++) {
		num_float *= 10;
		num_int = num_float;
		num_float = num_float - num_int;
		hor_x += (NUM_OF_WIDTH - 2);
		show_num(hor_x, ver_y, num_int, frame, wBlue, wGreen, wRed);
	}
	for (t = 1; t <= total_length - len - length - 1; t++) {
		show_char(hor_x + ((NUM_OF_WIDTH - 2) * t), ver_y, ' ', frame, 0, 0, 0);
	}
}

/*
 *Copy canvas buffer data to special position in frame
 *
 *@param hor_x  start horizontal position for copy
 *@param ver_y  start vertical position for copy
 *@param width  width for copy
 *@param height height for copy
 *
 *@note  hor_x+width should be less than frame width, ver_y+height should be less than frame height
 */
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr)
{
	int i ;
	u32 FrameOffset ;
	u32 CanvasOffset ;
	u32 CopyLen = width*BYTES_PIXEL ;

	for(i = 0 ; i < height;  i++)
	{
		FrameOffset = (ver_y+i)*stride + hor_x*BYTES_PIXEL ;
		CanvasOffset = i*width*BYTES_PIXEL ;
		memcpy(frame+FrameOffset, CanvasBufferPtr+CanvasOffset, CopyLen) ;
	}

	FrameOffset = ver_y*stride ;

	Xil_DCacheFlushRange((INTPTR) frame+FrameOffset, height*stride) ;
}















