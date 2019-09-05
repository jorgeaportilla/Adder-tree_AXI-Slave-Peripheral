#include <stdio.h>
#include "xil_io.h"
#define CUSTOM_IP_BASEADDR 0x44a00000
#define REGISTER_1_OFFSET 0x00
#define REGISTER_2_OFFSET 0x04
#define REGISTER_3_OFFSET 0X100 //256
#define REGISTER_4_OFFSET 0x080
// Function prototypes
void set_custom_ip_register(int baseaddr, int offset, int value);
int get_custom_ip_register(int baseaddr, int offset);
int main (void)

{
	int temp3;
	int temp4;
	printf("Test Project\n\r");


	//printf("Writing to third register... %d\n", 0x04);
	//set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_2_OFFSET, 0x04);
	//printf("Done\n");
	printf("Writing to fourth register...%d\n",0x06);
	set_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET, 0x8);
	printf("Done\n");
	//temp3 = get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_2_OFFSET);
	temp4 = get_custom_ip_register(CUSTOM_IP_BASEADDR, REGISTER_4_OFFSET);
	//printf("Register 1 = %d\n", temp3);
	printf("Register 2 = %d\n", temp4);

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
