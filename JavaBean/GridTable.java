package JavaBean.GridTable;
import java.sql.*;
import JavaBean.PrintTable.*;
import JavaBean.ErrorManage.*;
import JavaBean.ClassNormal.*;
import JavaBean.OperateDataBase.*;

public class GridTable extends PrintTable 
{
	private		long	lCount = 0;//表格显示了多少条数据
	public static void main(String args[])
	{
		int cols = 0;
		String sql = "";
		String result = "",width = "";
		try
		{
			GridTable gt = new GridTable();
			OperateDataBase odb = new OperateDataBase();
			
			sql = ClassNormal.createselect("A07","","","");
			
			cols = odb.executeQuery_col(sql);
			width = String.valueOf(cols * 110);
			
			gt.setBorder("1");
			gt.setWidth(width);
			gt.setTR_HBackgroundColor("#33FF00");
			gt.setTR_OBackgroundColor("#0066FF");
			gt.setTR_EBackgroundColor("#00FFFF");
			gt.setTR_HAlign("center");
			gt.setTR_OAlign("center");
			gt.setTR_EAlign("center");
			
			result = gt.WriteTable(sql);
			//result = gt.WriteTable(sql,16,10);
			
			System.out.println("表格生成完毕");
			
			if (gt.OutString(result,"d:\\temp\\GridTable.txt"))
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
	//打印格子式的表格
	public void GridTable()
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
		long 				count 	= 0;//计数器
		String				param 	= "";//表格参数
		String				Hparam 	= "";//表格标题参数
		String				Oparam 	= "";//奇数列参数
		String				Eparam 	= "";//偶数列参数
		ResultSet			rs 		= null;
		ResultSetMetaData	rsmd 	= null;
		
		try
		{
			this.InitPrintTable(sql);
			rs		= this.GetResultSet();
			rsmd 	= this.GetResultSetMetaData();
			param	= this.GetParam();//获得表格参数
			Hparam	= this.GetTR_Hparam();//表格标题参数
			Oparam	= this.GetTR_Oparam();//奇数行参数
			Eparam	= this.GetTR_Eparam();//偶数行参数
					
			cols 	= rsmd.getColumnCount();//该查询结果有多少列
			
			result.append("<table");
			result.append(param);
			result.append(">\n");
			
			result.append("<tr");
			result.append(Hparam);
			result.append(">\n");
			
			for (int i = 1;i <= cols;i++)
			{
				String colname = rsmd.getColumnName(i).toString();//获得列名
				result.append("<td>");
				result.append(colname);
				result.append("</td>");
			}
			result.append("</tr>\n");
			
			count = 0;
			while (rs.next())
			{
				count++;
				
				result.append("<tr");
				if (count % 2 == 1)//奇数行
					result.append(Oparam);
				else				//偶数行
					result.append(Eparam);
					
				result.append(">\n");
				
				for (int i = 1;i <= cols;i++)
				{
					String data = rs.getString(i);
					
					if (data == null)
						data = "&nbsp;";
					else if (data.length() == 0)
						data = "&nbsp;";
					else if (data.indexOf("00:00:00") >= 0)
						data = data.replaceAll("00:00:00","");

					result.append("<td>");
					result.append(data);
					result.append("</td>");
				}
				result.append("\n</tr>\n");
			}
			result.append("</table>\n");
			this.destory();
		}
		catch (Exception e)
		{
			ErrorManage.SaveError(this.accountname,"GridTable.WriteTable",e.toString(),e.getMessage(),result.toString() + "执行失败");
		}
		lCount = count;
		return (result.toString());
	}
	public long getlCount()
	{
		return (this.lCount);
	}
//*************************************************************************************
	/*********************************************************************\
	* Function： WriteTable  
	* Purpose：分页式输出表格
	* Params:  sql:需要执行的SQL语句.iCurrentPage:当前的页数,iPageSize:一页显示的记录数
	* Return：
	* Remarks：	
	**********************************************************************/
	public String WriteTable(String sql,int iCurrentPage,int iPageSize)
	{
		StringBuffer 		result	= new StringBuffer("");
		int 				cols;//获得查询结果的列数
		long 				count 	= 0;//计数器
		long				intRowCount;//记录总数
		long				intPageCount;//总页数
		String				param 	= "";//表格参数
		String				Hparam 	= "";//表格标题参数
		String				Oparam 	= "";//奇数列参数
		String				Eparam 	= "";//偶数列参数
		ResultSet			rs 		= null;
		ResultSetMetaData	rsmd 	= null;
		
		try
		{
			OperateDataBase odb = new OperateDataBase();
			this.InitPrintTable(sql);
			rs		= this.GetResultSet();
			rsmd 	= this.GetResultSetMetaData();
			param	= this.GetParam();//获得表格参数
			Hparam	= this.GetTR_Hparam();//表格标题参数
			Oparam	= this.GetTR_Oparam();//奇数行参数
			Eparam	= this.GetTR_Eparam();//偶数行参数
					
			cols 	= rsmd.getColumnCount();//该查询结果有多少列
			
			result.append("<table");
			result.append(param);
			result.append(">\n");
			
			result.append("<tr");
			result.append(Hparam);
			result.append(">\n");
			for (int i = 1;i <= cols;i++)
			{
				String colname = rsmd.getColumnName(i).toString();//获得列名
				result.append("<td>");
				result.append(colname);
				result.append("</td>");
			}
			result.append("</tr>\n");
			
			//rs.absolute((iCurrentPage - 1) * iPageSize + 1);//不知为什么执行出错
			count 			= 0;
			intRowCount 	= odb.executeQuery_long(sql);//记录总数
			intPageCount 	= (intRowCount + iPageSize - 1) / iPageSize;//记算总页数
			
			while (rs.next())
			{
				count++;
				//if (!((iCurrentPage - 1) * iPageSize + 1 <= count && count <= iPageSize * iCurrentPage))
				//	continue;
				
				if ((iCurrentPage - 1) * iPageSize + 1 > count)
					continue;
				if (iPageSize * iCurrentPage < count)
					break;
				
				result.append("<tr");
				if (count % 2 == 1)//奇数行
					result.append(Oparam);
				else				//偶数行
					result.append(Eparam);
					
				result.append(">\n");
				
				for (int i = 1;i <= cols;i++)
				{
					String data = rs.getString(i);
					
					if (data == null)
						data = "&nbsp;";
					else if (data.length() == 0)
						data = "&nbsp;";
					else if (data.indexOf("00:00:00") >= 0)
						data = data.replaceAll("00:00:00","");

					result.append("<td>");
					result.append(data);
					result.append("</td>");
				}
				result.append("\n</tr>\n");
			}
			result.append("</table>\n");
			this.destory();
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError("GridTable.WriteTable",e.getMessage() + "执行失败");
		}
		return (result.toString());
	}
}
