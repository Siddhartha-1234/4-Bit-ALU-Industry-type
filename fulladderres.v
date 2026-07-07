#! /c/Source/iverilog-install/bin/vvp
:ivl_version "12.0 (devel)" "(s20150603-1539-g2693dd32b)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision - 12;
:vpi_module "C:\iverilog\lib\ivl\system.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_sys.vpi";
:vpi_module "C:\iverilog\lib\ivl\vhdl_textio.vpi";
:vpi_module "C:\iverilog\lib\ivl\v2005_math.vpi";
:vpi_module "C:\iverilog\lib\ivl\va_math.vpi";
S_00000164c61f5ba0 .scope module, "full_adder_tb" "full_adder_tb" 2 4;
 .timescale -9 -12;
v00000164c6240a90_0 .var "a", 0 0;
v00000164c6241530_0 .var "b", 0 0;
v00000164c6240b30_0 .var "cin", 0 0;
v00000164c6240db0_0 .net "cout", 0 0, L_00000164c61f4000;  1 drivers
v00000164c62409f0_0 .var/i "i", 31 0;
v00000164c6240e50_0 .net "sum", 0 0, L_00000164c61c3650;  1 drivers
S_00000164c61f5d30 .scope module, "DUT" "full_adder" 2 10, 3 1 0, S_00000164c61f5ba0;
 .timescale -9 -12;
    .port_info 0 /INPUT 1 "a";
    .port_info 1 /INPUT 1 "b";
    .port_info 2 /INPUT 1 "cin";
    .port_info 3 /OUTPUT 1 "sum";
    .port_info 4 /OUTPUT 1 "cout";
L_00000164c61c3210 .functor XOR 1, v00000164c6240a90_0, v00000164c6241530_0, C4<0>, C4<0>;
L_00000164c61c3650 .functor XOR 1, L_00000164c61c3210, v00000164c6240b30_0, C4<0>, C4<0>;
L_00000164c61e6140 .functor AND 1, v00000164c6240a90_0, v00000164c6241530_0, C4<1>, C4<1>;
L_00000164c61e61b0 .functor AND 1, v00000164c6241530_0, v00000164c6240b30_0, C4<1>, C4<1>;
L_00000164c61e6220 .functor OR 1, L_00000164c61e6140, L_00000164c61e61b0, C4<0>, C4<0>;
L_00000164c61f3c80 .functor AND 1, v00000164c6240a90_0, v00000164c6240b30_0, C4<1>, C4<1>;
L_00000164c61f4000 .functor OR 1, L_00000164c61e6220, L_00000164c61f3c80, C4<0>, C4<0>;
v00000164c61c3430_0 .net *"_ivl_0", 0 0, L_00000164c61c3210;  1 drivers
v00000164c61c2f90_0 .net *"_ivl_10", 0 0, L_00000164c61f3c80;  1 drivers
v00000164c61f5ec0_0 .net *"_ivl_4", 0 0, L_00000164c61e6140;  1 drivers
v00000164c61f5f60_0 .net *"_ivl_6", 0 0, L_00000164c61e61b0;  1 drivers
v00000164c61e5d80_0 .net *"_ivl_8", 0 0, L_00000164c61e6220;  1 drivers
v00000164c61e5e20_0 .net "a", 0 0, v00000164c6240a90_0;  1 drivers
v00000164c61e5ec0_0 .net "b", 0 0, v00000164c6241530_0;  1 drivers
v00000164c61e5f60_0 .net "cin", 0 0, v00000164c6240b30_0;  1 drivers
v00000164c61e6000_0 .net "cout", 0 0, L_00000164c61f4000;  alias, 1 drivers
v00000164c61e60a0_0 .net "sum", 0 0, L_00000164c61c3650;  alias, 1 drivers
    .scope S_00000164c61f5ba0;
T_0 ;
    %vpi_call 2 16 "$dumpfile", "full_adder.vcd" {0 0 0};
    %vpi_call 2 17 "$dumpvars", 32'sb00000000000000000000000000000000, S_00000164c61f5ba0 {0 0 0};
    %vpi_call 2 19 "$display", "  a b cin | sum cout | expected_sum expected_cout" {0 0 0};
    %pushi/vec4 0, 0, 32;
    %store/vec4 v00000164c62409f0_0, 0, 32;
T_0.0 ;
    %load/vec4 v00000164c62409f0_0;
    %cmpi/s 8, 0, 32;
    %jmp/0xz T_0.1, 5;
    %load/vec4 v00000164c62409f0_0;
    %parti/s 3, 0, 2;
    %split/vec4 1;
    %store/vec4 v00000164c6240b30_0, 0, 1;
    %split/vec4 1;
    %store/vec4 v00000164c6241530_0, 0, 1;
    %store/vec4 v00000164c6240a90_0, 0, 1;
    %delay 10000, 0;
    %load/vec4 v00000164c6240a90_0;
    %load/vec4 v00000164c6241530_0;
    %xor;
    %load/vec4 v00000164c6240b30_0;
    %xor;
    %load/vec4 v00000164c6240a90_0;
    %load/vec4 v00000164c6241530_0;
    %and;
    %load/vec4 v00000164c6241530_0;
    %load/vec4 v00000164c6240b30_0;
    %and;
    %or;
    %load/vec4 v00000164c6240a90_0;
    %load/vec4 v00000164c6240b30_0;
    %and;
    %or;
    %vpi_call 2 23 "$display", " %b %b  %b  |  %b   %b   |     %b            %b", v00000164c6240a90_0, v00000164c6241530_0, v00000164c6240b30_0, v00000164c6240e50_0, v00000164c6240db0_0, S<1,vec4,u1>, S<0,vec4,u1> {2 0 0};
    %load/vec4 v00000164c62409f0_0;
    %addi 1, 0, 32;
    %store/vec4 v00000164c62409f0_0, 0, 32;
    %jmp T_0.0;
T_0.1 ;
    %vpi_call 2 29 "$display", "Full adder test complete." {0 0 0};
    %vpi_call 2 30 "$finish" {0 0 0};
    %end;
    .thread T_0;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    "full_adder_tb.v";
    "./full_adder.v";
