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
static const char *ng0 = "/home/ansh/Desktop/Academics/Semester 4/CS 226/Project/CS226_OSPF/OSPF/lsraction_tb.vhd";
extern char *IEEE_P_2592010699;



static void work_a_3491373293_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 4864U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(135, ng0);
    t2 = (t0 + 5496);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(136, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4672);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(137, ng0);
    t2 = (t0 + 5496);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(138, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4672);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_3491373293_2372691052_p_1(char *t0)
{
    char t7[16];
    char t9[16];
    char t14[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t10;
    char *t11;
    int t12;
    unsigned int t13;
    char *t15;
    int t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    int64 t22;
    int64 t23;

LAB0:    t1 = (t0 + 5112U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(146, ng0);
    t2 = (t0 + 5560);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(147, ng0);
    t2 = (t0 + 9874);
    t4 = (t0 + 9882);
    t8 = ((IEEE_P_2592010699) + 4000);
    t10 = (t9 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 0;
    t11 = (t10 + 4U);
    *((int *)t11) = 7;
    t11 = (t10 + 8U);
    *((int *)t11) = 1;
    t12 = (7 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t13;
    t11 = (t14 + 0U);
    t15 = (t11 + 0U);
    *((int *)t15) = 0;
    t15 = (t11 + 4U);
    *((int *)t15) = 7;
    t15 = (t11 + 8U);
    *((int *)t15) = 1;
    t16 = (7 - 0);
    t13 = (t16 * 1);
    t13 = (t13 + 1);
    t15 = (t11 + 12U);
    *((unsigned int *)t15) = t13;
    t6 = xsi_base_array_concat(t6, t7, t8, (char)97, t2, t9, (char)97, t4, t14, (char)101);
    t13 = (8U + 8U);
    t17 = (16U != t13);
    if (t17 == 1)
        goto LAB4;

LAB5:    t15 = (t0 + 5624);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_fast(t15);
    xsi_set_current_line(148, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t22 = *((int64 *)t3);
    t2 = (t0 + 4920);
    xsi_process_wait(t2, t22);

LAB8:    *((char **)t1) = &&LAB9;

LAB1:    return;
LAB4:    xsi_size_not_matching(16U, t13, 0);
    goto LAB5;

LAB6:    xsi_set_current_line(149, ng0);
    t2 = (t0 + 5560);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(150, ng0);
    t2 = (t0 + 9890);
    t4 = (t0 + 9898);
    t8 = ((IEEE_P_2592010699) + 4000);
    t10 = (t9 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 0;
    t11 = (t10 + 4U);
    *((int *)t11) = 7;
    t11 = (t10 + 8U);
    *((int *)t11) = 1;
    t12 = (7 - 0);
    t13 = (t12 * 1);
    t13 = (t13 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t13;
    t11 = (t14 + 0U);
    t15 = (t11 + 0U);
    *((int *)t15) = 0;
    t15 = (t11 + 4U);
    *((int *)t15) = 7;
    t15 = (t11 + 8U);
    *((int *)t15) = 1;
    t16 = (7 - 0);
    t13 = (t16 * 1);
    t13 = (t13 + 1);
    t15 = (t11 + 12U);
    *((unsigned int *)t15) = t13;
    t6 = xsi_base_array_concat(t6, t7, t8, (char)97, t2, t9, (char)97, t4, t14, (char)101);
    t13 = (8U + 8U);
    t17 = (16U != t13);
    if (t17 == 1)
        goto LAB10;

LAB11:    t15 = (t0 + 5624);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_fast(t15);
    xsi_set_current_line(151, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t22 = *((int64 *)t3);
    t23 = (3 * t22);
    t2 = (t0 + 4920);
    xsi_process_wait(t2, t23);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB7:    goto LAB6;

LAB9:    goto LAB7;

LAB10:    xsi_size_not_matching(16U, t13, 0);
    goto LAB11;

LAB12:    xsi_set_current_line(152, ng0);
    t2 = (t0 + 5688);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(153, ng0);
    t2 = (t0 + 9906);
    t4 = (t0 + 5752);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(154, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t22 = *((int64 *)t3);
    t2 = (t0 + 4920);
    xsi_process_wait(t2, t22);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(155, ng0);
    t2 = (t0 + 5688);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(156, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t22 = *((int64 *)t3);
    t23 = (t22 * 7);
    t2 = (t0 + 4920);
    xsi_process_wait(t2, t23);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    xsi_set_current_line(157, ng0);
    t2 = (t0 + 9914);
    t4 = (t0 + 5752);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(158, ng0);
    t2 = (t0 + 3888U);
    t3 = *((char **)t2);
    t22 = *((int64 *)t3);
    t23 = (t22 * 4);
    t2 = (t0 + 4920);
    xsi_process_wait(t2, t23);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    xsi_set_current_line(159, ng0);
    t2 = (t0 + 9922);
    t4 = (t0 + 5752);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(161, ng0);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB28:    goto LAB2;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

}


extern void work_a_3491373293_2372691052_init()
{
	static char *pe[] = {(void *)work_a_3491373293_2372691052_p_0,(void *)work_a_3491373293_2372691052_p_1};
	xsi_register_didat("work_a_3491373293_2372691052", "isim/lsraction_tb_isim_beh.exe.sim/work/a_3491373293_2372691052.didat");
	xsi_register_executes(pe);
}
