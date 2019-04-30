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
static const char *ng0 = "/home/aman/Desktop/IITB/CS226/project_ospf/CS226_OSPF/OSPF/message_parser.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_3620187407;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void work_a_1183831083_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(27, ng0);

LAB3:    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t1 = (t0 + 10208U);
    t3 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t2, t1);
    t4 = (t0 + 5752);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t3;
    xsi_driver_first_trans_fast(t4);

LAB2:    t9 = (t0 + 5640);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1183831083_3212880686_p_1(char *t0)
{
    unsigned char t1;
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
    char *t12;
    int t13;
    unsigned char t14;
    int t15;
    unsigned char t16;

LAB0:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1312U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 5656);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(33, ng0);
    t4 = (t0 + 1032U);
    t8 = *((char **)t4);
    t4 = (t0 + 5816);
    t9 = (t4 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 8U);
    xsi_driver_first_trans_fast_port(t4);
    xsi_set_current_line(34, ng0);
    t2 = (t0 + 3112U);
    t4 = *((char **)t2);
    t13 = *((int *)t4);
    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t2 = (t5 + 0);
    *((int *)t2) = t13;
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 3432U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (t0 + 3848U);
    t5 = *((char **)t2);
    t2 = (t5 + 0);
    *((unsigned char *)t2) = t1;
    xsi_set_current_line(36, ng0);
    t2 = (t0 + 3112U);
    t4 = *((char **)t2);
    t13 = *((int *)t4);
    t2 = (t0 + 5880);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t13;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(37, ng0);
    t2 = (t0 + 3432U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (t0 + 5944);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t1;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(41, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)0);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = (t0 + 3848U);
    t5 = *((char **)t2);
    t7 = *((unsigned char *)t5);
    t14 = (t7 == (unsigned char)1);
    t1 = t14;

LAB13:    if (t1 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t13 = *((int *)t4);
    t15 = (t13 + 1);
    t2 = (t0 + 6008);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t15;
    xsi_driver_first_trans_fast(t2);

LAB9:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)3);
    if (t7 == 1)
        goto LAB20;

LAB21:    t3 = (unsigned char)0;

LAB22:    if (t3 == 1)
        goto LAB17;

LAB18:    t1 = (unsigned char)0;

LAB19:    if (t1 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 6072);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);

LAB15:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)2);
    if (t7 == 1)
        goto LAB29;

LAB30:    t3 = (unsigned char)0;

LAB31:    if (t3 == 1)
        goto LAB26;

LAB27:    t1 = (unsigned char)0;

LAB28:    if (t1 != 0)
        goto LAB23;

LAB25:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 6136);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);

LAB24:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)2);
    if (t6 == 1)
        goto LAB35;

LAB36:    t1 = (unsigned char)0;

LAB37:    if (t1 != 0)
        goto LAB32;

LAB34:
LAB33:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)2);
    if (t6 == 1)
        goto LAB41;

LAB42:    t1 = (unsigned char)0;

LAB43:    if (t1 != 0)
        goto LAB38;

LAB40:    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)2);
    if (t6 == 1)
        goto LAB46;

LAB47:    t1 = (unsigned char)0;

LAB48:    if (t1 != 0)
        goto LAB44;

LAB45:
LAB39:    xsi_set_current_line(71, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB49;

LAB51:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 6328);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);

LAB50:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 3848U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)4);
    if (t3 != 0)
        goto LAB52;

LAB54:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 6392);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);

LAB53:    goto LAB3;

LAB5:    t4 = (t0 + 1352U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 6008);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((int *)t11) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB11:    t1 = (unsigned char)1;
    goto LAB13;

LAB14:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 6072);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB15;

LAB17:    t2 = (t0 + 3728U);
    t8 = *((char **)t2);
    t15 = *((int *)t8);
    t16 = (t15 <= 24);
    t1 = t16;
    goto LAB19;

LAB20:    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t14 = (t13 >= 21);
    t3 = t14;
    goto LAB22;

LAB23:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 6136);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB24;

