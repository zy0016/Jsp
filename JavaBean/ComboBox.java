package JavaBean.ComboBox;
import java.sql.*;
import java.io.*;
import JavaBean.OperateDataBase.*;
import JavaBean.ErrorManage.*;

final public class ComboBox//该类不能被继承
{
	private		String	cName = "";
	private		String	cId = "";
	private		String	cEvent = "";
	private		String	cFirstValue = "";
	private		String	cFirstText = "";
	
	private		String	cParam = "";//列表框参数集合
	public static void main(String args[])
	{
		String result = "";
		String sql = "select * from BasInfTMenu where flag=1 and table_name<>'C50'";
		try
		{
			ComboBox cb = new ComboBox();
			cb.setCName("listfield");
			cb.setCId("listfield");
			cb.setCEvent("onChange=\"doPostBack('listfield','')");
			cb.setCFirstValue("null");
			cb.setCFirstText("请选择查询字段");
			
			//result = cb.OutComboBox(sql,"A07","A07.a0765");
			//result = cb.OutComboBox(sql,"A07");
			result = cb.OutComboBox("B021","hoqa",0);
			System.out.print(result);
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}
	public ComboBox()
	{}
	public String OutComboBox(String sql,String selecttable,String selectfield)
	{
		StringBuffer 	result	= new StringBuffer("");
		ResultSet		rs 		= null;
		
		try
		{
			OperateDataBase odb = new OperateDataBase();
			InitOutComboBox();
			
			rs = odb.executeQuery(sql);
			result.append("<select");
			result.append(cParam);
			result.append(">\n");
			result.append("<option");
			result.append(cFirstValue);
			result.append(">");
			result.append(cFirstText);
			result.append("</option>\n");
			
			while (rs.next())
			{
				String res 			= rs.getString("field_hz");
				String val 			= rs.getString("field_name");
				String result_val 	= selecttable + "." + val;
				
				if (val.equals("id"))
				{
					result.append("<option value=\"A01.A0101\"");
					if (selectfield.equals("A01.A0101")) 
						result.append(" selected");
					
					result.append(">姓名</option>\n");
				}
				else if (val.equals("id_identity"))
				{
					result.append("<option value=\"");
					result.append(selecttable);
					result.append(".");
					result.append(val);
					
					if (result_val.equals(selectfield)) 
						result.append("\" selected>");
					else					
						result.append("\">");
						
					result.append("编号</option>\n");
				}
				else
				{
					result.append("<option value=\"");
					result.append(selecttable);
					result.append(".");
					result.append(val);
					
					if (result_val.equals(selectfield)) 
						result.append("\" selected>");
					else
						result.append("\">");
						
					result.append(res);
					result.append("</option>\n");
				}
			}
			result.append("</select>\n");
			rs.close();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError("ComboBox.OutComboBox",e.getMessage() + "执行失败");
		}
		return (result.toString());
	}
	public String OutComboBox(String sql,String selecttable)
	{
		StringBuffer 	result	= new StringBuffer("");
		ResultSet		rs 		= null;
		
		try
		{
			OperateDataBase odb = new OperateDataBase();
			InitOutComboBox();
			
			rs = odb.executeQuery(sql);
			result.append("<select");
			result.append(cParam);
			result.append(">\n");
			result.append("<option");
			result.append(cFirstValue);
			result.append(">");
			result.append(cFirstText);
			result.append("</option>\n");
			
			while (rs.next())
			{
				String res = rs.getString("table_hz");
				String val = rs.getString("table_name");
				
				result.append("<option value=\"");
				result.append(val);
				
				if (val.equals(selecttable)) 
					result.append("\" selected>");
				else
					result.append("\">");
					
				result.append(res);
				result.append("</option>\n");
			}
			result.append("</select>\n");
			rs.close();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError("ComboBox.OutComboBox",e.getMessage() + "执行失败");
		}
		return (result.toString());
	}
	public String OutComboBox(String code,String selectvalue,int sign)
	{
		StringBuffer 	result	= new StringBuffer("");
		ResultSet		rs 		= null;
		String			sql		= "";
		try
		{	
			OperateDataBase odb = new OperateDataBase();
			InitOutComboBox();
			
			result.append("<select");
			result.append(cParam);
			result.append(">\n");
			result.append("<option");
			result.append(cFirstValue);
			result.append(">");
			result.append(cFirstText);
			result.append("</option>\n");
			
			if (code.indexOf("B02")>=0)
			{
				if (code.equals("B020"))
					sql = "select B0205,B0210 from B02 where B0215='0'";
				else if (code.equals("B021"))
					sql = "select B0205,B0210 from B02 where B0215='1'";
				else if (code.equals("B022"))
					sql = "select B0205,B0210 from B02 where B0215='2'";
			}
			else
				sql = "select Name,Idcode from dataList where code='" + code + "'";
			
			rs = odb.executeQuery(sql);
			while (rs.next())
			{
				String vals		= rs.getString(1);
				String Idcode	= rs.getString(2);
				
				result.append("<option value=\"");
				result.append(Idcode);
				
				if (Idcode.equals(selectvalue)) 
					result.append("\" selected>");
				else
					result.append("\">");
					
				result.append(vals);
				result.append("</option>\n");
			}
			result.append("</select>\n");
			rs.close();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError("ComboBox.OutComboBox",e.getMessage() + "执行失败");
		}
		return (result.toString());
	}
	private void InitOutComboBox()
	{
		cParam =	cName	+
					cId		+
					cEvent	+
					"";
	}
	public void ResetOutComboBox()
	{
		cName = "";
		cId = "";
		cEvent = "";
		cFirstValue = "";
		cFirstText = "";
	}
	public void setCName(String cName) 
	{
		this.cName = " name = \"" + cName + "\""; 
	}
	public void setCId(String cId) 
	{
		this.cId = " id = \"" + cId + "\""; 
	}
	public void setCEvent(String cEvent) 
	{
		this.cEvent = " " + cEvent + "\""; 
	}
	public void setCFirstValue(String cFirstValue)
	{
		this.cFirstValue = " value = \"" + cFirstValue + "\""; 
	}
	public void setCFirstText(String cFirstText) 
	{
		this.cFirstText = cFirstText; 
	}
}