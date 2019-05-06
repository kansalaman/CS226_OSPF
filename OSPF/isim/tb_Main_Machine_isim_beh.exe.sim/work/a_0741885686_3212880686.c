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
static const char *ng0 = "/home/ise/ISE/CS226_OSPF/OSPF/lsr_gen.vhd";



static void work_a_0741885686_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(79, ng0);

LAB3:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 6288);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0741885686_3212880686_p_1(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    int t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    unsigned char t19;
    int t20;
    unsigned char t21;
    int t22;
    int t23;
    char *t24;

LAB0:    xsi_set_current_line(93, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 6304);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(94, ng0);
    t7 = (t0 + 3432U);
    t8 = *((char **)t7);
    t9 = *((int *)t8);
    t7 = (t0 + 4128U);
    t10 = *((char **)t7);
    t7 = (t10 + 0);
    *((int *)t7) = t9;
    xsi_set_current_line(95, ng0);
    t2 = (t0 + 2952U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 4248U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((unsigned char *)t2) = t1;
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 2952U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 6480);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t1;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 3432U);
    t3 = *((char **)t2);
    t9 = *((int *)t3);
    t2 = (t0 + 6544);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    *((int *)t11) = t9;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(102, ng0);
    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)2);
    if (t4 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB13;

LAB14:    t1 = (unsigned char)0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB18;

LAB19:    t1 = (unsigned char)0;

LAB20:    if (t1 != 0)
        goto LAB16;

LAB17:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB23;

LAB24:    t1 = (unsigned char)0;

LAB25:    if (t1 != 0)
        goto LAB21;

LAB22:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB28;

LAB29:    t1 = (unsigned char)0;

LAB30:    if (t1 != 0)
        goto LAB26;

LAB27:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB33;

LAB34:    t1 = (unsigned char)0;

LAB35:    if (t1 != 0)
        goto LAB31;

LAB32:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB38;

LAB39:    t1 = (unsigned char)0;

LAB40:    if (t1 != 0)
        goto LAB36;

LAB37:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB43;

LAB44:    t1 = (unsigned char)0;

LAB45:    if (t1 != 0)
        goto LAB41;

LAB42:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB48;

LAB49:    t1 = (unsigned char)0;

LAB50:    if (t1 != 0)
        goto LAB46;

LAB47:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t5 = *((unsigned char *)t3);
    t6 = (t5 == (unsigned char)3);
    if (t6 == 1)
        goto LAB56;

LAB57:    t4 = (unsigned char)0;

LAB58:    if (t4 == 1)
        goto LAB53;

LAB54:    t1 = (unsigned char)0;

LAB55:    if (t1 != 0)
        goto LAB51;

LAB52:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t5 = *((unsigned char *)t3);
    t6 = (t5 == (unsigned char)4);
    if (t6 == 1)
        goto LAB64;

LAB65:    t4 = (unsigned char)0;

LAB66:    if (t4 == 1)
        goto LAB61;

LAB62:    t1 = (unsigned char)0;

LAB63:    if (t1 != 0)
        goto LAB59;

LAB60:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)4);
    if (t5 == 1)
        goto LAB69;

LAB70:    t1 = (unsigned char)0;

LAB71:    if (t1 != 0)
        goto LAB67;

LAB68:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t5 = *((unsigned char *)t3);
    t6 = (t5 == (unsigned char)4);
    if (t6 == 1)
        goto LAB77;

LAB78:    t4 = (unsigned char)0;

LAB79:    if (t4 == 1)
        goto LAB74;

LAB75:    t1 = (unsigned char)0;

LAB76:    if (t1 != 0)
        goto LAB72;

LAB73:    xsi_set_current_line(142, ng0);
    t2 = (t0 + 11025);
    t7 = (t0 + 6608);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 8U);
    xsi_driver_first_trans_fast_port(t7);
    xsi_set_current_line(143, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);

LAB9:    xsi_set_current_line(153, ng0);
    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)1);
    if (t4 != 0)
        goto LAB80;

LAB82:    xsi_set_current_line(156, ng0);
    t2 = (t0 + 6736);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB81:    xsi_set_current_line(159, ng0);
    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)0);
    if (t4 != 0)
        goto LAB83;

LAB85:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)1);
    if (t5 == 1)
        goto LAB88;

LAB89:    t1 = (unsigned char)0;

LAB90:    if (t1 != 0)
        goto LAB86;

LAB87:    t2 = (t0 + 4248U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)1);
    if (t5 == 1)
        goto LAB93;

LAB94:    t1 = (unsigned char)0;

LAB95:    if (t1 != 0)
        goto LAB91;

LAB92:    xsi_set_current_line(166, ng0);
    t2 = (t0 + 3112U);
    t3 = *((char **)t2);
    t9 = *((int *)t3);
    t20 = (t9 + 1);
    t2 = (t0 + 6800);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    *((int *)t11) = t20;
    xsi_driver_first_trans_fast(t2);

