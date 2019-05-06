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
static const char *ng0 = "/home/ise/ISE/CS226_OSPF/OSPF/NeighborMachineTb.vhd";
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_17544701978858283880_3536714472(char *, char *, int , int );


static void work_a_3709278437_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 5024U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 5656);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(95, ng0);
    t2 = (t0 + 4048U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4832);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(96, ng0);
    t2 = (t0 + 5656);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 4048U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4832);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_3709278437_2372691052_p_1(char *t0)
{
    char t13[16];
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    int64 t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    int t12;
    unsigned int t14;
    unsigned char t15;
    char *t16;
    int t17;

LAB0:    t1 = (t0 + 5272U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(103, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(104, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(106, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 10.500000000000000);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 5720);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(108, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 5);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(109, ng0);
    t2 = (t0 + 5720);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(110, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 5784);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 9738);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(113, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    xsi_set_current_line(114, ng0);
    t2 = (t0 + 9746);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(115, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB28:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 9754);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(117, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB34:    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

LAB32:    xsi_set_current_line(118, ng0);
    t2 = (t0 + 9762);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(119, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB38:    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB33:    goto LAB32;

LAB35:    goto LAB33;

LAB36:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 5784);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(121, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(122, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 20);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB42:    *((char **)t1) = &&LAB43;
    goto LAB1;

LAB37:    goto LAB36;

LAB39:    goto LAB37;

LAB40:    xsi_set_current_line(124, ng0);
    t2 = (t0 + 9770);
    *((int *)t2) = 0;
    t4 = (t0 + 9774);
    *((int *)t4) = 15;
    t11 = 0;
    t12 = 15;

LAB44:    if (t11 <= t12)
        goto LAB45;

LAB47:    xsi_set_current_line(129, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB57:    *((char **)t1) = &&LAB58;
    goto LAB1;

LAB41:    goto LAB40;

LAB43:    goto LAB41;

LAB45:    xsi_set_current_line(125, ng0);
    t6 = (t0 + 4048U);
    t7 = *((char **)t6);
    t3 = *((int64 *)t7);
    t6 = (t0 + 5080);
    xsi_process_wait(t6, t3);

LAB50:    *((char **)t1) = &&LAB51;
    goto LAB1;

LAB46:    t2 = (t0 + 9770);
    t11 = *((int *)t2);
    t4 = (t0 + 9774);
    t12 = *((int *)t4);
    if (t11 == t12)
        goto LAB47;

LAB54:    t17 = (t11 + 1);
    t11 = t17;
    t6 = (t0 + 9770);
    *((int *)t6) = t11;
    goto LAB44;

LAB48:    xsi_set_current_line(126, ng0);
    t2 = (t0 + 5912);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(127, ng0);
    t2 = (t0 + 9770);
    t4 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t13, *((int *)t2), 8);
    t6 = (t13 + 12U);
    t14 = *((unsigned int *)t6);
    t14 = (t14 * 1U);
    t15 = (8U != t14);
    if (t15 == 1)
        goto LAB52;

LAB53:    t7 = (t0 + 5848);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t16 = *((char **)t10);
    memcpy(t16, t4, 8U);
    xsi_driver_first_trans_fast(t7);
    goto LAB46;

LAB49:    goto LAB48;

LAB51:    goto LAB49;

LAB52:    xsi_size_not_matching(8U, t14, 0);
    goto LAB53;

LAB55:    xsi_set_current_line(130, ng0);
    t2 = (t0 + 5912);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(131, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(132, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 100);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB61:    *((char **)t1) = &&LAB62;
    goto LAB1;

LAB56:    goto LAB55;

LAB58:    goto LAB56;

LAB59:    xsi_set_current_line(134, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(135, ng0);
    t2 = (t0 + 9778);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(136, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB65:    *((char **)t1) = &&LAB66;
    goto LAB1;

LAB60:    goto LAB59;

LAB62:    goto LAB60;

LAB63:    xsi_set_current_line(137, ng0);
    t2 = (t0 + 9786);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(138, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB69:    *((char **)t1) = &&LAB70;
    goto LAB1;

LAB64:    goto LAB63;

LAB66:    goto LAB64;

LAB67:    xsi_set_current_line(139, ng0);
    t2 = (t0 + 9794);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(140, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB73:    *((char **)t1) = &&LAB74;
    goto LAB1;

LAB68:    goto LAB67;

LAB70:    goto LAB68;

LAB71:    xsi_set_current_line(141, ng0);
    t2 = (t0 + 9802);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(142, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB77:    *((char **)t1) = &&LAB78;
    goto LAB1;

LAB72:    goto LAB71;

LAB74:    goto LAB72;

LAB75:    xsi_set_current_line(143, ng0);
    t2 = (t0 + 9810);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(144, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB81:    *((char **)t1) = &&LAB82;
    goto LAB1;

LAB76:    goto LAB75;

LAB78:    goto LAB76;

LAB79:    xsi_set_current_line(145, ng0);
    t2 = (t0 + 9818);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(146, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB85:    *((char **)t1) = &&LAB86;
    goto LAB1;

LAB80:    goto LAB79;

LAB82:    goto LAB80;

LAB83:    xsi_set_current_line(147, ng0);
    t2 = (t0 + 9826);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(148, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB89:    *((char **)t1) = &&LAB90;
    goto LAB1;

LAB84:    goto LAB83;

LAB86:    goto LAB84;

LAB87:    xsi_set_current_line(149, ng0);
    t2 = (t0 + 9834);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(150, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB93:    *((char **)t1) = &&LAB94;
    goto LAB1;

LAB88:    goto LAB87;

LAB90:    goto LAB88;

LAB91:    xsi_set_current_line(151, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(152, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(153, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 200);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB97:    *((char **)t1) = &&LAB98;
    goto LAB1;

LAB92:    goto LAB91;

LAB94:    goto LAB92;

LAB95:    xsi_set_current_line(154, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(155, ng0);
    t2 = (t0 + 9842);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(156, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB101:    *((char **)t1) = &&LAB102;
    goto LAB1;

LAB96:    goto LAB95;

LAB98:    goto LAB96;

LAB99:    xsi_set_current_line(157, ng0);
    t2 = (t0 + 9850);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(158, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB105:    *((char **)t1) = &&LAB106;
    goto LAB1;

LAB100:    goto LAB99;

LAB102:    goto LAB100;

LAB103:    xsi_set_current_line(159, ng0);
    t2 = (t0 + 9858);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(160, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB109:    *((char **)t1) = &&LAB110;
    goto LAB1;

LAB104:    goto LAB103;

LAB106:    goto LAB104;

LAB107:    xsi_set_current_line(161, ng0);
    t2 = (t0 + 9866);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(162, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB113:    *((char **)t1) = &&LAB114;
    goto LAB1;

LAB108:    goto LAB107;

LAB110:    goto LAB108;

LAB111:    xsi_set_current_line(163, ng0);
    t2 = (t0 + 9874);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(164, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB117:    *((char **)t1) = &&LAB118;
    goto LAB1;

LAB112:    goto LAB111;

LAB114:    goto LAB112;

LAB115:    xsi_set_current_line(165, ng0);
    t2 = (t0 + 9882);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(166, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB121:    *((char **)t1) = &&LAB122;
    goto LAB1;

LAB116:    goto LAB115;

LAB118:    goto LAB116;

LAB119:    xsi_set_current_line(167, ng0);
    t2 = (t0 + 9890);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(168, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB125:    *((char **)t1) = &&LAB126;
    goto LAB1;

LAB120:    goto LAB119;

LAB122:    goto LAB120;

LAB123:    xsi_set_current_line(169, ng0);
    t2 = (t0 + 9898);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(170, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB129:    *((char **)t1) = &&LAB130;
    goto LAB1;

LAB124:    goto LAB123;

LAB126:    goto LAB124;

LAB127:    xsi_set_current_line(171, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(172, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 300);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB133:    *((char **)t1) = &&LAB134;
    goto LAB1;

LAB128:    goto LAB127;

LAB130:    goto LAB128;

LAB131:    xsi_set_current_line(173, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(174, ng0);
    t2 = (t0 + 9906);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(175, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB137:    *((char **)t1) = &&LAB138;
    goto LAB1;

LAB132:    goto LAB131;

LAB134:    goto LAB132;

LAB135:    xsi_set_current_line(176, ng0);
    t2 = (t0 + 9914);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(177, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB141:    *((char **)t1) = &&LAB142;
    goto LAB1;

LAB136:    goto LAB135;

LAB138:    goto LAB136;

LAB139:    xsi_set_current_line(178, ng0);
    t2 = (t0 + 9922);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(179, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB145:    *((char **)t1) = &&LAB146;
    goto LAB1;

LAB140:    goto LAB139;

LAB142:    goto LAB140;

LAB143:    xsi_set_current_line(180, ng0);
    t2 = (t0 + 9930);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(181, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB149:    *((char **)t1) = &&LAB150;
    goto LAB1;

LAB144:    goto LAB143;

LAB146:    goto LAB144;

LAB147:    xsi_set_current_line(182, ng0);
    t2 = (t0 + 9938);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(183, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB153:    *((char **)t1) = &&LAB154;
    goto LAB1;

LAB148:    goto LAB147;

LAB150:    goto LAB148;

LAB151:    xsi_set_current_line(184, ng0);
    t2 = (t0 + 9946);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(185, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB157:    *((char **)t1) = &&LAB158;
    goto LAB1;

LAB152:    goto LAB151;

LAB154:    goto LAB152;

LAB155:    xsi_set_current_line(186, ng0);
    t2 = (t0 + 9954);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(187, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB161:    *((char **)t1) = &&LAB162;
    goto LAB1;

LAB156:    goto LAB155;

LAB158:    goto LAB156;

LAB159:    xsi_set_current_line(188, ng0);
    t2 = (t0 + 9962);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(189, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB165:    *((char **)t1) = &&LAB166;
    goto LAB1;

LAB160:    goto LAB159;

LAB162:    goto LAB160;

LAB163:    xsi_set_current_line(190, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(191, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 300);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t5);

LAB169:    *((char **)t1) = &&LAB170;
    goto LAB1;

LAB164:    goto LAB163;

LAB166:    goto LAB164;

LAB167:    xsi_set_current_line(192, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(193, ng0);
    t2 = (t0 + 9970);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(194, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB173:    *((char **)t1) = &&LAB174;
    goto LAB1;

LAB168:    goto LAB167;

LAB170:    goto LAB168;

LAB171:    xsi_set_current_line(195, ng0);
    t2 = (t0 + 9978);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(196, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB177:    *((char **)t1) = &&LAB178;
    goto LAB1;

LAB172:    goto LAB171;

LAB174:    goto LAB172;

LAB175:    xsi_set_current_line(197, ng0);
    t2 = (t0 + 9986);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(198, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB181:    *((char **)t1) = &&LAB182;
    goto LAB1;

LAB176:    goto LAB175;

LAB178:    goto LAB176;

LAB179:    xsi_set_current_line(199, ng0);
    t2 = (t0 + 9994);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(200, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB185:    *((char **)t1) = &&LAB186;
    goto LAB1;

LAB180:    goto LAB179;

LAB182:    goto LAB180;

LAB183:    xsi_set_current_line(201, ng0);
    t2 = (t0 + 10002);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(202, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB189:    *((char **)t1) = &&LAB190;
    goto LAB1;

LAB184:    goto LAB183;

LAB186:    goto LAB184;

LAB187:    xsi_set_current_line(203, ng0);
    t2 = (t0 + 10010);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(204, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB193:    *((char **)t1) = &&LAB194;
    goto LAB1;

LAB188:    goto LAB187;

LAB190:    goto LAB188;

LAB191:    xsi_set_current_line(205, ng0);
    t2 = (t0 + 10018);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(206, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB197:    *((char **)t1) = &&LAB198;
    goto LAB1;

LAB192:    goto LAB191;

LAB194:    goto LAB192;

LAB195:    xsi_set_current_line(207, ng0);
    t2 = (t0 + 10026);
    t6 = (t0 + 5848);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(208, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 5080);
    xsi_process_wait(t2, t3);

LAB201:    *((char **)t1) = &&LAB202;
    goto LAB1;

LAB196:    goto LAB195;

LAB198:    goto LAB196;

LAB199:    xsi_set_current_line(209, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(212, ng0);

LAB205:    *((char **)t1) = &&LAB206;
    goto LAB1;

LAB200:    goto LAB199;

LAB202:    goto LAB200;

LAB203:    goto LAB2;

LAB204:    goto LAB203;

LAB206:    goto LAB204;

}


extern void work_a_3709278437_2372691052_init()
{
	static char *pe[] = {(void *)work_a_3709278437_2372691052_p_0,(void *)work_a_3709278437_2372691052_p_1};
	xsi_register_didat("work_a_3709278437_2372691052", "isim/NMtestbench_isim_beh.exe.sim/work/a_3709278437_2372691052.didat");
	xsi_register_executes(pe);
}
