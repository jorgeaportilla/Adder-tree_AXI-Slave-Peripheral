connect -url tcp:127.0.0.1:3121
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292A3FD96A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292A3FD96A"} -index 0
dow /home/jorge/VivadoUSM/Designing-a-Custom-AXI-Slave-Peripheral-master/axi_rc_servo_controller_v2_00_a/axi_rc_servo_controller_v2_00_a.sdk/test_software/Debug/test_software.elf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292A3FD96A"} -index 0
con
