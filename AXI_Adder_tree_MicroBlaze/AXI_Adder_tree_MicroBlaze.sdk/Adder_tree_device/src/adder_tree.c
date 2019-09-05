/* Adder-tree_AXI-Slave-Peripheral
 *
 The design of a specialized coprocessor based on an adder tree is described, using the Xilinx Vivado tools to create custom AXI-lite slave peripherals. In addition, measurements of execution times are made.
 *
 UTFSM
 DISEÑO AVANZADO DE SISTEMAS DIGITALES
 Jorge Portilla-Jesus Ortiz
 IPD-432
 * */
#include <stdio.h>
#include "platform.h"
#include "xil_io.h"
#include "sleep.h"
#include "mb_interface.h"
#include "xtmrctr_l.h"
#include <string.h>

#define CUSTOM_IP_BASEADDR 0x44a00000
#define REGISTER_1_OFFSET 0x00
#define RESET_VALUE	 0xF0000000

// Function prototypes
void set_custom_ip_register(int baseaddr, int offset, int value);
int get_custom_ip_register(int baseaddr, int offset);
int temp1, temp2= 0;
int OPERATION;
int sum[256],prom[256];

int main()
{
	init_platform();
	static int tic = 0;
	/* reset the timers, and clear interrupts */
	//XTmrCtr_mSetControlStatusReg(XPAR_TMRCTR_0_BASEADDR, 1,XTC_CSR_INT_OCCURED_MASK | XTC_CSR_LOAD_MASK );
	XTmrCtr_SetLoadReg(XPAR_TMRCTR_0_BASEADDR, 1, RESET_VALUE);
	XTmrCtr_Enable(XPAR_TMRCTR_0_BASEADDR,1);
    tic = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR,1);
    printf("***** DEVICE ***** \n");
	printf("SIPO1 write data... \n"); //255 send data to SIPO1
	printf("SIPO2 write data... \n");
	for (int i= 0; i <2; i++ ) {//254 send data to SIPO2
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, 0xFF);
	for (int i= 0; i <256; i++ ) {
		set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, 0x01);}
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, 0xFE);//254 send data to SIPO2
	for (int i= 0; i <256; i++ ) {
		set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, 0x00);}}
	/* Select operation ....0xFA manDist,	 0xF8 Sum,	 0xF9 Prom 	 */
	OPERATION = 0xFA;
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, OPERATION);
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET, OPERATION);
    temp2 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_1_OFFSET );
    if (OPERATION == 0xFA){
    	printf("manDist = %d\n", temp2);}
    if(OPERATION == 0xF9){
    	printf("Prom  = ");
    	for (int i= 262; i < 517; i++ ) {
    		temp1 = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, i);
    		printf("%d, ", temp1);
    	}}
    if (OPERATION == 0xF8){
    	printf("Sum  = ");
    	for (int i=6; i <262; i++ ) {
    		sum[i] = 	get_custom_ip_register(CUSTOM_IP_BASEADDR, i);
    		printf("%d, ", sum[i]);
    	}}

    tic = XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR,1)-tic;
    printf("\n Elapsed time : %d  Clock Cycles\n", tic);
    //XTmrCtr_SetResetValue(XPAR_TMRCTR_0_BASEADDR, 1, RESET_VALUE);
    //XTmrCtr_SetLoadReg(XPAR_TMRCTR_0_BASEADDR, 1, RESET_VALUE);
    //XTmrCtr_Stop(XPAR_TMRCTR_0_BASEADDR, 1);
    XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR,1);
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
