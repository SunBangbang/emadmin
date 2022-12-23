<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%



//=销售部分=======================================================================
 
 //应收单 制单
//-------------------------------------------------------------------------------

Serve.creatYwzdTemplate(
 			"分公司发货",// title            ,     
			"sf_ysd,cw_kh_fgsdz ,xt_bm",// ywb_name         ,     
			"sf_ysd.ysdh",// djh_col_name     ,     
			"sf_ysd.djrq",// rq_col_name      ,     
			" sf_ysd.shzt = ''1'' and sf_ysd.cwzdbz<>''1''  and sf_ysd.gbzt <> ''1'' and sf_ysd.kh =  cw_kh_fgsdz.kh and cw_kh_fgsdz.cwbm = xt_bm.id ",// filter           ,     
			"''转'',sf_ysd.id,sf_ysd.ysdh,''sf_ysd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     

			" cw_kh_fgsdz.cwbm,xt_bm.name,sf_ysd.jshj,''100515'' ,'' 应收帐款-分公司 Accounts Receivable-Branch '',''1'',''部门：''+xt_bm.name ",// sub_source_cols0      ,

			" bm_id,bm,jfje,kmbm,kmmc,sfbmhs ,xgsx ",// sub_target_cols0      ,                  

			" jshj,''500402'' ,''销售收入-分公司 Sales-Branches'' ",// sub_source_cols1      ,

			" dfje,kmbm,kmmc ",// sub_target_cols1      ,                  
			"",// sub_source_cols2      ,
			"",// sub_target_cols2      ,                     
			"",// sub_source_cols3      ,
			"",// sub_target_cols3      ,                     
			"",// sub_source_cols4      ,
			"",// sub_target_cols4      ,                     
			"",// sub_source_cols5      ,
			"",// sub_target_cols5      ,                     
			"",// sub_source_cols6      ,
			"",// sub_target_cols6      ,                     
			"",// sub_source_cols7      ,
			"",// sub_target_cols7      ,                     
			"",// sub_source_cols8      ,
			"",// sub_target_cols8      ,                     
			"",// sub_source_cols9      , 
			""// sub_target_cols9          
   );

Serve.creatYwzdTemplate(
 			"分公司收款",// title            ,     
			"sf_skd,cw_kh_fgsdz ,xt_bm",// ywb_name         ,     
			"sf_skd.skdh",// djh_col_name     ,     
			"sf_skd.skrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1''  and gbzt <> ''1''   and sf_skd.kh =  cw_kh_fgsdz.kh and cw_kh_fgsdz.cwbm = xt_bm.id ",// filter           ,     
			"''收'',sf_skd.id,sf_skd.skdh,''sf_skd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,  
			
			" ssje,''100204'' ,''  银行存款-农行 Cash in Bank -AGRICULTURAL'' ",// sub_source_cols0      ,

			" jfje,kmbm,kmmc ",// sub_target_cols0      ,                 

			" cw_kh_fgsdz.cwbm,xt_bm.name,sf_skd.je,''100515'' ,'' 应收帐款-分公司 Accounts Receivable-Branch '',''1'',''部门：''+xt_bm.name ",// sub_source_cols0      ,

			" bm_id,bm,dfje,kmbm,kmmc,sfbmhs ,xgsx ",// sub_target_cols1      , 
 
			" -1*yhje,''500127'' ,''管理费用-办公费 Administrative Expenses - Documentation'' ",// sub_source_cols0      ,

			" dfje,kmbm,kmmc ",// sub_target_cols0      ,                 
			

			"",// sub_source_cols3      ,
			"",// sub_target_cols3      ,                     
			"",// sub_source_cols4      ,
			"",// sub_target_cols4      ,                     
			"",// sub_source_cols5      ,
			"",// sub_target_cols5      ,                     
			"",// sub_source_cols6      ,
			"",// sub_target_cols6      ,                     
			"",// sub_source_cols7      ,
			"",// sub_target_cols7      ,                     
			"",// sub_source_cols8      ,
			"",// sub_target_cols8      ,                     
			"",// sub_source_cols9      , 
			""// sub_target_cols9          
    
    

   );


   
   

%>

 

                         
                         



                         
                         
                         
                         
                         

                         
                         
                         
