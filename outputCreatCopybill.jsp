<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
//Serve.creatBillCopy(source_table,target_table,source_cols,target_cols,source_sub_table
//,target_sub_table,source_sub_cols,target_sub_cols)

// 源主表名，目标主表名， 源主表字段（包含四个参照项）,目标主表字段，
//源子表名，目标子表名， 源子表字段，目标子表字段，过滤条件，按钮名称



//销售单参照销售订单生成
    Serve.creatBillCopy("xs_xsdd","xs_xsd",

    "''xs_xsdd'',id,   xsdh,''2'',xslx,zffs,shdz,shouhuoren,lxdh,kh,kh_id,khbh,jhrq,skqx,hth,bz,wsje,ysje,cbze,mlrze,ywbm_mc,ywy_mc,ywbm_id,ywy_id",
    "czbm     ,cz_id,czbh,czlx,xslx,zffs,shdz,shouhuoren,lxdh,kh,kh_id,khbh,jhrq,skqx,hth,bz,wsje,ysje,cbze,mlrze,ywbm_mc,ywy_mc,ywbm_id,ywy_id",

    "xs_xsdd_sub","xs_xsd_sub",

    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,wkdsl*hsdj,suilv,cbje,hpmlr,cbdj,ykdsl,wkdsl,zkl,wkdsl*hsdj",
    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,cbje,hpmlr,cbdj,ykdsl,sl,zkl,zqje"," 1=1 and (select count(*) from xs_xsdd_sub where fid=xs_xsdd.id and wkdsl<>0 )>0 and shzt='1' ","复制","参照销售订单生成"," 1=1 and xs_xsdd_sub.wkdsl>0 ");

//销售发票参照销售单生成
 Serve.creatBillCopy("xs_xsd","xs_fp",

    "''xs_xsd'',id,   xsdh,''2'',kh,kh_id,khbh,bz,wkpje,ywbm_mc,ywy_mc,ywbm_id,ywy_id,xsdh",
    "czbm     ,cz_id,czbh,czlx,kh,kh_id,khbh,bz,fpje,ywbm_mc,ywy_mc,ywbm_id,ywy_id,xsdh",

    "xs_xsd_sub","xs_fp_sub",

    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,wkpsl*hsdj,suilv,wkpsl",
    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,sl"," 1=1 and (select count(*) from xs_xsd_sub where fid=xs_xsd.id and wkpsl<>0 )>0 and shzt='1' ","复制","参照销售单生成");

 //采购订单参照请购单生成
 
    Serve.creatBillCopy("cg_qgd","cg_cgdd",

    "''cg_qgd'',id,   qgdh,''2'',cglx,ck,bz,ywbm_mc,ywy_mc,ywbm_id,ywy_id",
    "czbm     ,cz_id,czbh,czlx,cglx,ck,bz,ywbm_mc,ywy_mc,ywbm_id,ywy_id",

    "cg_qgd_sub","cg_cgdd_sub",

    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,wdhsl",
    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,sl"," 1=1 and (select count(*) from cg_qgd_sub where fid=cg_qgd.id and wdhsl<>0 )>0 and shzt='1' ","复制","参照请购单生成");

//采购单参照采购订单生成

 Serve.creatBillCopy("cg_cgdd","cg_cgd",

    "''cg_cgdd'',id,   cgdh,''2'',gys,gys_id,gysbh,cglx,ck,zffs,fkqx,hth,bz,ywbm_mc,ywy_mc,ywbm_id,ywy_id",
    "czbm  ,cz_id,czbh,czlx,gys,gys_id,gysbh,cglx,ck,zffs,fkqx,hth,bz,ywbm_mc,ywy_mc,ywbm_id,ywy_id",

    "cg_cgdd_sub","cg_cgd_sub",

    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,wkdsl",
    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,sl"," 1=1 and (select count(*) from cg_cgdd_sub where fid=cg_cgdd.id and wkdsl<>0 )>0 and shzt='1' ","复制","参照采购订单生成");



//采购发票参照采购单生成
 Serve.creatBillCopy("cg_cgd","cg_fp",

    "''cg_cgd'',id,   cgdh,''2'',gys,gys_id,gysbh,bz,cglx,wkpje,ywbm_mc,ywy_mc,ywbm_id,ywy_id,cgdh",
    "czbm     ,cz_id,czbh,czlx,gys,gys_id,gysbh,bz,cglx,fpje,ywbm_mc,ywy_mc,ywbm_id,ywy_id,cgdh",

    "cg_cgd_sub","cg_fp_sub",

    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,wkpsl*hsdj,suilv,wkpsl",
    "chbm,ch_id,chmc,ggxh,bzdw,dw,hsl,bzsl,hsdj,jshj,suilv,sl"," 1=1 and (select count(*) from cg_cgd_sub where fid=cg_cgd.id and wkpsl<>0 )>0 and shzt='1' ","复制","参照采购单生成");




//采购退货

             Serve.creatBillCopy("cg_cgd","cg_cgd",

    "''cg_cgd'',id,   cgdh,''2'',cglx,gys,gysbh,gys_id,ck,zffs,fkqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
    "czbm ,cz_id,czbh,czlx,cglx,gys,gysbh,gys_id,ck,zffs,fkqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "cg_cgd_sub","cg_cgd_sub",

    "chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,-1*sl,dj,-1*je,hsdj,-1*jshj,suilv,-1*se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
    "chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,sl,dj,je,hsdj,jshj,suilv,se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl"," 1=1 and shzt='1' and (select count(*) from cg_cgd_sub where sl<0 and cg_cgd.id=cg_cgd_sub.fid)=0  ","退货","采购退货");
//销售退货

             Serve.creatBillCopy("xs_xsd","xs_xsd",

    "''xs_xsd'',id,   xsdh,''2'',xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
    "czbm ,cz_id,czbh,czlx,xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "xs_xsd_sub","xs_xsd_sub",

    "chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,-1*sl,hsdj,-1*jshj,suilv,dj,-1*je,-1*se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
    "chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,sl,hsdj,jshj,suilv,dj,je,se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl"," 1=1 and shzt='1' and (select count(*) from xs_xsd_sub where sl<0 and xs_xsd.id=xs_xsd_sub.fid)=0  ","退货","销售退货");

//零售退货
             Serve.creatBillCopy("xs_lsd","xs_lsd",

    "''xs_lsd'',id,   lsdh,''2'',-1*ssje,-1*yingshouje,kahao,huiyuan,-1*jifen,hyjb,jfbl,-1*xianjin,-1*neika,-1*waika,-1*zhipiao,-1*daijinquan,-1*qt1,-1*qt2,-1*qt3,-1*qt4,-1*qt5,-1*zhaoling,xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
    "czbm ,cz_id,czbh,czlx,ssje,yingshouje,kahao,huiyuan,jifen,hyjb,jfbl,xianjin,neika,waika,zhipiao,daijinquan,qt1,qt2,qt3,qt4,qt5,zhaoling,xslx,ck,kh,khbh,shdz,shouhuoren,lxdh,kh_id,jhrq,zffs,skqx,hth,bz,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "xs_lsd_sub","xs_lsd_sub",

    "chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,-1*sl,hsdj,-1*jshj,suilv,dj,-1*je,-1*se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl,zkl",
    "chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,sl,hsdj,jshj,suilv,dj,je,se,bz,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl,zkl"," 1=1 and shzt='1' and (select count(*) from xs_lsd_sub where sl<0 and xs_lsd.id=xs_lsd_sub.fid)=0  and jiezhangzt<>'1' and (select sum(sl) from xs_lsd_sub a , xs_lsd b where a.fid=b.id and ( b.id =xs_lsd.id or b.cz_id =xs_lsd.id) )<>0","退货","零售退货");




	//-------------------------------------------------------------------------------
 //生产产品记录 复制到 领料单  
    Serve.creatBillCopy("view_scan_wlmain","scan_lld",

    "''scan_sccpdj'',sccpjlid,cpph,''2'',  bmck,ch_id    ,chbm	 ,chmc	 ,ck_id	 ,cpph	 ,dw	 ,ggxh	 ,scsl	 ,wldh ",
    "czbm           ,cz_id   ,czbh,czlx ,  bmck,cp_ch_id ,cp_chbm,cp_chmc,ck	 ,cpph	 ,cp_dw	 ,cp_ggxh,scsl	 ,wldh ", 
    "view_scan_wlmain_sub","scan_lld_sub",

   "ch_id ,chbm	,chmc	,dw	,ggxh	,bombl	,wlsl ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl,row_index",
   "ch_id ,chbm	,chmc	,dw	,ggxh	,bombl	,sl   ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl,row_index" ,
   " shzt='1' ","领料","参照配料单生成");

 //生产产品记录 复制到 补料单 
    Serve.creatBillCopy("view_scan_wlmain","scan_bld",

    "''scan_sccpdj'',sccpjlid,cpph,''2'',  bmck,ch_id    ,chbm	 ,chmc	 ,ck_id	 ,cpph	 ,dw	 ,ggxh	 ,scsl	 ,wldh ",
    "czbm           ,cz_id   ,czbh,czlx ,  bmck,cp_ch_id ,cp_chbm,cp_chmc,ck	 ,cpph	 ,cp_dw	 ,cp_ggxh,scsl	 ,wldh ", 

    "view_scan_wlmain_sub","scan_bld_sub",

   "ch_id ,chbm	,chmc	,dw	,ggxh	,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl",
   "ch_id ,chbm	,chmc	,dw	,ggxh	,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl",
   " shzt='1' ","补料","参照配料单生成");

 //生产产品记录 复制到 退料单 
    Serve.creatBillCopy("view_scan_wlmain","scan_tld",

    "''scan_sccpdj'',sccpjlid,cpph,''2'',  bmck,ch_id    ,chbm	 ,chmc	 ,ck_id	 ,cpph	 ,dw	 ,ggxh	 ,scsl	 ,wldh ",
    "czbm           ,cz_id   ,czbh,czlx ,  bmck,cp_ch_id ,cp_chbm,cp_chmc,ck	 ,cpph	 ,cp_dw	 ,cp_ggxh,scsl	 ,wldh ", 

    "view_scan_wlmain_sub","scan_tld_sub",

   "ch_id ,chbm	,chmc	,dw	,ggxh	 ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl",
   "ch_id ,chbm	,chmc	,dw	,ggxh	 ,xt_cpfz_sfbzqgl ,xt_cpfz_sfpcgl",
   " shzt='1' ","退料","参照配料单生成");

 //生产单 复制到  产品完工登记
    Serve.creatBillCopy("scan_sccpdj","scan_cpwgdj",

    "''scan_sccpdj'',id      ,cpph,''2'',cpph,  ch_id    ,chbm	 ,chmc	 ,dw	 ,ggxh	 ,wldh ",
    "czbm           ,cz_id   ,czbh,czlx ,cpph,  ch_id    ,chbm	 ,chmc	 ,dw	 ,ggxh	 ,wldh ",

    "","",

   "",
   "",
   " shzt = '1' and cpph not in (select cpph from scan_cpwgdj) ","完工登记","参照生产订单生成");


//-------------------------------------------------------------------------------




Serve.creatBillCopy(
	"kc_rkd","kc_rkd",

  "ywlx,gys,gysbh,gys_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
  	"ywlx,gys,gysbh,gys_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "kc_rkd_sub","kc_rkd_sub",

   "sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl", 
   "sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl"," 1=1 and (select count(*) from kc_rkd_sub where kc_rkd.id=kc_rkd_sub.fid and kc_rkd_sub.sl>0)>0 ","复制","参照入库单生成");
   

			
     		 
    Serve.creatBillCopy(
	"kc_ckd","kc_ckd",

   "ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id",
  "ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id",

    "kc_ckd_sub","kc_ckd_sub",

   "sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl", 
   "sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl"," 1=1 and (select count(*) from kc_ckd_sub where kc_ckd.id=kc_ckd_sub.fid and kc_ckd_sub.sl>0)>0 ","复制","参照出库单生成");
   
//销售退货

             Serve.creatBillCopy("demo_txl","demo_txl",

    "''demo_txl'',id,   bh,''2'',xm",
    "czbm ,cz_id,czbh,czlx,xm",

    "","",

    "",
    ""," 1=1  ","克隆","可选通讯录");





%>

 
 
ok.