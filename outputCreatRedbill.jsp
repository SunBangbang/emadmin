<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
	//红字 采购发票
	//所有的红字单据，都有一个隐含逻辑，把需要进行是否红字标志的检查字段，
	//写在复制的第一个字段，系统自动检查，如果，不存在，系统报告错误
    Serve.creatBillRed("cg_fp",

    "-1*fpje,fplb,cglx,gys,gys_id,fpdw,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,''cg_fp'',id,   fpbh,''1''",
	"fpje   ,fplb,cglx,gys,gys_id,fpdw,ywbm_mc,ywy_mc,ywbm_id,ywy_id,bz,czbm ,cz_id,czbh,czlx",

    "cg_fp_sub",

   "chbm,chmc,ggxh,bzdw,-1*bzsl,dw,-1*sl,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz,hsl,ch_id",
   "chbm,chmc,ggxh,bzdw,bzsl   ,dw,sl,dj,je,suilv,hsdj,se,jshj,bz,hsl,ch_id");
%>


<%
    //红字 销售发票
    Serve.creatBillRed(
    "xs_fp",

    "-1*fpje,xslx	,kh_id	,fpdw		,fplb	,kh	,bz,   ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''xs_fp''  ,id    ,fpbh, ''1''",
    "fpje	,xslx	,kh_id	,fpdw		,fplb	,kh	,bz,   ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "xs_fp_sub",

   "chbm,chmc,ggxh,bzdw,-1*bzsl,dw,-1*sl,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz,hsl,ch_id",
   "chbm,chmc,ggxh,bzdw,bzsl   ,dw,sl,dj,je,suilv,hsdj,se,jshj,bz,hsl,ch_id"
   );
%>

<%
	//红字 到货单
    Serve.creatBillRed(
	"cg_dhd",

    "fkfs,fyfs,dhzt,bz,tzrq,gys,cglx,gys_id,ck,skqx,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  ''cg_dhd'', id    ,   dhdh,''1''",
    "fkfs,fyfs,dhzt,bz,tzrq,gys,cglx,gys_id,ck,skqx,jsfs,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  czbm ,      cz_id ,   czbh,czlx",

    "cg_dhd_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz ,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",   
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,dj,je   ,suilv,hsdj,se   ,jshj   ,bz ,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx"   
   );
%>


<%
    //红字 销售发货单
    Serve.creatBillRed(
    "xs_fhd",

    "kh	,xslx	,kh_id	,ck	,dhrq	,skqx	,jsfs	,fkfs	,fwdz	,fyfs	,bz	,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''xs_fhd''  ,id    ,fhdh, ''1''",
    "kh	,xslx	,kh_id	,ck	,dhrq	,skqx	,jsfs	,fkfs	,fwdz	,fyfs	,bz	,   ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "xs_fhd_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,dj,je   ,suilv,hsdj,se   ,jshj   ,bz,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx"
   );
%>


<%
    //红字 入库单
    Serve.creatBillRed(
    "kc_rkd",

    "ywlx	,gys	,gys_id	,ck	,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''kc_rkd''  ,id    ,rkdh, ''1''",
    "ywlx	,gys	,gys_id	,ck	,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "kc_rkd_sub",

   
   " -1*sl ,chbm, chmc , ggxh , bzdw , -1*bzsl , dw , dj , -1*je , bz , hsl , ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",
   " sl    ,chbm, chmc , ggxh , bzdw , bzsl    , dw , dj , je    , bz , hsl , ch_id ,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx"
   );
%>


<%
    //红字 出库单
    Serve.creatBillRed(
    "kc_ckd",

    "ywlx	,kh	,kh_id	,ck	,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''kc_ckd''  ,id    ,ckdh, ''1''",
    "ywlx	,kh	,kh_id	,ck	,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "kc_ckd_sub",

   
   " -1*sl ,chbm, chmc , ggxh , bzdw , -1*bzsl , dw , dj , -1*je , bz , hsl , ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",
   " sl    ,chbm, chmc , ggxh , bzdw , bzsl    , dw , dj , je , bz , hsl ,    ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx "
   );
%>


<%
    //红字 应付单
    Serve.creatBillRed(
    "sf_yfd",

    "-1*wsje ,cglx ,gys ,gys_id ,-1*se ,-1*jshj ,fkqx ,jsfs ,fkfs ,sfkp ,zy ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''sf_yfd''  ,id    ,yfdh, ''1''",
    "wsje   ,cglx ,gys ,gys_id ,se ,jshj ,fkqx ,jsfs ,fkfs ,sfkp ,zy ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "",   
   "",
   ""
   );