LAB26:    t2 = (t0 + 3728U);
    t8 = *((char **)t2);
    t15 = *((int *)t8);
    t16 = (t15 <= 8);
    t1 = t16;
    goto LAB28;

LAB29:    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t14 = (t13 >= 5);
    t3 = t14;
    goto LAB31;

LAB32:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 1032U);
    t8 = *((char **)t2);
    t2 = (t0 + 6200);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 8U);
    xsi_driver_first_trans_fast(t2);
    goto LAB33;

LAB35:    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t7 = (t13 == 2);
    t1 = t7;
    goto LAB37;

LAB38:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 1032U);
    t8 = *((char **)t2);
    t2 = (t0 + 6264);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 8U);
    xsi_driver_first_trans_delta(t2, 0U, 8U, 0LL);
    goto LAB39;

LAB41:    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t7 = (t13 == 3);
    t1 = t7;
    goto LAB43;

LAB44:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 1032U);
    t8 = *((char **)t2);
    t2 = (t0 + 6264);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 8U);
    xsi_driver_first_trans_delta(t2, 8U, 8U, 0LL);
    goto LAB39;

LAB46:    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t7 = (t13 == 4);
    t1 = t7;
    goto LAB48;

LAB49:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 6328);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB50;

LAB52:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 6392);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB53;

}

