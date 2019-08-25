/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
//#include "xil_printf.h"

#include "xil_io.h"
#define CUSTOM_IP_BASEADDR 0x44a00000
#define REGISTER_1_OFFSET 0x00
#define REGISTER_2_OFFSET 0x04
#define REGISTER_3_OFFSET 0X100 //256
#define REGISTER_4_OFFSET 0x080

// Function prototypes
void set_custom_ip_register(int baseaddr, int offset, int value);
int get_custom_ip_register(int baseaddr, int offset);

int main()
{
    init_platform();
    print("TEST ADDER-TREE\n\r");
	//int temp4;
	printf("BRAM1 write data \n"); //255 send data to BRAM1                                     //254 send data to BRAM2
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0xFF);
	//send data
	for (int i= 0; i <256; i++ ) {
		set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0x01);
	}
	//printf("BRAM2 write data \n"); //255 send data to BRAM2                                //254 send data to BRAM2
	//set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0xFE);
	//send data
	//for (int i= 0; i <256; i++ ) {
	//	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0x01);
	//}



	//temp4 = get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET);
	//printf("result = %d\n", temp4);
    cleanup_platform();
    return 0;
}

void set_custom_ip_register(int baseaddr, int offset, int value)
{
	Xil_Out32(baseaddr + offset, value);
}

int get_custom_ip_register(int baseaddr, int offset)
{
	int temp = 0;
	temp = Xil_In32(baseaddr + offset);
	return (temp);
}