LAB84:    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(103, ng0);
    t2 = (t0 + 10841);
    t8 = (t0 + 6608);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 8U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB11:    xsi_set_current_line(106, ng0);
    t2 = (t0 + 10849);
    t10 = (t0 + 6608);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(107, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB13:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 1);
    t1 = t6;
    goto LAB15;

LAB16:    xsi_set_current_line(109, ng0);
    t2 = (t0 + 10857);
    t10 = (t0 + 6608);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(110, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB18:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 2);
    t1 = t6;
    goto LAB20;

LAB21:    xsi_set_current_line(112, ng0);
    t2 = (t0 + 10865);
    t10 = (t0 + 6608);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(113, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB23:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 3);
    t1 = t6;
    goto LAB25;

LAB26:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 10873);
    t10 = (t0 + 6608);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(116, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB28:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 4);
    t1 = t6;
    goto LAB30;

LAB31:    xsi_set_current_line(118, ng0);
    t2 = (t0 + 10881);
    t15 = (31 - 31);
    t16 = (t15 * 1U);
    t17 = (0 + t16);
    t10 = (t2 + t17);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t10, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(119, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB33:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 5);
    t1 = t6;
    goto LAB35;

LAB36:    xsi_set_current_line(121, ng0);
    t2 = (t0 + 10913);
    t15 = (31 - 23);
    t16 = (t15 * 1U);
    t17 = (0 + t16);
    t10 = (t2 + t17);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t10, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(122, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB38:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 6);
    t1 = t6;
    goto LAB40;

LAB41:    xsi_set_current_line(124, ng0);
    t2 = (t0 + 10945);
    t15 = (31 - 15);
    t16 = (t15 * 1U);
    t17 = (0 + t16);
    t10 = (t2 + t17);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t10, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(125, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB43:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 7);
    t1 = t6;
    goto LAB45;

LAB46:    xsi_set_current_line(127, ng0);
    t2 = (t0 + 10977);
    t15 = (31 - 7);
    t16 = (t15 * 1U);
    t17 = (0 + t16);
    t10 = (t2 + t17);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t10, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(128, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB48:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 8);
    t1 = t6;
    goto LAB50;

LAB51:    xsi_set_current_line(130, ng0);
    t2 = (t0 + 11009);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t2, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(131, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB53:    t2 = (t0 + 4128U);
    t8 = *((char **)t2);
    t20 = *((int *)t8);
    t21 = (t20 < 25);
    t1 = t21;
    goto LAB55;

LAB56:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t19 = (t9 > 8);
    t4 = t19;
    goto LAB58;

LAB59:    xsi_set_current_line(133, ng0);
    t2 = (t0 + 11017);
    t11 = (t0 + 6608);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t2, 8U);
    xsi_driver_first_trans_fast_port(t11);
    xsi_set_current_line(134, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB61:    t2 = (t0 + 4128U);
    t8 = *((char **)t2);
    t20 = *((int *)t8);
    t21 = (t20 < 4);
    t1 = t21;
    goto LAB63;

LAB64:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t19 = (t9 > 0);
    t4 = t19;
    goto LAB66;

LAB67:    xsi_set_current_line(136, ng0);
    t2 = (t0 + 2152U);
    t8 = *((char **)t2);
    t20 = (4 - 0);
    t15 = (t20 * 1);
    t16 = (8U * t15);
    t17 = (0 + t16);
    t2 = (t8 + t17);
    t10 = (t0 + 6608);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 8U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(137, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB69:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 4);
    t1 = t6;
    goto LAB71;

LAB72:    xsi_set_current_line(139, ng0);
    t2 = (t0 + 2152U);
    t10 = *((char **)t2);
    t2 = (t0 + 4128U);
    t11 = *((char **)t2);
    t22 = *((int *)t11);
    t23 = (t22 - 0);
    t15 = (t23 * 1);
    xsi_vhdl_check_range_of_index(0, 20, 1, t22);
    t16 = (8U * t15);
    t17 = (0 + t16);
    t2 = (t10 + t17);
    t12 = (t0 + 6608);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t24 = *((char **)t18);
    memcpy(t24, t2, 8U);
    xsi_driver_first_trans_fast_port(t12);
    xsi_set_current_line(140, ng0);
    t2 = (t0 + 6672);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB9;

LAB74:    t2 = (t0 + 4128U);
    t8 = *((char **)t2);
    t20 = *((int *)t8);
    t21 = (t20 < 13);
    t1 = t21;
    goto LAB76;

LAB77:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t19 = (t9 > 4);
    t4 = t19;
    goto LAB79;

LAB80:    xsi_set_current_line(154, ng0);
    t2 = (t0 + 6736);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB81;

LAB83:    xsi_set_current_line(160, ng0);
    t2 = (t0 + 6800);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    *((int *)t11) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB84;

LAB86:    xsi_set_current_line(162, ng0);
    t2 = (t0 + 6800);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((int *)t12) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB84;

LAB88:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 1);
    t1 = t6;
    goto LAB90;

