package JavaBean.OperateDataBase;
import java.sql.*;
import java.util.Date;
import java.io.*;
import java.text.*;

import JavaBean.JavaConst.*;
import JavaBean.ErrorManage.*;
import JavaBean.ClassNormal.*;

public class OperateDataBase
{
	private String sdbDriver="sun.jdbc.odbc.JdbcOdbcDriver";	
	private String sdbUrl="jdbc:odbc:hrmdss";
	ResultSet rs=null;
	
	public Statement stmt;
	public Connection conn=null;
	
	ResultSetMetaData rsmd;//声名接口对象
	private static String separator="";
	
	private String accountname="";//帐户名
	public static void main(String args[])
    {
    }
	public OperateDataBase() throws ClassNotFoundException,SQLException
	{
		try
		{
			accountname = "";//account;
			JavaConst jc = new JavaConst();
			separator = jc.separator;
			sdbUrl = "jdbc:odbc:"+jc.dbname;
			
			Class.forName(sdbDriver);
			conn = DriverManager.getConnection(sdbUrl,jc.dbuid,jc.dbpwd);
			//conn = DriverManager.getConnection(sdbUrl,"hrmdss","hrmdss");
		}
		catch(Exception e)
		{
			ErrorManage.SaveError("OperateDataBase",e.toString(),e.getMessage(),"数据库连接失败");
		}
	}
	
	public Connection getConn()
	{
		return(conn);	
	}
	/*********************************************************************\
	* Function： executeUpdate  
	* Purpose：执行sql语句，返回更新了多少条数据
	* Params:  sql要执行的sql语句
	* Return：返回更新了多少条数据
	* Remarks：	
	**********************************************************************/
	public int executeUpdate(String sql)
	{
		int count=0;//更新了多少条数据
		try
		{
			stmt=conn.createStatement();
			count=stmt.executeUpdate(sql);
			
			stmt.close();
		}
		catch(SQLException ex)
		{
			ErrorManage.SaveError(accountname,"executeUpdate",ex.toString(),ex.getMessage(),"更新出错");
			count=-1;//更新失败
		}
		return (count);
	}
	/*********************************************************************\
	* Function： executeQuery  
	* Purpose：执行sql语句，返回ResultSet对象
	* Params:  sql要执行的sql语句
	* Return：返回ResultSet对象
	* Remarks：	
	**********************************************************************/
	public ResultSet executeQuery(String sql)
	{
		rs=null;
		try
		{
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);	
		}	
		catch(SQLException ex)
		{
			ErrorManage.SaveError(accountname,"executeQuery",ex.toString(),ex.getMessage(),"执行sql语句失败。");
		}
		return rs;
	}
	/*********************************************************************\
	* Function： executeQuery_long  
	* Purpose：执行sql语句，返回找到多少条数据
	* Params:  sql要执行的sql语句
	* Return：返回找到多少条数据
	* Remarks：	
	**********************************************************************/
	public int executeQuery_long(String sql)
	{
		rs=null;
		int count=0;
		try
		{
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				count++;	
			}
			stmt.close();
		}	
		catch(SQLException ex)
		{
			ErrorManage.SaveError(accountname,"executeQuery_long",ex.toString(),ex.getMessage(),"返回记录条数失败。");
		}
		return(count);
	}
	/*********************************************************************\
	* Function： executeQuery_col  
	* Purpose：执行sql语句，返回该记录集有多少列
	* Params:  sql要执行的sql语句
	* Return：返回该记录集有多少列
	* Remarks：	
	**********************************************************************/
	public int executeQuery_col(String sql)//该记录集有多少列
	{
		rs=null;
		int cols=0;
		try
		{
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			rsmd=rs.getMetaData();
			cols=rsmd.getColumnCount();
			stmt.close();
		}
		catch(SQLException ex)
		{
			ErrorManage.SaveError(accountname,"executeQuery_col",ex.toString(),ex.getMessage(),"返回记录列数失败。");
		}
		return(cols);
	}
	/*********************************************************************\
	* Function： executeQuery_String  
	* Purpose：执行sql语句，返回找到的数据，数据之间用separator隔开
	* Params:  sql要执行的sql语句
	* Return：返回找到的数据，数据之间用separator隔开
	* Remarks：	
	**********************************************************************/
	public String executeQuery_String(String sql)
	{
		rs=null;
		int cols=0;
		String result="";
		try
		{
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			rsmd=rs.getMetaData();
			cols=rsmd.getColumnCount();
			while(rs.next())	
			{
				for (int i=1;i<=cols;i++)
				{
					result=result+rs.getString(i)+separator;
					
				}
			}
			if (result.trim().compareTo("")!=0)
				result=result.substring(0,result.length()-1);
			stmt.close();
		}	
		catch(SQLException ex)
		{
			ErrorManage.SaveError(accountname,"executeQuery_String",ex.toString(),ex.getMessage(),"返回数据失败。");
		}
		return(result);
	}
	/*********************************************************************\
	* Function： SaveUpdateLog  
	* Purpose：记录用户的更新操作
	* Params:  sqlstr要执行的语句,account:用户名
	* Return：
	* Remarks：	
	**********************************************************************/
	public void SaveUpdateLog(String account,String sqlstr)
	{
		String	sql="",type="",temp="",tablename="";
		int i=0;
		ClassNormal cn=new ClassNormal();
		java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat df1=new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date d=new java.util.Date();
		
		if (sqlstr.substring(0,6).compareTo("insert")==0)
		{
			type="插入";
			temp=sqlstr.substring(13);
		}
		else if (sqlstr.substring(0,6).compareTo("delete")==0)
		{
			type="删除";
			temp=sqlstr.substring(13);
		}
		else if (sqlstr.substring(0,6).compareTo("update")==0)
		{
			type="更新";
			temp=sqlstr.substring(7);
		}
		else
		{
			return;
		}
		i=temp.indexOf(" ");
		sqlstr=cn.ReplaceString(sqlstr,"'","\"");
		tablename=temp.substring(0,i);//获得表名
		
		sql="insert into UpdateLog (用户名,时间,SQL语句,操作类型,操作表) values(";
		sql=sql+"'"+account+"',";
		sql=sql+"'"+df.format(d)+" "+df1.format(d)+"',";
		sql=sql+"'"+sqlstr+"',";
		sql=sql+"'"+type+"',";
		sql=sql+"'"+tablename+"')";
		try
		{
			stmt=conn.createStatement();
			stmt.executeUpdate(sql);
			stmt.close();
		}
		catch(SQLException ex)
		{
			ErrorManage.SaveError(account,"SaveUpdateLog",ex.toString(),ex.getMessage(),"记录更新日志出错");
		}
	}
	/*********************************************************************\
	* Function： destroy  
	* Purpose：释放资源
	* Params:  
	* Return：
	* Remarks：	
	**********************************************************************/
	public void destroy()
	{
		try
		{
			stmt.close();
			conn.close();
		}	
		catch(Exception e)
		{
			ErrorManage.SaveError(accountname,"destroy",e.toString(),e.getMessage(),"释放资源失败。");
		}
	}
}