%>

	
<%
    //红字 应收单
    Serve.creatBillRed(
    "sf_ysd",

    "-1*wsje ,xslx ,kh ,kh_id ,-1*se ,-1*jshj ,skqx ,jsfs ,fkfs ,sfkp ,zy ,bz,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''sf_ysd''  ,id    ,ysdh, ''1''",
    "wsje    ,xslx ,kh ,kh_id ,se    ,jshj    ,skqx ,jsfs ,fkfs ,sfkp ,zy ,bz,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "",   
   "",
   ""
   );
%>


<%
    //红字 付款单
    Serve.creatBillRed(
    "sf_fkd",

    "-1*je,fklx ,gys ,gys_id ,jsfs ,jszh ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''sf_fkd''  ,id    ,fkdh, ''1''",
    "je   ,fklx ,gys ,gys_id ,jsfs ,jszh ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "",   
   "",
   ""
   );
%>

<%
    //红字 收款单
    Serve.creatBillRed(
    "sf_skd",

    "-1*je ,sklx ,kh ,kh_id ,jsfs ,jszh ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   ''sf_skd''  ,id    ,skdh, ''1''",
    "je    ,sklx ,kh ,kh_id ,jsfs ,jszh ,bz ,    ywbm_mc,ywy_mc,ywbm_id,ywy_id,   czbm       ,cz_id ,czbh, czlx ",

    "",   
   "",
   ""
   );
%>


<%
	//红字 委托代销结算单
    Serve.creatBillRed(
	"xs_wtdx_js",

    "kh	,xslx	,kh_id	,ck	,skqx	,jsfs	,fkfs	,bz	,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  ''xs_wtdx_js'', id    ,   jsdh,''1''",
    "kh	,xslx	,kh_id	,ck	,skqx	,jsfs	,fkfs	,bz	,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  czbm ,      cz_id ,   czbh,czlx",

    "xs_wtdx_js_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,-1*sl,dj,-1*je,suilv,hsdj,-1*se,-1*jshj,bz ,hsl,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx",   
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,dj,je   ,suilv,hsdj,se   ,jshj   ,bz ,hsl      ,ch_id,xt_cpfz_pc ,xt_cpfz_scrq ,xt_cpfz_sxrq ,xt_cpfz_yxq ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl ,xt_cpfz_xgsx "   
   );
%>





<%
	//红字 记帐凭证
    Serve.creatBillRed(
	"cw_jzpz",

    "pzlb,pzbh,fdjs,bz,  ''cw_jzpz'', id    ,   pzbh,''1''",
    "pzlb,pzbh,fdjs,bz,  czbm ,      cz_id ,   czbh,czlx",

    "cw_jzpz_sub",

   "-1*jfje,zy,kmmc,-1*dfje,-1*wbjfje,-1*wbdfje,biz,huil,jshl,gys,gys_id,kh,kh_id,bm,bm_id,gr,gr_id,xm,xm_id,xgsx,jsfs,ph,fsrq,sfyhz,kmbm,sfbmhs,sfgrwl,sfkhwl,sfgyswl,sfxmhs,zsfs,dfkm",   
   "jfje,zy,kmmc,dfje,wbjfje,wbdfje,biz,huil,jshl,gys,gys_id,kh,kh_id,bm,bm_id,gr,gr_id,xm,xm_id,xgsx,jsfs,ph,fsrq,sfyhz,kmbm,sfbmhs,sfgrwl,sfkhwl,sfgyswl,sfxmhs,zsfs,dfkm "   
   );
%>


<%
 
	//红字 委托代销调整单
    Serve.creatBillRed(
	"xs_wtdx_tzd",

    "kh	,khbh	,kh_id	,bz	,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  ''xs_wtdx_tzd'', id    ,   tzdh,''1''",
    "kh	,khbh	,kh_id	,bz	,ywbm_mc,ywy_mc,ywbm_id,ywy_id,  czbm ,      cz_id ,   czbh,czlx",

    "xs_wtdx_tzd_sub",

   "-1*sl,chbm,chmc,ggxh,bzdw,-1*bzsl,dw,-1*sl,dj,-1*je,bz ,hsl,ch_id",   
   "sl   ,chbm,chmc,ggxh,bzdw,bzsl   ,dw,sl,dj,je   ,bz ,hsl      ,ch_id"   
   );
%>


 
