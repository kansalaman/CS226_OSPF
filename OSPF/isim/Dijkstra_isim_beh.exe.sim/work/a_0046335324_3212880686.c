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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/ISE/CS226_OSPF/OSPF/Comparator.vhd";



static void work_a_0046335324_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(211, ng0);

LAB3:    t1 = (t0 + 9960U);
    t2 = *((char **)t1);
    t3 = (63 * 6);
    t4 = (t3 - 1);
    t5 = (377 - t4);
    t6 = (t5 * 1U);
    t7 = (0 + t6);
    t1 = (t2 + t7);
    t8 = (t0 + 26256);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);

LAB2:    t13 = (t0 + 26160);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0046335324_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(212, ng0);

LAB3:    t1 = (t0 + 10120U);
    t2 = *((char **)t1);
    t3 = (63 * 6);
    t4 = (t3 - 1);
    t5 = (377 - t4);
    t6 = (t5 * 1U);
    t7 = (0 + t6);
    t1 = (t2 + t7);
    t8 = (t0 + 26320);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);

LAB2:    t13 = (t0 + 26176);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0046335324_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0046335324_3212880686_p_0,(void *)work_a_0046335324_3212880686_p_1};
	xsi_register_didat("work_a_0046335324_3212880686", "isim/Dijkstra_isim_beh.exe.sim/work/a_0046335324_3212880686.didat");
	xsi_register_executes(pe);
}
