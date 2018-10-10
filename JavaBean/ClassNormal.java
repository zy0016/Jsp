package JavaBean.ClassNormal;

import JavaBean.OperateDataBase.*;
import JavaBean.ErrorManage.*;
import JavaBean.GridTable.*;
import JavaBean.PrintTable.*;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class ClassNormal
{
	static String filename="";//纯文件名，不含路径(用于生成照片)
	public static void main(String args[])
	{
		int					icols	= 0;
		String 				sql		= "";
		String				sqlTable="select * from INFORMATION_SCHEMA.TABLES";
		String				sqlTrigger="select * from INFORMATION_SCHEMA.TRIGGER";
		ResultSet 			rs		= null;
		ResultSetMetaData	rsmd 	= null;
		try
		{
			OperateDataBase odb=new OperateDataBase();
			if (odb.getConn()==null)
				System.out.println("数据库连接失败。");
			else
				System.out.println("数据库连接成功。");
			
			//odb.executeQuery_Display(sqlTable);
			//odb.executeQuery_Display("select * from usi_infor");
			//列出数据库中所有的表
			sql = "create trigger system_wind on usi_infor for insert as begin rollback transaction end";
			if (odb.executeQuery(sql) == null)
				System.out.println("失败");
			else
				System.out.println("成功");
			//System.out.print(icols);
			//GridTable gt = new GridTable();
			
			
			/*sql = "select * from usi_infor";
			res = gt.WriteTable(sql);
			System.out.println("表格生成完毕");
			
			if (gt.OutString(res,"d:\\temp\\GridTable.txt"))
				System.out.println("输出成功");
			else
				System.out.println("输出失败");*/
				
			//String ss = String.valueOf(9);
			
			/*sql = "select * from A01 where id = -1";
			rs = odb.executeQuery(sql);
			rsmd = rs.getMetaData();
			icols = rsmd.getColumnCount();
			
			System.out.println("一共" + icols +"列");
			for (int i = 1;i <= icols;i++)
			{
				String Colname = rsmd.getColumnName(i);
				System.out.println(Colname + "类型编号:" + rsmd.getColumnType(i));
			}
			rs.close();
			byte b1[]=new byte[2048];
			sql="select C0115 from A01 where id=15";
			rs=odb.executeQuery(sql);
			if (rs.next())
			{
				b1=rs.getBytes("C0115");
				File f1=new File("JavaBean\\ClassNormal","photo.jpg");
				FileOutputStream fout=new FileOutputStream(f1);
				fout.write(b1);
			}
			sql=createselect("A01","id","=","115");
			sql=output_excel(sql,"d:\\computer file\\Jsp\\JavaBean\\JavaBean\\ClassNormal");//createselect("A01","A01.A0101","=","23");
			System.out.println(sql);*/
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}		
	public ClassNormal()
	{}
	/*********************************************************************\
		* Function： output_excel  
		* Purpose：根据sql语句生成excel文件
		* Params:  sql：sql语句,path:生成的目录
		* Return：一个随机生成的文件名
		* Remarks：	
		**********************************************************************/
	public static String output_excel(String sql,String path)
	{
		String fname = "";//生成随机文件名
		ResultSet rs = null;
		String res   = "";
		StringBuffer result = new StringBuffer("");

		try
		{
			ResultSetMetaData rsmd;//声明接口对象
			
			OperateDataBase odb = new OperateDataBase();
			rs 					= odb.executeQuery(sql);

			rsmd 				= rs.getMetaData();
			int col 			= rsmd.getColumnCount();//该查询结果有多少列
			
			/*String htmhead="";
			BufferedReader fread=new BufferedReader(new FileReader("d:\\computer file\\Jsp\\JavaBean\\JavaBean\\ClassNormal\\htm.txt"));
			for (int i=1;i<157;i++)
				htmhead=htmhead+fread.readLine()+"\n";*/
			result.append("<html>\n");
			result.append("<head>\n");		
			result.append("<meta http-equiv=Content-Type content=\"text/html; charset=GB2312\">\n");
			result.append("<meta name=ProgId content=Excel.Sheet>\n");		
			result.append("<meta name=Generator content=\"Microsoft Excel 9\">\n");
			result.append("<table border=0>\n");
			result.append("<tr>\n");// height=19 style='height:14.25pt'

			for (int i = 1;i <= col;i++)//添加列名
			{
				String colname = rsmd.getColumnName(i);//获得列名
				if (i==1)
				{
					result.append("<td align=middle>");//height=19 align=right style='height:14.25pt' x:num
				}
				else
				{
					result.append("<td align=middle>");// align=right x:num
				}
				result.append(colname);
				result.append("</td>\n");
			}
			result.append("</tr>\n");
			
			while(rs.next())
			{
				result.append("<tr>\n");//height=19 style='height:14.25pt'
				for (int i = 1;i <= col;i++)
				{
					String data = rs.getString(i);
					
					//if (data.length()==0)
						//data="&nbsp;";
					if (i==1)
					{
						result.append("<td align=middle>");//height=19 align=right style='height:14.25pt' x:num
					}
					else
					{
						result.append("<td align=middle>");//align=right x:num
					}
					result.append(data);
					result.append("</td>\n");
				}
				result.append("</tr>\n");
			}
			
			result.append("\n</table></body></html>");
			res = result.toString();
			res = res.replaceAll("null","&nbsp;");
			res = res.replaceAll("00:00:00","");
			/////////////////////////////////////////////////////////////////////
			fname = GetFilename(path,"xls");
			//System.out.println(fname);
			PrintWriter pnt = new PrintWriter(new FileOutputStream(fname));
			pnt.println(res);//输出结果
			pnt.close();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"output_excel");
		}
		return (filename);//fname
	}
	/*********************************************************************\
	* Function： GetFilename  
	* Purpose：生成随机文件名
	* Params:  paht:生成文件的路径，extend：该文件的扩展名
	* Return：一个随机生成的文件名(包括路径)
	* Remarks：	
	**********************************************************************/
	public static String GetFilename(String path,String extend)//生成随机文件名(包括路径)
	{
		Random rd = new Random();
		String filenamepath="";
		String num = "";//生成的随机数
		while(true)
		{
			num = Integer.toString(Math.abs(rd.nextInt()));
			filenamepath = path + "\\" + num + "." + extend;//生成随机文件名
			
			File f1 = new File(filenamepath);
			if (!f1.exists())//该文件不存在
				break;	
		}
		filename = num + "." + extend;
		
		return (filenamepath);//
	}
	public static double get4_5(double num,int i)
	{
		int point = Double.toString(num).indexOf(".");//获得小数点的位置
		if (point < 0)//没有小数点
			return (num);
			
		String nu		= Double.toString(num);
		String leftnu	= getleft_rightstr(nu,".",-1);
		String rightnu	= getleft_rightstr(nu,".",1);
		String result	= "";
		if (rightnu.length() <= i)
			return (num);
		else
		{
			result = leftnu + "." + rightnu.substring(0,i);
			return(Double.parseDouble(result));
		}
	}
	/*********************************************************************\
		* Function： getleft_rightstr  
		* Purpose：在字符串str1中查找字符串str2,i=-1为从左边为开始点开始找，i=1为从右边开始点开始找,返回开始点到str2的字符串     
		* Params:  	在字符串str1中查找字符串str2,i=-1为从左边为开始点开始找，i=1为从右边开始点开始找,返回开始点到str2的字符串 
		* Return：	返回开始点到str2的字符串(例如：str1="12;34",str2=";",i=-1,返回12,i=1返回34)
		* Remarks：	
		**********************************************************************/
	public static String getleft_rightstr(String str1,String str2,int i)
	{
		String	result = "";
		if (str1.trim().compareTo("")==0)
			result = "";
		else
			switch (i)
			{
				case -1:
					result = str1.substring(0,str1.indexOf(str2));
					break;
				case 1:
					result = str1.substring(str1.indexOf(str2)+1,str1.length()).trim();
					break;
			}
		return (result);
	}
	/*********************************************************************\
	* Function： ReplaceString  
	* Purpose：字符串替换
	* Params:  strSource:源字符串,strFrom:需要替换的字符串,strTo:替换成的字符串
	* Return：	替换完毕的字符串
	* Remarks：	
	**********************************************************************/
	public static String ReplaceString(String strSource,String strFrom,String strTo)
	{ 
		String strDest = ""; 
		int intFromLen = strFrom.length(); 
		int intPos; 

		while((intPos = strSource.indexOf(strFrom))!=-1)
		{ 
			strDest   = strDest + strSource.substring(0,intPos); 
			strDest   = strDest + strTo; 
			strSource = strSource.substring(intPos+intFromLen); 
		} 
		strDest = strDest + strSource; 
		return strDest; 
	} 
	/*********************************************************************\
	* Function： createselect  
	* Purpose：生成查询语句     
	* Params:  	tablename:查询哪一个表，fieldname：查询哪一个字段，term：查询条件是什么(=;>;<...)，data：用户输入或选择的数据   
	* Return：	返回查询语句     
	* Remarks：	特别规定：若查询的表不是A01表,则tablename包含2个表，如A01,A04，逗号后边的表是用户要查的表
	**********************************************************************/
	public static String createselect(String tablename,String fieldname,String term,String data)
	{
		String		select = ""/*保存有关字段的查询语句的生成结果*/,select_table = ""/*保存有关表名的查询语句的生成结果*/,table = "";//中间表名
		int			i = 0;
		String		result = "调用"/*最终结果*/,d_Field = ""/*显示给用户的字段名*/;
		String		findtable = "";//保存实际在哪一表中查询
		String 		code = "",field_name = "",memo = "";
		ResultSet 	rs = null;
		
		findtable = tablename;
		try
		{
			OperateDataBase odb = new OperateDataBase();
			rs = odb.executeQuery("select * from BasInfTFMenu where table_name='" + findtable + "'");
			select = "select ";
			if (tablename.compareTo("A01")==0)
				select_table = " from " + tablename;
			else
				select_table = " from A01," + tablename;
			
			i = 0;
			while(rs.next())
			{
				table 		= " T" + Integer.toString(i);
				d_Field		= rs.getString("field_hz");
				field_name	= rs.getString("field_name");
				memo		= rs.getString("memo");
				code		= rs.getString("code");
				
				if (d_Field.indexOf("（")>=0)
					d_Field = d_Field.replaceAll("（","");
				if (d_Field.indexOf("）")>=0)
					d_Field = d_Field.replaceAll("）","");
				if (d_Field.indexOf("(")>=0)
					d_Field = d_Field.replaceAll("(","");
				if (d_Field.indexOf(")")>=0)
					d_Field = d_Field.replaceAll(")","");
					
				if (memo.compareTo("0")==0)//通过判断code字段是否为空确定该字段式输入还是选择
				{
					if (d_Field.compareTo("id")==0)//对id字段进行特殊处理：A01表中不显示id字段，其他表将id字段显示为姓名字段
					{
						if (tablename.compareTo("A01")==0)
							continue;
						else //非A01表将id字段显示为姓名字段
							select = select + " A01.A0101" + " as 姓名,";//field_name字段
					}
					else if (d_Field.compareTo("id_identity")==0)
						continue;
					else //非id字段
					{
						if (field_name.compareTo("C0115")==0)//不处理照片字段
							continue;
						select = select + findtable + "." + field_name + " as " + d_Field + ",";//field_name字段	
					}
				}
				else
				{
					if (code.indexOf("B02")>=0)
					{
						select = select + table + ".b0205" + " as " + d_Field + ",";
						select_table = select_table + " LEFT OUTER JOIN b02 " + table + " on " + table + ".b0210=" + findtable + "." + field_name;
					}
					else
					{
						select = select + table + ".name" + " as " + d_Field + ",";
						select_table = select_table + " LEFT OUTER JOIN datalist " + table + " on " + table + ".idcode=" + findtable + "." + field_name + " and " + table + ".code='" + code + "'";
					}
				}
				i++;
			}
			select = select.substring(0,select.length() - 1);
			
			if (fieldname.length() > 0)//有查询条件
			{
				if ((term.indexOf("like")>=0) && (data.indexOf("%")==-1))//"包含"条件
				{
					if (tablename.compareTo("A01")!=0)//查询涉及到两个表不只是A01表
						result = select + " " + select_table + " where " + fieldname + " " + term + " '%" + data + "%' and " + "A01.id=" + findtable + ".id";
					else
						result = select + " " + select_table + " where " + fieldname + " " + term + " '%" + data + "%'";
				}
				else
				{
					if (tablename.compareTo("A01")!=0)//不是A01表
						result = select + " " + select_table + " where " + fieldname + " " + term + "'" + data + "' and " + "A01.id=" + findtable + ".id";
					else	//A01表
						result = select + " " + select_table + " where " + fieldname + " " + term + "'" + data + "'";
				}
			}
			else	//没有查询条件
			{
				if (tablename.compareTo("A01")!=0)//不是A01表
					result = select + " " + select_table + " where A01.id=" + findtable + ".id";
				else	//A01表
					result = select + " " + select_table;
			}
		}
		catch(Exception e)
		{
			//result="调用失败"+"d_Field="+d_Field+",code="+code+",select="+select+",memo="+memo+",findtable="+findtable;	
			//result=result+",i="+String.valueOf(i)+e.getMessage();
			ErrorManage.DisplayError(e.getMessage(),"createselect");
		}		
		return (result);
	}
}
