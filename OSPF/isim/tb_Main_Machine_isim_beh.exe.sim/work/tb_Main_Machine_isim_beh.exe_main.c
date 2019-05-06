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

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *IEEE_P_1242562249;
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
    work_a_1183831083_3212880686_init();
    work_a_0551090166_3212880686_init();
    work_a_2106252647_3212880686_init();
    xilinxcorelib_a_0905230708_3212880686_init();
    xilinxcorelib_a_3695203095_3212880686_init();
    xilinxcorelib_a_1731708352_3212880686_init();
    work_a_1704919846_2473526065_init();
    work_a_0741885686_3212880686_init();
    work_a_3678236358_3212880686_init();
    work_a_3404592116_3212880686_init();
    work_a_3783486119_3212880686_init();
    work_a_0273547028_3212880686_init();
    work_a_3831716018_3212880686_init();
    work_a_2073123889_3212880686_init();
    work_a_2411723671_3212880686_init();
    work_a_2121362980_3212880686_init();
    work_a_2321533314_3212880686_init();
    work_a_3232682695_3212880686_init();
    xilinxcorelib_a_3987453550_3212880686_init();
    xilinxcorelib_a_0069809187_3212880686_init();
    xilinxcorelib_a_1034220630_3212880686_init();
    work_a_0951143342_1269056934_init();
    work_a_0556930266_3212880686_init();
    work_a_1781693967_3212880686_init();
    work_a_0992175687_3212880686_init();
    work_a_3473785313_3212880686_init();
    work_a_1358939490_3212880686_init();
    work_a_2765185732_3212880686_init();
    work_a_1428158327_3212880686_init();
    work_a_2704363729_3212880686_init();
    work_a_3955248020_3212880686_init();
    work_a_2288433579_3212880686_init();
    work_a_1622263492_3212880686_init();
    work_a_3000740687_3212880686_init();
    std_textio_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_0014528389_2959432447_init();
    xilinxcorelib_a_1204705662_2959432447_init();
    xilinxcorelib_a_4286692035_1709443946_init();
    xilinxcorelib_a_1847405229_0543512595_init();
    xilinxcorelib_a_0349075841_3212880686_init();
    work_a_3986579722_3839623104_init();
    work_a_0128658152_3212880686_init();
    work_a_3722120054_3212880686_init();
    xilinxcorelib_a_0575267308_2959432447_init();
    xilinxcorelib_a_1568701055_2959432447_init();
    xilinxcorelib_a_1965287032_1709443946_init();
    xilinxcorelib_a_3330863843_0543512595_init();
    xilinxcorelib_a_2786517658_3212880686_init();
    work_a_3992961014_1530168645_init();
    work_a_3640966720_3212880686_init();
    work_a_1878704884_3212880686_init();
    work_a_1849206979_3212880686_init();
    work_a_1803009606_3212880686_init();
    work_a_1790301297_3212880686_init();
    work_a_1760782888_3212880686_init();
    work_a_0046335324_3212880686_init();
    work_a_1855521217_3212880686_init();
    xilinxcorelib_a_0832814546_2959432447_init();
    xilinxcorelib_a_0462128560_2959432447_init();
    xilinxcorelib_a_4168090980_1709443946_init();
    xilinxcorelib_a_0958803380_0543512595_init();
    xilinxcorelib_a_3237313519_3212880686_init();
    work_a_0948658614_3371075957_init();
    work_a_0431830435_3212880686_init();
    work_a_0024798608_2372691052_init();


    xsi_register_tops("work_a_0024798608_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
