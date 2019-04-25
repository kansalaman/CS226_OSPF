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
static const char *ng0 = "/home/ansh/Desktop/Academics/Semester 4/CS 226/CS226_OSPF/OSPF/helloalive.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

char *ieee_p_3620187407_sub_1496620905533721142_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_3581208258_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 6712);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(63, ng0);
    t7 = (t0 + 3592U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t7 = (t0 + 6808);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = t9;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 2792U);
    t3 = *((char **)t2);
    t2 = (t0 + 6872);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 16U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 2952U);
    t3 = *((char **)t2);
    t2 = (t0 + 6936);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 9U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 3272U);
    t3 = *((char **)t2);
    t2 = (t0 + 7000);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 8U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB5:    t2 = (t0 + 1952U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

}

static void work_a_3581208258_3212880686_p_1(char *t0)
{
    char t12[16];
    char t13[16];
    char t26[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    int t27;
    char *t28;
    static char *nl0[] = {&&LAB3, &&LAB4};

LAB0:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 6728);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(74, ng0);
    t4 = (t0 + 2312U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 11816U);
    t4 = (t0 + 5168U);
    t5 = *((char **)t4);
    t4 = (t0 + 11880U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t4);
    if (t3 != 0)
        goto LAB10;

LAB11:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 11816U);
    t4 = (t0 + 13505);
    t8 = (t13 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 7;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t14 = (7 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t15;
    t9 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t12, t2, t1, t4, t13);
    t10 = (t12 + 12U);
    t15 = *((unsigned int *)t10);
    t16 = (1U * t15);
    t3 = (16U != t16);
    if (t3 == 1)
        goto LAB14;

LAB15:    t11 = (t0 + 7256);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t9, 16U);
    xsi_driver_first_trans_fast(t11);

LAB6:    goto LAB2;

LAB4:    xsi_set_current_line(86, ng0);
    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 11832U);
    t4 = (t0 + 5168U);
    t5 = *((char **)t4);
    t4 = (t0 + 11880U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t4);
    if (t3 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 11832U);
    t4 = (t0 + 13513);
    t8 = (t13 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 7;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t14 = (7 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t15;
    t9 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t12, t2, t1, t4, t13);
    t10 = (t12 + 12U);
    t15 = *((unsigned int *)t10);
    t16 = (1U * t15);
    t3 = (9U != t16);
    if (t3 == 1)
        goto LAB19;

LAB20:    t11 = (t0 + 7192);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t9, 9U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(92, ng0);
    t1 = (t0 + 3912U);
    t2 = *((char **)t1);
    t15 = (543 - 535);
    t16 = (t15 * 1U);
    t21 = (0 + t16);
    t1 = (t2 + t21);
    t4 = (t0 + 3912U);
    t5 = *((char **)t4);
    t22 = (543 - 543);
    t23 = (t22 * 1U);
    t24 = (0 + t23);
    t4 = (t5 + t24);
    t9 = ((IEEE_P_2592010699) + 4000);
    t10 = (t13 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 535;
    t11 = (t10 + 4U);
    *((int *)t11) = 0;
    t11 = (t10 + 8U);
    *((int *)t11) = -1;
    t14 = (0 - 535);
    t25 = (t14 * -1);
    t25 = (t25 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t25;
    t11 = (t26 + 0U);
    t17 = (t11 + 0U);
    *((int *)t17) = 543;
    t17 = (t11 + 4U);
    *((int *)t17) = 536;
    t17 = (t11 + 8U);
    *((int *)t17) = -1;
    t27 = (536 - 543);
    t25 = (t27 * -1);
    t25 = (t25 + 1);
    t17 = (t11 + 12U);
    *((unsigned int *)t17) = t25;
    t8 = xsi_base_array_concat(t8, t12, t9, (char)97, t1, t13, (char)97, t4, t26, (char)101);
    t25 = (536U + 8U);
    t3 = (544U != t25);
    if (t3 == 1)
        goto LAB21;

LAB22:    t17 = (t0 + 7320);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t28 = *((char **)t20);
    memcpy(t28, t8, 544U);
    xsi_driver_first_trans_fast(t17);
    xsi_set_current_line(93, ng0);
    t1 = (t0 + 3912U);
    t2 = *((char **)t1);
    t15 = (543 - 543);
    t16 = (t15 * 1U);
    t21 = (0 + t16);
    t1 = (t2 + t21);
    t4 = (t0 + 7384);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 8U);
    xsi_driver_first_trans_fast(t4);

LAB17:    goto LAB2;

LAB5:    xsi_set_current_line(75, ng0);
    t4 = (t0 + 7064);
    t8 = (t4 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t4);
    xsi_set_current_line(76, ng0);
    t1 = (t0 + 7128);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(77, ng0);
    t1 = (t0 + 4208U);
    t2 = *((char **)t1);
    t1 = (t0 + 11720U);
    t4 = (t0 + 13489);
    t8 = (t13 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 7;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t14 = (7 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t15;
    t9 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t12, t2, t1, t4, t13);
    t10 = (t12 + 12U);
    t15 = *((unsigned int *)t10);
    t16 = (1U * t15);
    t3 = (9U != t16);
    if (t3 == 1)
        goto LAB8;

LAB9:    t11 = (t0 + 7192);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t9, 9U);
    xsi_driver_first_trans_fast(t11);
    goto LAB6;

LAB8:    xsi_size_not_matching(9U, t16, 0);
    goto LAB9;

LAB10:    xsi_set_current_line(79, ng0);
    t8 = (t0 + 7128);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t17 = *((char **)t11);
    *((unsigned char *)t17) = (unsigned char)1;
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(80, ng0);
    t1 = (t0 + 4208U);
    t2 = *((char **)t1);
    t1 = (t0 + 11720U);
    t4 = (t0 + 13497);
    t8 = (t13 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 7;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t14 = (7 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t15;
    t9 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t12, t2, t1, t4, t13);
    t10 = (t12 + 12U);
    t15 = *((unsigned int *)t10);
    t16 = (1U * t15);
    t3 = (9U != t16);
    if (t3 == 1)
        goto LAB12;

LAB13:    t11 = (t0 + 7192);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t9, 9U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(81, ng0);
    t1 = (t0 + 7064);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

LAB12:    xsi_size_not_matching(9U, t16, 0);
    goto LAB13;

LAB14:    xsi_size_not_matching(16U, t16, 0);
    goto LAB15;

LAB16:    xsi_set_current_line(87, ng0);
    t8 = (t0 + 7128);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t17 = *((char **)t11);
    *((unsigned char *)t17) = (unsigned char)0;
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t1 = (t0 + 7256);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(89, ng0);
    t1 = (t0 + 7064);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB17;

LAB19:    xsi_size_not_matching(9U, t16, 0);
    goto LAB20;

LAB21:    xsi_size_not_matching(544U, t25, 0);
    goto LAB22;

}


extern void work_a_3581208258_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3581208258_3212880686_p_0,(void *)work_a_3581208258_3212880686_p_1};
	xsi_register_didat("work_a_3581208258_3212880686", "isim/tb_helloalive_isim_beh.exe.sim/work/a_3581208258_3212880686.didat");
	xsi_register_executes(pe);
}