static void work_a_1183831083_3212880686_p_2(char *t0)
{
    char t14[16];
    char t18[16];
    char t27[16];
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
    int t12;
    int t13;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    int t21;
    unsigned char t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned char t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    static char *nl0[] = {&&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7};

LAB0:    xsi_set_current_line(89, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 5672);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(91, ng0);
    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(95, ng0);
    t1 = (t0 + 6456);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(96, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);

LAB9:    goto LAB2;

LAB4:    xsi_set_current_line(100, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t3 = (t12 == 20);
    if (t3 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(104, ng0);
    t1 = (t0 + 6456);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(105, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t13 = (t12 + 1);
    t1 = (t0 + 6520);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((int *)t9) = t13;
    xsi_driver_first_trans_fast(t1);

LAB12:    goto LAB2;

LAB5:    xsi_set_current_line(109, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t3 = (t12 == 24);
    if (t3 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(124, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6456);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(125, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t13 = (t12 + 1);
    t1 = (t0 + 6520);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((int *)t9) = t13;
    xsi_driver_first_trans_fast(t1);

LAB15:    goto LAB2;

LAB6:    xsi_set_current_line(129, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t6 = (t3 == (unsigned char)2);
    if (t6 != 0)
        goto LAB31;

LAB33:    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t1 = (t0 + 2632U);
    t4 = *((char **)t1);
    t13 = *((int *)t4);
    t3 = (t12 == t13);
    if (t3 != 0)
        goto LAB34;

LAB35:    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t3 = (t12 == 24);
    if (t3 != 0)
        goto LAB36;

LAB37:    xsi_set_current_line(139, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6456);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(140, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t12 = *((int *)t2);
    t13 = (t12 + 1);
    t1 = (t0 + 6520);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((int *)t9) = t13;
    xsi_driver_first_trans_fast(t1);

LAB32:    goto LAB2;

LAB7:    xsi_set_current_line(144, ng0);
    t1 = (t0 + 6456);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(145, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB8:    xsi_set_current_line(92, ng0);
    t4 = (t0 + 6456);
    t8 = (t4 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)1;
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(93, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB9;

LAB11:    xsi_set_current_line(101, ng0);
    t1 = (t0 + 6456);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(102, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB12;

LAB14:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 2312U);
    t4 = *((char **)t1);
    t1 = (t0 + 10192U);
    t5 = (t0 + 10293);
    t9 = (t14 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 0;
    t10 = (t9 + 4U);
    *((int *)t10) = 7;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t13 = (7 - 0);
    t15 = (t13 * 1);
    t15 = (t15 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t15;
    t7 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t4, t1, t5, t14);
    if (t7 == 1)
        goto LAB20;

LAB21:    t10 = (t0 + 2312U);
    t11 = *((char **)t10);
    t10 = (t0 + 10192U);
    t16 = (t0 + 10301);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 0;
    t20 = (t19 + 4U);
    *((int *)t20) = 7;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (7 - 0);
    t15 = (t21 * 1);
    t15 = (t15 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t15;
    t22 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t11, t10, t16, t18);
    t6 = t22;

LAB22:    if (t6 != 0)
        goto LAB17;

LAB19:    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 10192U);
    t4 = (t0 + 10309);
    t8 = (t14 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 7;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t12 = (7 - 0);
    t15 = (t12 * 1);
    t15 = (t15 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t15;
    t7 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t4, t14);
    if (t7 == 1)
        goto LAB28;

LAB29:    t9 = (t0 + 2312U);
    t10 = *((char **)t9);
    t9 = (t0 + 10192U);
    t11 = (t0 + 10317);
    t17 = (t18 + 0U);
    t19 = (t17 + 0U);
    *((int *)t19) = 0;
    t19 = (t17 + 4U);
    *((int *)t19) = 7;
    t19 = (t17 + 8U);
    *((int *)t19) = 1;
    t13 = (7 - 0);
    t15 = (t13 * 1);
    t15 = (t15 + 1);
    t19 = (t17 + 12U);
    *((unsigned int *)t19) = t15;
    t22 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t10, t9, t11, t18);
    t6 = t22;

LAB30:    if (t6 == 1)
        goto LAB25;

LAB26:    t19 = (t0 + 2312U);
    t20 = *((char **)t19);
    t19 = (t0 + 10192U);
    t23 = (t0 + 10325);
    t25 = (t27 + 0U);
    t26 = (t25 + 0U);
    *((int *)t26) = 0;
    t26 = (t25 + 4U);
    *((int *)t26) = 7;
    t26 = (t25 + 8U);
    *((int *)t26) = 1;
    t21 = (7 - 0);
    t15 = (t21 * 1);
    t15 = (t15 + 1);
    t26 = (t25 + 12U);
    *((unsigned int *)t26) = t15;
    t28 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t20, t19, t23, t27);
    t3 = t28;

LAB27:    if (t3 != 0)
        goto LAB23;

LAB24:    xsi_set_current_line(119, ng0);
    t1 = (t0 + 6456);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((unsigned char *)t8) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(120, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);

LAB18:    goto LAB15;

LAB17:    xsi_set_current_line(111, ng0);
    t20 = (t0 + 6456);
    t23 = (t20 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = (unsigned char)3;
    xsi_driver_first_trans_fast(t20);
    xsi_set_current_line(112, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB18;

LAB20:    t6 = (unsigned char)1;
    goto LAB22;

LAB23:    xsi_set_current_line(115, ng0);
    t26 = (t0 + 6456);
    t29 = (t26 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    *((unsigned char *)t32) = (unsigned char)4;
    xsi_driver_first_trans_fast(t26);
    xsi_set_current_line(116, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB18;

LAB25:    t3 = (unsigned char)1;
    goto LAB27;

LAB28:    t6 = (unsigned char)1;
    goto LAB30;

LAB31:    xsi_set_current_line(130, ng0);
    t1 = (t0 + 6456);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(131, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB32;

LAB34:    xsi_set_current_line(133, ng0);
    t1 = (t0 + 6456);
    t5 = (t1 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(134, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB32;

LAB36:    xsi_set_current_line(136, ng0);
    t1 = (t0 + 3272U);
    t4 = *((char **)t1);
    t6 = *((unsigned char *)t4);
    t1 = (t0 + 6456);
    t5 = (t1 + 56U);
    t8 = *((char **)t5);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(137, ng0);
    t1 = (t0 + 6520);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t8 = *((char **)t5);
    *((int *)t8) = 21;
    xsi_driver_first_trans_fast(t1);
    goto LAB32;

}


extern void work_a_1183831083_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1183831083_3212880686_p_0,(void *)work_a_1183831083_3212880686_p_1,(void *)work_a_1183831083_3212880686_p_2};
	xsi_register_didat("work_a_1183831083_3212880686", "isim/parser_tb_isim_beh.exe.sim/work/a_1183831083_3212880686.didat");
	xsi_register_executes(pe);
}
