/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_1242562249;
char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *IEEE_P_3564397177;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_1242562249_init();
    work_a_3640966720_3212880686_init();
    work_a_1878704884_3212880686_init();
    work_a_1849206979_3212880686_init();
    work_a_1803009606_3212880686_init();
    work_a_1790301297_3212880686_init();
    work_a_1760782888_3212880686_init();
    work_a_0046335324_3212880686_init();
    work_a_2435431746_3212880686_init();
    std_textio_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_0636002445_2959432447_init();
    xilinxcorelib_a_0264280303_2959432447_init();
    xilinxcorelib_a_3468166361_1709443946_init();
    xilinxcorelib_a_1688231316_0543512595_init();
    xilinxcorelib_a_0195560985_3212880686_init();
    work_a_3992961014_1530168645_init();
    work_a_1755744560_2372691052_init();


    xsi_register_tops("work_a_1755744560_2372691052");

    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
