<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*,com.lf.lfbase.service.*,java.util.*"%>
<%
/*
public static void creatYwzdTemplate (
			String title            ,     
			String ywb_name         ,     
			String djh_col_name     ,     
			String rq_col_name      ,     
			String filter           ,     
			String source_cols      ,     
			String target_cols      ,

			String sub_source_cols0      , 
			String sub_target_cols0      , 
			                               
			String sub_source_cols1      , 
			String sub_target_cols1      , 
			                               
			String sub_source_cols2      , 
			String sub_target_cols2      , 
                                                       
			String sub_source_cols3      , 
			String sub_target_cols3      , 
                                                       
			String sub_source_cols4      , 
			String sub_target_cols4      , 
                                                       
			String sub_source_cols5      , 
			String sub_target_cols5      , 
                                                       
			String sub_source_cols6      , 
			String sub_target_cols6      , 
                                                       
			String sub_source_cols7      , 
			String sub_target_cols7      , 
                                                       
			String sub_source_cols8      , 
			String sub_target_cols8      , 
                                                       
			String sub_source_cols9      , 
			String sub_target_cols9       
			
			
	)
*/



//=销售部分=======================================================================
 
 //应收单 制单
//-------------------------------------------------------------------------------

Serve.creatYwzdTemplate(
 			"北京办发货",// title            ,     
			"sf_ysd",// ywb_name         ,     
			"ysdh",// djh_col_name     ,     
			"djrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003001'' and gbzt <> ''1'' ",// filter           ,     
			"''转'',id,ysdh,''sf_ysd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     

			" kh,kh_id,jshj,''100512'' ,'' 应收帐款-北京办 Accounts Receivable-Beijing'',''1'',''客户：''+kh ",// sub_source_cols0      ,

			" kh,kh_id,jfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols0      ,                  

			" jshj,''500404'' ,''销售收入-北京办 Sales-Beijing'' ",// sub_source_cols1      ,

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
 			"广州办发货",// title            ,     
			"sf_ysd",// ywb_name         ,     
			"ysdh",// djh_col_name     ,     
			"djrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003002'' and gbzt <> ''1'' ",// filter           ,     
			"''转'',id,ysdh,''sf_ysd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     

			" kh,kh_id,jshj,''100513'' ,'' 应收帐款-广州办 Accounts Receivable-Guangzhou'',''1'',''客户：''+kh ",// sub_source_cols0      ,

			" kh,kh_id,jfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols0      ,                  

			" jshj,''500406'' ,''销售收入-广洲办 Sales-Guangzhou'' ",// sub_source_cols1      ,

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
 			"成都办发货",// title            ,     
			"sf_ysd",// ywb_name         ,     
			"ysdh",// djh_col_name     ,     
			"djrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003003'' and gbzt <> ''1'' ",// filter           ,     
			"''转'',id,ysdh,''sf_ysd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     

			" kh,kh_id,jshj,''100514'' ,'' 应收帐款-成都办 Accounts Receivable-Chengdu'',''1'',''客户：''+kh ",// sub_source_cols0      ,

			" kh,kh_id,jfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols0      ,                  

			" jshj,''500405'' ,''销售收入-成都办 Sales-Chengdu'' ",// sub_source_cols1      ,

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



   //------------------------------------------------------------------------
    //收款单 制单
   Serve.creatYwzdTemplate(
 			"广州办收款",// title            ,     
			"sf_skd",// ywb_name         ,     
			"skdh",// djh_col_name     ,     
			"skrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003002'' and gbzt <> ''1'' ",// filter           ,     
			"''收'',id,skdh,''sf_skd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     
	
			" ssje,''100204'' ,''  银行存款-农行 Cash in Bank -AGRICULTURAL'' ",// sub_source_cols0      ,

			" jfje,kmbm,kmmc ",// sub_target_cols0      ,                 

			" kh,kh_id,je,''100513'' ,'' 应收帐款-广州办 Accounts Receivable-Guangzhou'',''1'',''客户：''+kh ",// sub_source_cols1      ,

			" kh,kh_id,dfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols1      ,                  
 
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

Serve.creatYwzdTemplate(
 			"北京办收款",// title            ,     
			"sf_skd",// ywb_name         ,     
			"skdh",// djh_col_name     ,     
			"skrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003001'' and gbzt <> ''1'' ",// filter           ,     
			"''收'',id,skdh,''sf_skd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     
	
			" ssje,''100204'' ,''  银行存款-农行 Cash in Bank -AGRICULTURAL'' ",// sub_source_cols0      ,

			" jfje,kmbm,kmmc ",// sub_target_cols0      ,                 

			" kh,kh_id,je,''100512'' ,'' 应收帐款-北京办 Accounts Receivable-Beijing'',''1'',''客户：''+kh ",// sub_source_cols1      ,

			" kh,kh_id,dfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols1      ,                  
 
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


Serve.creatYwzdTemplate(
 			"成都办收款",// title            ,     
			"sf_skd",// ywb_name         ,     
			"skdh",// djh_col_name     ,     
			"skrq",// rq_col_name      ,     
			" shzt = ''1'' and cwzdbz<>''1'' and ywbm_id = ''100003003'' and gbzt <> ''1'' ",// filter           ,     
			"''收'',id,skdh,''sf_skd'',''2'',''cwzdbz''",// source_cols      ,     

			" pzlb,cz_id,czbh,czbm,czlx,czhxzd ",// target_cols      ,     
	
			" ssje,''100204'' ,''  银行存款-农行 Cash in Bank -AGRICULTURAL'' ",// sub_source_cols0      ,

			" jfje,kmbm,kmmc ",// sub_target_cols0      ,                 

			" kh,kh_id,je,''100514'' ,'' 应收帐款-成都办 Accounts Receivable-Chengdu'',''1'',''客户：''+kh ",// sub_source_cols1      ,

			" kh,kh_id,dfje,kmbm,kmmc,sfkhwl ,xgsx ",// sub_target_cols1      ,                  
 
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

 

                         
                         



                         
                         
                         
                         
                         

                         
                         
                         
