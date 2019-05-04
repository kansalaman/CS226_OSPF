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
static const char *ng0 = "/home/ansh/Desktop/Academics/Semester 4/CS 226/Project/CS226_OSPF/OSPF/helloalive.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

char *ieee_p_3620187407_sub_1496620905533649268_3965413181(char *, char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_1496620905533721142_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_0556930266_3212880686_p_0(char *t0)
{
    char t14[16];
    char t15[16];
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
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    unsigned int t24;
    int t25;
    int t26;
    int t27;
    unsigned int t28;
    unsigned int t29;
    static char *nl0[] = {&&LAB9, &&LAB10, &&LAB11};

LAB0:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 6192);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(81, ng0);
    t7 = (t0 + 2632U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t7 = (t0 + 6288);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = t9;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t2 = (t0 + 6352);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 16U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 6416);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 9U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(84, ng0);
    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (char *)((nl0) + t1);
    goto **((char **)t2);

LAB5:    t2 = (t0 + 1312U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    goto LAB3;

LAB9:    xsi_set_current_line(86, ng0);
    t7 = (t0 + 1832U);
    t8 = *((char **)t7);
    t7 = (t0 + 11312U);
    t10 = (t0 + 4408U);
    t11 = *((char **)t10);
    t10 = (t0 + 11376U);
    t12 = (t0 + 12576);
    t16 = (t15 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 0;
    t17 = (t16 + 4U);
    *((int *)t17) = 7;
    t17 = (t16 + 8U);
    *((int *)t17) = 1;
    t18 = (7 - 0);
    t19 = (t18 * 1);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = ieee_p_3620187407_sub_1496620905533649268_3965413181(IEEE_P_3620187407, t14, t11, t10, t12, t15);
    t4 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t8, t7, t17, t14);
    if (t4 != 0)
        goto LAB12;

LAB14:
LAB13:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 6480);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB8;

LAB10:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 6480);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2792U);
    t3 = *((char **)t2);
    t2 = (t0 + 4528U);
    t7 = *((char **)t2);
    t18 = *((int *)t7);
    t19 = (543 - t18);
    t2 = (t0 + 4648U);
    t8 = *((char **)t2);
    t22 = *((int *)t8);
    xsi_vhdl_check_range_of_slice(543, 0, -1, t18, t22, -1);
    t23 = (t19 * 1U);
    t24 = (0 + t23);
    t2 = (t3 + t24);
    t10 = (t0 + 4528U);
    t11 = *((char **)t10);
    t25 = *((int *)t11);
    t10 = (t0 + 4648U);
    t12 = *((char **)t10);
    t26 = *((int *)t12);
    t27 = (t26 - t25);
    t28 = (t27 * -1);
    t28 = (t28 + 1);
    t29 = (1U * t28);
    t1 = (8U != t29);
    if (t1 == 1)
        goto LAB15;

