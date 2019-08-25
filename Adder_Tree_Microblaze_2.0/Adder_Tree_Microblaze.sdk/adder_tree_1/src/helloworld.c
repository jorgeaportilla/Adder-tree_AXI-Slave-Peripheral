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
#include "sleep.h"
#define CUSTOM_IP_BASEADDR 0x44a00000
#define REGISTER_1_OFFSET 0x00
#define REGISTER_2_OFFSET 0x04  //4
#define REGISTER_3_OFFSET 0X100 //256
#define REGISTER_4_OFFSET 0x080 //128
#define REGISTER_i_OFFSET 0xFF //255

// Function prototypes
void set_custom_ip_register(int baseaddr, int offset, int value);
int get_custom_ip_register(int baseaddr, int offset);
int temp1, temp2, temp3,temp4,temp5,temp6,temp7 = 0;
int OPERATION;
int data1[] = { 1,2,3,4,5,6};
int data2[] = { 0,0,0,0,0,0};


int main()
{
    init_platform();
	printf("BRAM1 write data... \n"); //255 send data to BRAM1                                     //254 send data to BRAM2
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0xFF);
	for (int i= 0; i <256; i++ ) {
		set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0x01);
	}
	printf("BRAM2 write data... \n"); //254 send data to BRAM2
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0xFE);
	for (int i= 0; i <256; i++ ) {
		set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0x00);
	}
	/* Select operation ....
	 0xFA manDist
	 0xF8 Sum
	 0xF9 Prom
	 */
	OPERATION = 0xFA;
	for (int k= 0; k < 2; k++ ) {
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, OPERATION);
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, OPERATION);
    temp2 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET );
	}
	//
	//set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_3_OFFSET, 0x02);
    //temp3 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_3_OFFSET );
    //printf("escrito = %d\n", temp3);

	temp4 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x05);
	printf("d1 = %d\n", temp4);
	temp5 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x06 );
	printf("d2= %d\n", temp5);
	temp6 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x07);
	printf("d3 = %d\n", temp6);


	temp7 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x08 );
	printf("d4 = %d\n", temp7);
	temp4 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0xA);
	printf("d10 = %d\n", temp4);
	temp5 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0xA+1 );
	printf("d11= %d\n", temp5);
	temp6 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, 0xa+2);
	printf("d12 = %d\n", temp6);

	temp7 = get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x14 );
	printf("dd20 = %d\n", temp7);
	temp7 = get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x15 );
	printf("dd21 = %d\n", temp7);
	temp7 = get_custom_ip_register(CUSTOM_IP_BASEADDR, 0x16 );
	printf("dd22 = %d\n", temp7);


    if (OPERATION == 0xFA)
    	printf("manDist = %d\n", temp2);
    else if (OPERATION == 0xF8){
    	printf("Sum  = ");
    	for (int i= 0; i <256; i++ ) {
    		temp1 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, i);
    		printf("%d, ", temp1);
    	}}
    else{
    	printf("Prom  = ");
    	for (int i= 300; i <556; i++ ) {
    		temp1 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, i);
    		printf("%d, ", temp1);
    	}
    }
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
