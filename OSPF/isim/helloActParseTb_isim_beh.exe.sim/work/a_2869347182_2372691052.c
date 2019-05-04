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
static const char *ng0 = "/home/yash20/isefiles/CS226_OSPF/OSPF/helloActParseTb.vhd";
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_17544701978858283880_3536714472(char *, char *, int , int );


static void work_a_2869347182_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 7264U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(214, ng0);
    t2 = (t0 + 7896);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(215, ng0);
    t2 = (t0 + 6288U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 7072);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(216, ng0);
    t2 = (t0 + 7896);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(217, ng0);
    t2 = (t0 + 6288U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 7072);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2869347182_2372691052_p_1(char *t0)
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

LAB0:    t1 = (t0 + 7512U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(225, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(227, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 10);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t5);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(228, ng0);
    t2 = (t0 + 7960);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(229, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 5);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t5);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(230, ng0);
    t2 = (t0 + 7960);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(231, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(232, ng0);
    t2 = (t0 + 8024);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(233, ng0);
    t2 = (t0 + 13515);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(234, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    xsi_set_current_line(235, ng0);
    t2 = (t0 + 13523);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(236, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    xsi_set_current_line(237, ng0);
    t2 = (t0 + 13531);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(238, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB28:    xsi_set_current_line(239, ng0);
    t2 = (t0 + 13539);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(240, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB34:    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

LAB32:    xsi_set_current_line(241, ng0);
    t2 = (t0 + 8024);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(242, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(243, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 20);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t5);

LAB38:    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB33:    goto LAB32;

LAB35:    goto LAB33;

LAB36:    xsi_set_current_line(245, ng0);
    t2 = (t0 + 13547);
    *((int *)t2) = 0;
    t4 = (t0 + 13551);
    *((int *)t4) = 15;
    t11 = 0;
    t12 = 15;

LAB40:    if (t11 <= t12)
        goto LAB41;

LAB43:    xsi_set_current_line(250, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB53:    *((char **)t1) = &&LAB54;
    goto LAB1;

LAB37:    goto LAB36;

LAB39:    goto LAB37;

LAB41:    xsi_set_current_line(246, ng0);
    t6 = (t0 + 6288U);
    t7 = *((char **)t6);
    t3 = *((int64 *)t7);
    t6 = (t0 + 7320);
    xsi_process_wait(t6, t3);

LAB46:    *((char **)t1) = &&LAB47;
    goto LAB1;

LAB42:    t2 = (t0 + 13547);
    t11 = *((int *)t2);
    t4 = (t0 + 13551);
    t12 = *((int *)t4);
    if (t11 == t12)
        goto LAB43;

LAB50:    t17 = (t11 + 1);
    t11 = t17;
    t6 = (t0 + 13547);
    *((int *)t6) = t11;
    goto LAB40;

LAB44:    xsi_set_current_line(247, ng0);
    t2 = (t0 + 8152);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(248, ng0);
    t2 = (t0 + 13547);
    t4 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t13, *((int *)t2), 8);
    t6 = (t13 + 12U);
    t14 = *((unsigned int *)t6);
    t14 = (t14 * 1U);
    t15 = (8U != t14);
    if (t15 == 1)
        goto LAB48;

LAB49:    t7 = (t0 + 8088);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t16 = *((char **)t10);
    memcpy(t16, t4, 8U);
    xsi_driver_first_trans_fast(t7);
    goto LAB42;

LAB45:    goto LAB44;

LAB47:    goto LAB45;

LAB48:    xsi_size_not_matching(8U, t14, 0);
    goto LAB49;

LAB51:    xsi_set_current_line(251, ng0);
    t2 = (t0 + 8152);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(252, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(253, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 20);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t5);

LAB57:    *((char **)t1) = &&LAB58;
    goto LAB1;

LAB52:    goto LAB51;

LAB54:    goto LAB52;

LAB55:    xsi_set_current_line(255, ng0);
    t2 = (t0 + 8216);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(256, ng0);
    t2 = (t0 + 13555);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(257, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB61:    *((char **)t1) = &&LAB62;
    goto LAB1;

LAB56:    goto LAB55;

LAB58:    goto LAB56;

LAB59:    xsi_set_current_line(258, ng0);
    t2 = (t0 + 13563);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(259, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB65:    *((char **)t1) = &&LAB66;
    goto LAB1;

LAB60:    goto LAB59;

LAB62:    goto LAB60;

LAB63:    xsi_set_current_line(260, ng0);
    t2 = (t0 + 13571);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(261, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB69:    *((char **)t1) = &&LAB70;
    goto LAB1;

LAB64:    goto LAB63;

LAB66:    goto LAB64;

LAB67:    xsi_set_current_line(262, ng0);
    t2 = (t0 + 13579);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(263, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB73:    *((char **)t1) = &&LAB74;
    goto LAB1;

LAB68:    goto LAB67;

LAB70:    goto LAB68;

LAB71:    xsi_set_current_line(264, ng0);
    t2 = (t0 + 13587);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(265, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB77:    *((char **)t1) = &&LAB78;
    goto LAB1;

LAB72:    goto LAB71;

LAB74:    goto LAB72;

LAB75:    xsi_set_current_line(266, ng0);
    t2 = (t0 + 13595);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(267, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB81:    *((char **)t1) = &&LAB82;
    goto LAB1;

LAB76:    goto LAB75;

LAB78:    goto LAB76;

LAB79:    xsi_set_current_line(268, ng0);
    t2 = (t0 + 13603);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(269, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB85:    *((char **)t1) = &&LAB86;
    goto LAB1;

LAB80:    goto LAB79;

LAB82:    goto LAB80;

LAB83:    xsi_set_current_line(270, ng0);
    t2 = (t0 + 13611);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(271, ng0);
    t2 = (t0 + 6288U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 7320);
    xsi_process_wait(t2, t3);

LAB89:    *((char **)t1) = &&LAB90;
    goto LAB1;

LAB84:    goto LAB83;

LAB86:    goto LAB84;

LAB87:    xsi_set_current_line(272, ng0);
    t2 = (t0 + 8216);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(273, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t6 = (t0 + 8088);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(276, ng0);

LAB93:    *((char **)t1) = &&LAB94;
    goto LAB1;

LAB88:    goto LAB87;

LAB90:    goto LAB88;

LAB91:    goto LAB2;

LAB92:    goto LAB91;

LAB94:    goto LAB92;

}


extern void work_a_2869347182_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2869347182_2372691052_p_0,(void *)work_a_2869347182_2372691052_p_1};
	xsi_register_didat("work_a_2869347182_2372691052", "isim/helloActParseTb_isim_beh.exe.sim/work/a_2869347182_2372691052.didat");
	xsi_register_executes(pe);
}