LAB16:    t10 = (t0 + 6544);
    t13 = (t10 + 56U);
    t16 = *((char **)t13);
    t17 = (t16 + 56U);
    t20 = *((char **)t17);
    memcpy(t20, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(95, ng0);
    t2 = (t0 + 4528U);
    t3 = *((char **)t2);
    t18 = *((int *)t3);
    t22 = (t18 - 8);
    t2 = (t0 + 4528U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t22;
    xsi_set_current_line(96, ng0);
    t2 = (t0 + 4648U);
    t3 = *((char **)t2);
    t18 = *((int *)t3);
    t22 = (t18 - 8);
    t2 = (t0 + 4648U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t22;
    goto LAB8;

LAB11:    xsi_set_current_line(99, ng0);
    t2 = (t0 + 4528U);
    t3 = *((char **)t2);
    t18 = *((int *)t3);
    t2 = (t0 + 4528U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t18;
    goto LAB8;

LAB12:    xsi_set_current_line(87, ng0);
    t20 = (t0 + 4528U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    *((int *)t20) = 543;
    xsi_set_current_line(88, ng0);
    t2 = (t0 + 4648U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 536;
    goto LAB13;

LAB15:    xsi_size_not_matching(8U, t29, 0);
    goto LAB16;

}

static void work_a_0556930266_3212880686_p_1(char *t0)
{
    char t7[16];
    char t13[16];
    char t18[16];
    char t23[16];
    char t28[16];
    char t33[16];
    char t38[16];
    char t43[16];
    char t48[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned char t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    int t66;
    static char *nl0[] = {&&LAB4, &&LAB5, &&LAB3};

LAB0:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 6208);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(108, ng0);
    t4 = (t0 + 3808U);
    t5 = *((char **)t4);
    t4 = (t0 + 3928U);
    t6 = *((char **)t4);
    t8 = ((IEEE_P_2592010699) + 4000);
    t9 = (t0 + 11264U);
    t10 = (t0 + 11280U);
    t4 = xsi_base_array_concat(t4, t7, t8, (char)97, t5, t9, (char)97, t6, t10, (char)101);
    t11 = (t0 + 4048U);
    t12 = *((char **)t11);
    t14 = ((IEEE_P_2592010699) + 4000);
    t15 = (t0 + 11296U);
    t11 = xsi_base_array_concat(t11, t13, t14, (char)97, t4, t7, (char)97, t12, t15, (char)101);
    t16 = (t0 + 3328U);
    t17 = *((char **)t16);
    t19 = ((IEEE_P_2592010699) + 4000);
    t20 = (t0 + 11216U);
    t16 = xsi_base_array_concat(t16, t18, t19, (char)97, t11, t13, (char)97, t17, t20, (char)101);
    t21 = (t0 + 3448U);
    t22 = *((char **)t21);
    t24 = ((IEEE_P_2592010699) + 4000);
    t25 = (t0 + 11232U);
    t21 = xsi_base_array_concat(t21, t23, t24, (char)97, t16, t18, (char)97, t22, t25, (char)101);
    t26 = (t0 + 3568U);
    t27 = *((char **)t26);
    t29 = ((IEEE_P_2592010699) + 4000);
    t30 = (t0 + 11232U);
    t26 = xsi_base_array_concat(t26, t28, t29, (char)97, t21, t23, (char)97, t27, t30, (char)101);
    t31 = (t0 + 4168U);
    t32 = *((char **)t31);
    t34 = ((IEEE_P_2592010699) + 4000);
    t35 = (t0 + 11344U);
    t31 = xsi_base_array_concat(t31, t33, t34, (char)97, t26, t28, (char)97, t32, t35, (char)101);
    t36 = (t0 + 4288U);
    t37 = *((char **)t36);
    t39 = ((IEEE_P_2592010699) + 4000);
    t40 = (t0 + 11360U);
    t36 = xsi_base_array_concat(t36, t38, t39, (char)97, t31, t33, (char)97, t37, t40, (char)101);
    t41 = (t0 + 4288U);
    t42 = *((char **)t41);
    t44 = ((IEEE_P_2592010699) + 4000);
    t45 = (t0 + 11360U);
    t41 = xsi_base_array_concat(t41, t43, t44, (char)97, t36, t38, (char)97, t42, t45, (char)101);
    t46 = (t0 + 1192U);
    t47 = *((char **)t46);
    t49 = ((IEEE_P_2592010699) + 4000);
    t50 = (t0 + 11184U);
    t46 = xsi_base_array_concat(t46, t48, t49, (char)97, t41, t43, (char)97, t47, t50, (char)101);
    t51 = (160U + 192U);
    t52 = (t51 + 32U);
    t53 = (t52 + 16U);
    t54 = (t53 + 8U);
    t55 = (t54 + 8U);
    t56 = (t55 + 32U);
    t57 = (t56 + 32U);
    t58 = (t57 + 32U);
    t59 = (t58 + 32U);
    t60 = (544U != t59);
    if (t60 == 1)
        goto LAB6;

LAB7:    t61 = (t0 + 6608);
    t62 = (t61 + 56U);
    t63 = *((char **)t62);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    memcpy(t65, t46, 544U);
    xsi_driver_first_trans_fast(t61);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 6672);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(111, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 11312U);
    t4 = (t0 + 12584);
    t6 = (t13 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 7;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t66 = (7 - 0);
    t51 = (t66 * 1);
    t51 = (t51 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t51;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t7, t2, t1, t4, t13);
    t9 = (t7 + 12U);
    t51 = *((unsigned int *)t9);
    t52 = (1U * t51);
    t3 = (16U != t52);
    if (t3 == 1)
        goto LAB8;

LAB9:    t10 = (t0 + 6736);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 16U);
    xsi_driver_first_trans_fast(t10);
    goto LAB2;

LAB4:    xsi_set_current_line(113, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 6608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    memcpy(t8, t2, 544U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(114, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t60 = (t3 == (unsigned char)3);
    if (t60 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 11312U);
    t4 = (t0 + 4408U);
    t5 = *((char **)t4);
    t4 = (t0 + 11376U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t4);
    if (t3 != 0)
        goto LAB15;

LAB16:    xsi_set_current_line(123, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 11312U);
    t4 = (t0 + 12608);
    t6 = (t13 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 7;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t66 = (7 - 0);
    t51 = (t66 * 1);
    t51 = (t51 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t51;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t7, t2, t1, t4, t13);
    t9 = (t7 + 12U);
    t51 = *((unsigned int *)t9);
    t52 = (1U * t51);
    t3 = (16U != t52);
    if (t3 == 1)
        goto LAB19;

LAB20:    t10 = (t0 + 6736);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 16U);
    xsi_driver_first_trans_fast(t10);

LAB11:    goto LAB2;

LAB5:    xsi_set_current_line(126, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 6608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    memcpy(t8, t2, 544U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(127, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 11328U);
    t4 = (t0 + 4408U);
    t5 = *((char **)t4);
    t4 = (t0 + 11376U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t4);
    if (t3 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(132, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 11328U);
    t4 = (t0 + 12616);
    t6 = (t13 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 7;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t66 = (7 - 0);
    t51 = (t66 * 1);
    t51 = (t51 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t51;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t7, t2, t1, t4, t13);
    t9 = (t7 + 12U);
    t51 = *((unsigned int *)t9);
    t52 = (1U * t51);
    t3 = (9U != t52);
    if (t3 == 1)
        goto LAB24;

LAB25:    t10 = (t0 + 6800);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 9U);
    xsi_driver_first_trans_fast(t10);

LAB22:    goto LAB2;

LAB6:    xsi_size_not_matching(544U, t59, 0);
    goto LAB7;

LAB8:    xsi_size_not_matching(16U, t52, 0);
    goto LAB9;

LAB10:    xsi_set_current_line(116, ng0);
    t1 = (t0 + 6672);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    *((unsigned char *)t8) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(117, ng0);
    t1 = (t0 + 3208U);
    t2 = *((char **)t1);
    t1 = (t0 + 11200U);
    t4 = (t0 + 12592);
    t6 = (t13 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 7;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t66 = (7 - 0);
    t51 = (t66 * 1);
    t51 = (t51 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t51;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t7, t2, t1, t4, t13);
    t9 = (t7 + 12U);
    t51 = *((unsigned int *)t9);
    t52 = (1U * t51);
    t3 = (9U != t52);
    if (t3 == 1)
        goto LAB13;

LAB14:    t10 = (t0 + 6800);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 9U);
    xsi_driver_first_trans_fast(t10);
    goto LAB11;

LAB13:    xsi_size_not_matching(9U, t52, 0);
    goto LAB14;

LAB15:    xsi_set_current_line(119, ng0);
    t6 = (t0 + 6672);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)1;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(120, ng0);
    t1 = (t0 + 3208U);
    t2 = *((char **)t1);
    t1 = (t0 + 11200U);
    t4 = (t0 + 12600);
    t6 = (t13 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 7;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t66 = (7 - 0);
    t51 = (t66 * 1);
    t51 = (t51 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t51;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t7, t2, t1, t4, t13);
    t9 = (t7 + 12U);
    t51 = *((unsigned int *)t9);
    t52 = (1U * t51);
    t3 = (9U != t52);
    if (t3 == 1)
        goto LAB17;

LAB18:    t10 = (t0 + 6800);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t8, 9U);
    xsi_driver_first_trans_fast(t10);
    goto LAB11;

LAB17:    xsi_size_not_matching(9U, t52, 0);
    goto LAB18;

LAB19:    xsi_size_not_matching(16U, t52, 0);
    goto LAB20;

LAB21:    xsi_set_current_line(128, ng0);
    t6 = (t0 + 6672);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)0;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(129, ng0);
    t1 = (t0 + 3688U);
    t2 = *((char **)t1);
    t1 = (t0 + 6736);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    goto LAB22;

LAB24:    xsi_size_not_matching(9U, t52, 0);
    goto LAB25;

}


extern void work_a_0556930266_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0556930266_3212880686_p_0,(void *)work_a_0556930266_3212880686_p_1};
	xsi_register_didat("work_a_0556930266_3212880686", "isim/tb_helloalive_isim_beh.exe.sim/work/a_0556930266_3212880686.didat");
	xsi_register_executes(pe);
}
