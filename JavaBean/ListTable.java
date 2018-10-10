package JavaBean.ListTable;
import java.sql.*;
import JavaBean.PrintTable.*;
import JavaBean.ErrorManage.*;
import JavaBean.OperateDataBase.*;
import JavaBean.ClassNormal.*;

public class ListTable extends PrintTable 
{
	//******************第一列参数*******************
	private		String		TD_Width = "";
	private		String		TD_Height = "";
	private		String		TD_Colspan = "";
	private		String		TD_Rowspan = "";
	private		String		TD_Align = "";
	private		String		TD_Valign = "";
	private		String		TD_Scope = "";
	private		String		TD_Bgcolor = "";
	private		String		TD_Nowrap = "";
	private		String		TD_Bordercolor = "";
	private		String		TD_Bordercolorlight = "";
	private		String		TD_Bordercolordark = "";
	private		String		TD_Background = "";
	private		String		TD_Class = "";
	private		String		TD_ID = "";
	private		String		TD_Style = "";
	private		String		TD_Title = "";
	//******************第一列参数结束*******************
	//******************第二列参数*******************
	private		String		TD_DWidth = "";
	private		String		TD_DHeight = "";
	private		String		TD_DColspan = "";
	private		String		TD_DRowspan = "";
	private		String		TD_DAlign = "";
	private		String		TD_DValign = "";
	private		String		TD_DScope = "";
	private		String		TD_DBgcolor = "";
	private		String		TD_DNowrap = "";
	private		String		TD_DBordercolor = "";
	private		String		TD_DBordercolorlight = "";
	private		String		TD_DBordercolordark = "";
	private		String		TD_DBackground = "";
	private		String		TD_DClass = "";
	private		String		TD_DID = "";
	private		String		TD_DStyle = "";
	private		String		TD_DTitle = "";
	//******************第二列参数结束*******************
	private		String		TD_Fparam = "";//表格的第一列参数
	private		String		TD_Dparam = "";//表格的第二列参数
	private		String		TD_Fword  = "";//表格第一列的文字
	private		String		TD_Dword  = "";//表格第二列的文字
	public static void main(String args[])
	{
		int cols = 0;
		String sql = "";
		String result = "",width = "";
		try
		{
			ListTable lt = new ListTable();
			OperateDataBase odb = new OperateDataBase();
			
			sql = ClassNormal.createselect("A01","id","=","10");
			
			cols = odb.executeQuery_col(sql);
			width = String.valueOf(cols * 100);
			
			lt.setBorder("1");
			lt.setTD_FDword("项目","数据");
			lt.setTR_HBackgroundColor("#CCFFFF");
			lt.setTR_OBackgroundColor("#99FF00");
			lt.setTR_EBackgroundColor("#33CCFF");
			//lt.setTD_Align("center");
			//lt.setTD_DAlign("center");
			lt.setTR_HAlign("center");
			lt.setTR_HValign("top");
			
			result = lt.WriteTable(sql);
			
			System.out.println("表格生成完毕");
			
			if (lt.OutString(result,"d:\\temp\\ListTable.txt"))
				System.out.println("输出成功");
			else
				System.out.println("输出失败");
			
			//System.out.println(sql);
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}
	//打印两列多行的表格
	public void ListTable() 
	{}
	/*********************************************************************\
	* Function： WriteTable  
	* Purpose：输出表格,覆盖父类的方法
	* Params:  
	* Return：
	* Remarks：	
	**********************************************************************/
	public String WriteTable(String sql) 
	{
		StringBuffer 		result	= new StringBuffer("");
		int 				cols;//获得查询结果的列数
		String				param 	= "";//表格参数
		String				Hparam 	= "";//表格标题参数
		String				Oparam 	= "";//奇数列参数
		String				Eparam 	= "";//偶数列参数
		ResultSet			rs 		= null;
		ResultSetMetaData	rsmd 	= null;
		
		try
		{
			this.InitPrintTable(sql);
			this.InitPrintTable();
			
			rs		= this.GetResultSet();
			rsmd 	= this.GetResultSetMetaData();
			param	= this.GetParam();//获得表格参数
			Hparam	= this.GetTR_Hparam();//表格标题参数
			Oparam	= this.GetTR_Oparam();//奇数行参数
			Eparam	= this.GetTR_Eparam();//偶数行参数
			
			if (rs.next())
			{
				cols = rsmd.getColumnCount();//该查询结果有多少列
				
				result.append("<table");
				result.append(param);
				result.append(">\n");
				
				if ((TD_Fword.length() > 0) || (TD_Dword.length() > 0))
				{
					result.append("<tr");
					result.append(Hparam);
					result.append(">\n");
					
					result.append("<td");
					result.append(TD_Fparam);
					result.append(">");
					result.append(TD_Fword);
					result.append("</td><td");
					result.append(TD_Dparam);
					result.append(">");
					result.append(TD_Dword);
					result.append("</td>\n</tr>\n");
				}
				for (int i = 1;i <= cols;i++)
				{
					String Colname	= rsmd.getColumnName(i);//获得实际列名
					String data		= rs.getString(i);//获得数据
					
					if (rsmd.getColumnType(i) == -4)//该字段是照片字段
						continue;
					
					if (data == null)
						data = "&nbsp;";
					else if (data.length() == 0)
						data = "&nbsp;";
					else if (data.indexOf("00:00:00") >= 0)
						data = data.replaceAll("00:00:00","");
					
					result.append("<tr");
					if (i % 2 == 1)//奇数行
						result.append(Oparam);
					else				//偶数行
						result.append(Eparam);
					
					result.append(">\n");
					//第一列数据
					result.append("<td");
					result.append(TD_Fparam);
					result.append(">");
					result.append(Colname);
					result.append("</td>");
					//第二列数据
					result.append("<td");
					result.append(TD_Dparam);
					result.append(">");
					result.append(data);
					result.append("</td>");
					
					result.append("\n</tr>\n");
				}
				result.append("</table>\n");
			}
			this.destory();
		}
		catch (Exception e)
		{
			ErrorManage.SaveError(this.accountname,"ListTable.WriteTable",e.toString(),e.getMessage(),result.toString() + "执行失败");
		}
		return (result.toString());
	}
	/*********************************************************************\
	* Function： InitPrintTable  
	* Purpose：打印表格的初始化工作:生成表格的第一列参数/表格的第二列参数
	* Params:  sql:SQL语句			
	* Return：
	* Remarks：	
	**********************************************************************/
	private void InitPrintTable()
	{
		TD_Fparam	=	TD_Width				+ 
						TD_Height				+
						TD_Colspan				+
						TD_Rowspan				+
						TD_Align				+
						TD_Valign				+
						TD_Scope				+
						TD_Bgcolor				+
						TD_Nowrap				+
						TD_Bordercolor			+
						TD_Bordercolorlight		+
						TD_Bordercolordark		+
						TD_Background			+
						TD_Class				+
						TD_ID					+
						TD_Style				+
						TD_Title				+
						"";
		TD_Dparam	=	TD_DWidth				+ 
						TD_DHeight				+ 
						TD_DColspan				+ 
						TD_DRowspan				+ 
						TD_DAlign				+ 
						TD_DValign				+ 
						TD_DScope				+ 
						TD_DBgcolor				+ 
						TD_DNowrap				+ 
						TD_DBordercolor			+ 
						TD_DBordercolorlight	+ 
						TD_DBordercolordark		+ 
						TD_DBackground			+ 
						TD_DClass				+ 
						TD_DID					+ 
						TD_DStyle				+ 
						TD_DTitle				+ 
						"";                       
	}
	public String Get_TD_Fparam()
	{
		return (this.TD_Fparam);
	}
	public String Get_TD_Dparam()
	{
		return (this.TD_Dparam);
	}
	public void setTD_FDword(String td_fword,String td_dword)
	{
		this.TD_Fword = td_fword.trim();
		this.TD_Dword = td_dword.trim();
	}
//*********************************************************************************
	public void setTD_Width(String TD_Width) 
	{
		if (TD_Width.length() > 0)
			this.TD_Width = " width = \"" + TD_Width + "\""; 
	}
	public void setTD_Height(String TD_Height) 
	{
		if (TD_Height.length() > 0)
			this.TD_Height = " height = \"" + TD_Height + "\""; 
	}
	public void setTD_Colspan(String TD_Colspan) 
	{
		if (TD_Colspan.length() > 0)
			this.TD_Colspan = " colspan = \"" + TD_Colspan + "\""; 
	}
	public void setTD_Rowspan(String TD_Rowspan) 
	{
		if (TD_Rowspan.length() > 0)
			this.TD_Rowspan = " rowspan = \"" + TD_Rowspan + "\""; 
	}
	public void setTD_Align(String TD_Align) 
	{
		if (TD_Align.length() > 0)
			this.TD_Align = " align = \"" + TD_Align + "\""; 
	}
	public void setTD_Valign(String TD_Valign) 
	{
		if (TD_Valign.length() > 0)
			this.TD_Valign = " valign = \"" + TD_Valign + "\""; 
	}
	public void setTD_Scope(String TD_Scope) 
	{
		if (TD_Scope.length() > 0)
			this.TD_Scope = " scope = \"" + TD_Scope + "\""; 
	}
	public void setTD_Bgcolor(String TD_Bgcolor) 
	{
		if (TD_Bgcolor.length() > 0)
			this.TD_Bgcolor = " bgcolor = \"" + TD_Bgcolor + "\""; 
	}
	public void setTD_Nowrap(String TD_Nowrap) 
	{
		if (TD_Nowrap.length() > 0)
			this.TD_Nowrap = " " + TD_Nowrap; 
	}
	public void setTD_Bordercolor(String TD_Bordercolor) 
	{
		if (TD_Bordercolor.length() > 0)
			this.TD_Bordercolor = " bordercolor = \"" + TD_Bordercolor + "\""; 
	}
	public void setTD_Bordercolorlight(String TD_Bordercolorlight) 
	{
		if (TD_Bordercolorlight.length() > 0)
			this.TD_Bordercolorlight = " bordercolorlight = \"" + TD_Bordercolorlight + "\""; 
	}
	public void setTD_Bordercolordark(String TD_Bordercolordark) 
	{
		if (TD_Bordercolordark.length() > 0)
			this.TD_Bordercolordark = "bordercolordark = \"" + TD_Bordercolordark + "\""; 
	}
	public void setTD_Background(String TD_Background) 
	{
		if (TD_Background.length() > 0)
			this.TD_Background = " background = \"" + TD_Background + "\""; 
	}
	public void setTD_Class(String TD_Class) 
	{
		if (TD_Class.length() > 0)
			this.TD_Class = " class = \"" + TD_Class + "\""; 
	}
	public void setTD_ID(String TD_ID) 
	{
		if (TD_ID.length() > 0)
				this.TD_ID = " id = \"" + TD_ID + "\""; 
	}
	public void setTD_Style(String TD_Style) 
	{
		if (TD_Style.length() > 0)
			this.TD_Style = " style = \"" + TD_Style + "\""; 
	}
	public void setTD_Title(String TD_Title) 
	{
		if (TD_Title.length() > 0)
			this.TD_Title = " title = \"" + TD_Title + "\""; 
	}
	
	public String getTD_Width() 
	{
		return (this.TD_Width); 
	}
	public String getTD_Height() 
	{
		return (this.TD_Height); 
	}
	public String getTD_Colspan() 
	{
		return (this.TD_Colspan); 
	}
	public String getTD_Rowspan() 
	{
		return (this.TD_Rowspan); 
	}
	public String getTD_Align() 
	{
		return (this.TD_Align); 
	}
	public String getTD_Valign() 
	{
		return (this.TD_Valign); 
	}
	public String getTD_Scope() 
	{
		return (this.TD_Scope); 
	}
	public String getTD_Bgcolor() 
	{
		return (this.TD_Bgcolor); 
	}
	public String getTD_Nowrap() 
	{
		return (this.TD_Nowrap); 
	}
	public String getTD_Bordercolor() 
	{
		return (this.TD_Bordercolor); 
	}
	public String getTD_Bordercolorlight() 
	{
		return (this.TD_Bordercolorlight); 
	}
	public String getTD_Bordercolordark() 
	{
		return (this.TD_Bordercolordark); 
	}
	public String getTD_Background() 
	{
		return (this.TD_Background); 
	}
	public String getTD_Class() 
	{
		return (this.TD_Class); 
	}
	public String getTD_ID() 
	{
		return (this.TD_ID); 
	}
	public String getTD_Style() 
	{
		return (this.TD_Style); 
	}
	public String getTD_Title() 
	{
		return (this.TD_Title); 
	}
//******************************************************************************
	public void setTD_DWidth(String TD_DWidth) 
	{
		if (TD_DWidth.length() > 0)
			this.TD_DWidth = " width = \"" + TD_DWidth + "\""; 
	}
	public void setTD_DHeight(String TD_DHeight) 
	{
		if (TD_DHeight.length() > 0)
			this.TD_DHeight = " height = \"" + TD_DHeight + "\""; 
	}
	public void setTD_DColspan(String TD_DColspan) 
	{
		if (TD_DColspan.length() > 0)
			this.TD_DColspan = " colspan = \"" + TD_DColspan + "\""; 
	}
	public void setTD_DRowspan(String TD_DRowspan) 
	{
		if (TD_DColspan.length() > 0)
			this.TD_DRowspan = " rowspan = \"" + TD_DRowspan + "\""; 
	}
	public void setTD_DAlign(String TD_DAlign) 
	{
		if (TD_DAlign.length() > 0)
			this.TD_DAlign = " align = \"" + TD_DAlign + "\""; 
	}
	public void setTD_DValign(String TD_DValign) 
	{
		if (TD_DValign.length() > 0)
			this.TD_DValign = " valign = \"" + TD_DValign + "\""; 
	}
	public void setTD_DScopen(String TD_DScope) 
	{
		if (TD_DScope.length() > 0)
			this.TD_DScope = " scope = \"" + TD_DScope + "\""; 
	}
	public void setTD_DBgcolor(String TD_DBgcolor) 
	{
		if (TD_DBgcolor.length() > 0)
			this.TD_DBgcolor = " bgcolor = \"" + TD_DBgcolor + "\""; 
	}
	public void setTD_DNowrap(String TD_DNowrap) 
	{
		if (TD_DNowrap.length() > 0)
			this.TD_DNowrap = " " + TD_DNowrap; 
	}
	public void setTD_DBordercolor(String TD_DBordercolor) 
	{
		if (TD_DBordercolor.length() > 0)
			this.TD_DBordercolor = " bordercolor = \"" + TD_DBordercolor + "\""; 
	}
	public void setTD_DBordercolorlight(String TD_DBordercolorlight) 
	{
		if (TD_DBordercolorlight.length() > 0)
			this.TD_DBordercolorlight = " bordercolorlight = \"" + TD_DBordercolorlight + "\""; 
	}
	public void setTD_DBordercolordark(String TD_DBordercolordark) 
	{
		if (TD_DBordercolordark.length() > 0)
			this.TD_DBordercolordark = "bordercolordark = \"" + TD_DBordercolordark + "\""; 
	}
	public void setTD_DBackground(String TD_DBackground) 
	{
		if (TD_DBackground.length() > 0)
			this.TD_DBackground = " background = \"" + TD_DBackground + "\""; 
	}
	public void setTD_DClass(String TD_DClass) 
	{
		if (TD_DClass.length() > 0)
			this.TD_DClass = " class = \"" + TD_DClass + "\""; 
	}
	public void setTD_DID(String TD_DID) 
	{
		if (TD_DID.length() > 0)
			this.TD_DID = " id = \"" + TD_DID + "\""; 
	}
	public void setTD_DStyle(String TD_DStyle) 
	{
		if (TD_DStyle.length() > 0)
			this.TD_DStyle = " style = \"" + TD_DStyle + "\""; 
	}
	public void setTD_DTitle(String TD_DTitle) 
	{
		if (TD_DTitle.length() > 0)
			this.TD_DTitle = " title = \"" + TD_DTitle + "\""; 
	}

	public String getTD_DWidth() 
	{
		return (this.TD_DWidth); 
	}
	public String getTD_DHeight() 
	{
		return (this.TD_DHeight); 
	}
	public String getTD_DColspan() 
	{
		return (this.TD_DColspan); 
	}
	public String getTD_DRowspan() 
	{
		return (this.TD_DRowspan); 
	}
	public String getTD_DAlign() 
	{
		return (this.TD_DAlign); 
	}
	public String getTD_DValign() 
	{
		return (this.TD_DValign); 
	}
	public String getTD_DScopen() 
	{
		return (this.TD_DScope); 
	}
	public String getTD_DBgcolor() 
	{
		return (this.TD_DBgcolor); 
	}
	public String getTD_DNowrap() 
	{
		return (this.TD_DNowrap); 
	}
	public String getTD_DBordercolor() 
	{
		return (this.TD_DBordercolor); 
	}
	public String getTD_DBordercolorlight() 
	{
		return (this.TD_DBordercolorlight); 
	}
	public String getTD_DBordercolordark() 
	{
		return (this.TD_DBordercolordark); 
	}
	public String getTD_DBackground() 
	{
		return (this.TD_DBackground); 
	}
	public String getTD_DClass() 
	{
		return (this.TD_DClass); 
	}
	public String getTD_DID() 
	{
		return (this.TD_DID); 
	}
	public String getTD_DStyle() 
	{
		return (this.TD_DStyle); 
	}
	public String getTD_DTitle() 
	{
		return (this.TD_DTitle); 
	}	
}