LAB91:    xsi_set_current_line(164, ng0);
    t2 = (t0 + 6800);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((int *)t12) = 0;
    xsi_driver_first_trans_fast(t2);
    goto LAB84;

LAB93:    t2 = (t0 + 4128U);
    t7 = *((char **)t2);
    t9 = *((int *)t7);
    t6 = (t9 == 2);
    t1 = t6;
    goto LAB95;

}

static void work_a_0741885686_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    int t8;
    int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(176, ng0);
    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 < 20);
    if (t4 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 6320);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(177, ng0);
    t1 = (t0 + 2312U);
    t5 = *((char **)t1);
    t1 = (t0 + 3112U);
    t6 = *((char **)t1);
    t7 = *((int *)t6);
    t8 = (t7 + 1);
    t9 = (t8 - 0);
    t10 = (t9 * 1);
    t11 = (8U * t10);
    t12 = (0U + t11);
    t1 = (t0 + 6864);
    t13 = (t1 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t5, 8U);
    xsi_driver_first_trans_delta(t1, t12, 8U, 0LL);
    goto LAB3;

}

static void work_a_0741885686_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    int t20;
    int t21;
    static char *nl0[] = {&&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7};

LAB0:    xsi_set_current_line(183, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 6336);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(185, ng0);
    t5 = (t0 + 2632U);
    t6 = *((char **)t5);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    if (t8 == 1)
        goto LAB12;

LAB13:    t4 = (unsigned char)0;

LAB14:    if (t4 != 0)
        goto LAB9;

LAB11:    xsi_set_current_line(189, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(190, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t1);

LAB10:    goto LAB2;

LAB4:    xsi_set_current_line(194, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t3 = (t20 == 20);
    if (t3 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(198, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(199, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t21 = (t20 + 1);
    t1 = (t0 + 6992);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t21;
    xsi_driver_first_trans_fast(t1);

LAB22:    goto LAB2;

LAB5:    xsi_set_current_line(203, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t3 = (t20 == 20);
    if (t3 != 0)
        goto LAB24;

LAB26:    xsi_set_current_line(207, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(208, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t21 = (t20 + 1);
    t1 = (t0 + 6992);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t21;
    xsi_driver_first_trans_fast(t1);

LAB25:    goto LAB2;

LAB6:    xsi_set_current_line(212, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t3 = (t20 == 24);
    if (t3 != 0)
        goto LAB27;

LAB29:    xsi_set_current_line(216, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(217, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t21 = (t20 + 1);
    t1 = (t0 + 6992);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t21;
    xsi_driver_first_trans_fast(t1);

LAB28:    goto LAB2;

LAB7:    xsi_set_current_line(223, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t3 = (t20 == 12);
    if (t3 != 0)
        goto LAB30;

LAB32:    xsi_set_current_line(227, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(228, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t20 = *((int *)t2);
    t21 = (t20 + 1);
    t1 = (t0 + 6992);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t21;
    xsi_driver_first_trans_fast(t1);

LAB31:    goto LAB2;

LAB8:    xsi_set_current_line(232, ng0);
    goto LAB2;

LAB9:    xsi_set_current_line(186, ng0);
    t15 = (t0 + 6928);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)1;
    xsi_driver_first_trans_fast(t15);
    xsi_set_current_line(187, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB12:    t5 = (t0 + 1992U);
    t9 = *((char **)t5);
    t5 = (t0 + 11033);
    t11 = 1;
    if (3U == 3U)
        goto LAB15;

LAB16:    t11 = 0;

LAB17:    t4 = t11;
    goto LAB14;

LAB15:    t12 = 0;

LAB18:    if (t12 < 3U)
        goto LAB19;
    else
        goto LAB17;

LAB19:    t13 = (t9 + t12);
    t14 = (t5 + t12);
    if (*((unsigned char *)t13) != *((unsigned char *)t14))
        goto LAB16;

LAB20:    t12 = (t12 + 1);
    goto LAB18;

LAB21:    xsi_set_current_line(195, ng0);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(196, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB22;

LAB24:    xsi_set_current_line(204, ng0);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(205, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB25;

LAB27:    xsi_set_current_line(213, ng0);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(214, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB28;

LAB30:    xsi_set_current_line(224, ng0);
    t1 = (t0 + 6928);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(225, ng0);
    t1 = (t0 + 6992);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB31;

}


extern void work_a_0741885686_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0741885686_3212880686_p_0,(void *)work_a_0741885686_3212880686_p_1,(void *)work_a_0741885686_3212880686_p_2,(void *)work_a_0741885686_3212880686_p_3};
	xsi_register_didat("work_a_0741885686_3212880686", "isim/tb_Main_Machine_isim_beh.exe.sim/work/a_0741885686_3212880686.didat");
	xsi_register_executes(pe);
}
