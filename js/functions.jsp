<%! public String getSelected(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "selected"; 
			} else {
				return "";
			}
		}
%>
<%! public boolean checkModule(String id,String[] result) {
	boolean y=false;
	for(int i=0;i<result.length;i+=3){
		if(result[i].equals(id)){
			y=true;
			break;
		}else{
			y=false;
		}
	}
	return y;
	}
	
%>
<%! public String getChecked(String x1,String x2) {
			if (x1==null || x2==null) return "";
			if (x1.equals(x2)) {
				return "checked"; 
			} else {
				return "";
			}
		}
%>

