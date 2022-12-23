<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%

  //源主表名， 源主表字段（包含四个参照项）,目标主表字段，
  //源子表名， 源子表字段，目标子表字段
	//红字 销售退货单


																								 //销售单红字开始 
    Serve.creatBillRed
    (
		    "xs_xsd",
		    "id,xsdh,''xs_xsd'',''1'',ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
		    "cz_id,czbh,czbm,czlx,ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
		    "xs_xsd_sub",
				"-1*sl,fid,chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,suilv,hsdj,-1*jshj,dj,-1*je,-1*cbje,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
				"sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,suilv,hsdj,jshj,dj,je,cbje,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl","退货"
		);

	Serve.reloadAll();
																								//销售单红字结束
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																							//采购单红字开始
	
	 Serve.creatBillRed
	 ( 
				"cg_cgd",
				"id,cgdh,''cg_cgd'',''1'',cglx,gys,gysbh,gys_id,ck,zffs,hth,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
				"cz_id,czbh,czbm,czlx,cglx,gys,gysbh,gys_id,ck,zffs,hth,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
				
				"cg_cgd_sub",
				"-1*sl,fid,chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,dj,-1*je,hsdj,-1*jshj,suilv,-1*se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
				"sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl","退货" 
	 );
	 Serve.reloadAll();
	 																						//采购单红字结束
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																							//零售单红字开始
																							
	Serve.creatBillRed
	( 
				"xs_lsd",
				"id,lsdh,''xs_lsd'',''1'',ywlx,-1*ssje,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
				"cz_id,czbh,czbm,czlx,ywlx,ssje,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
				"xs_lsd_sub",
				"-1*sl,-cbje,id,fid,chbm,chmc,ggxh,bzdw,hsl,suilv,-1*bzsl,dw,hsdj,-1*jshj,cbdj,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
				"sl,cbje,id,fid,chbm,chmc,ggxh,bzdw,hsl, suilv,  bzsl,dw,hsdj,   jshj,cbdj,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl","退货"
  );
	Serve.reloadAll();
																							//零售单红字结束
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																							//入库单红字开始
																								
	Serve.creatBillRed
	( 
				"kc_rkd",
				"id,rkdh,''kc_rkd'',''1'',ywlx,gys,gysbh,gys_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
				"cz_id,czbh,czbm,czlx,ywlx,gys,gysbh,gys_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
				"kc_rkd_sub",
				"-1*sl,fid,chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,dj,-1*je,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
				"sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl","回冲"
	
	);
	Serve.reloadAll();
																							//入库单红字结束
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																							//收款单红字开始
	
																									
	Serve.creatBillRed
	( 
				"xs_skd",
				"-1*ssje,id,skdh,''xs_skd'',''1'',xsdh,kh,khbh,kh_id,zffs,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
				"ssje,cz_id,czbh,czbm,czlx,xsdh,kh,khbh,kh_id,zffs,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
				"","","","回冲"

	
	);
	Serve.reloadAll();
	
																							//收款单红字结束
	
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																							//付款单红字开始
	
	
	Serve.creatBillRed
	(
	
			"cg_fkd",
			"-1*sfje,id,fkdh,''cg_fkd'',''1'',cgdh,gys,gysbh,gys_id,zffs,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
			"sfje,cz_id,czbh,czbm,czlx,cgdh,gys,gysbh,gys_id,zffs,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
			"","","","回冲"
	);
	Serve.reloadAll();
																						//付款单红字结束
	
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
																					//出库单红字开始
		Serve.creatBillRed
		(
			"kc_ckd",
			"id,ckdh,''kc_ckd'',''1'',ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,''1''",
			"cz_id,czbh,czbm,czlx,ywlx,kh,khbh,kh_id,ck,ywy_mc,ywy_id,ywbm_mc,ywbm_id,xt_is_red_status",
			"kc_ckd_sub",
			"-1*sl,fid,chbm,chmc,ggxh,bzdw,hsl,-1*bzsl,dw,dj,-1*je,hsdj,-1*jshj,suilv,-1*se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl",
			"sl,fid,chbm,chmc,ggxh,bzdw,hsl,bzsl,dw,dj,je,hsdj,jshj,suilv,se,ch_id,xt_cpfz_pc,xt_cpfz_scrq,xt_cpfz_sxrq,xt_cpfz_yxq,xt_cpfz_xgsx,xt_cpfz_sfbzqgl,xt_cpfz_sfpcgl","回冲"																					
		);
		Serve.reloadAll();
																						//出库单红字结束
%>
成功

 
 
