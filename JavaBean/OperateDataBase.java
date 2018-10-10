package JavaBean.OperateDataBase;
import java.sql.*;
import java.util.*;
import JavaBean.JavaConst.*;
import JavaBean.ErrorManage.*;
import JavaBean.ClassNormal.*;

public class OperateDataBase
{
	ResultSet rs = null;
	public Statement stmt;
	public Connection conn = null;
	ResultSetMetaData rsmd;//�����ӿڶ���
	private static String separator = "";
	private String accountname="";//�ʻ���

	public OperateDataBase() throws ClassNotFoundException,SQLException
	{
		try
		{
			Class.forName(JavaConst.sdbDriver);
			conn = DriverManager.getConnection(JavaConst.sdbUrl,JavaConst.dbuid,JavaConst.dbpwd);
			separator = JavaConst.separator;
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"OperateDataBase");
			//ErrorManage.SaveError("OperateDataBase",e.toString(),e.getMessage(),"���ݿ�����ʧ��");
		}
	}
	public Connection getConn()
	{
		return(conn);	
	}
	/*********************************************************************\
	* Function�� executeUpdate  
	* Purpose��ִ��sql��䣬���ظ����˶���������
	* Params:  sqlҪִ�е�sql���
	* Return�����ظ����˶���������
	* Remarks��	
	**********************************************************************/
	public int executeUpdate(String sql)
	{
		int count = 0;//�����˶���������
		try
		{
			stmt  = conn.createStatement();
			count = stmt.executeUpdate(sql);
			stmt.close();
		}
		catch(SQLException ex)
		{
			//ErrorManage.DisplayError(ex.getMessage(),"executeUpdate");
			ErrorManage.SaveError(accountname,"executeUpdate",ex.toString(),ex.getMessage(),"���³���");
		}
		return (count);
	}
	/*********************************************************************\
	* Function�� executeQuery  
	* Purpose��ִ��sql��䣬����ResultSet����
	* Params:  sqlҪִ�е�sql���
	* Return������ResultSet����
	* Remarks��	
	**********************************************************************/
	public ResultSet executeQuery(String sql)
	{
		rs = null;
		try
		{
			stmt = conn.createStatement();
			rs	 = stmt.executeQuery(sql);	
		}	
		catch(SQLException ex)
		{
			//ErrorManage.DisplayError(ex.getMessage(),"executeQuery");
			ErrorManage.SaveError(accountname,"executeQuery",ex.toString(),ex.getMessage(),"ִ��sql���ʧ�ܡ�");
		}
		return rs;
	}
	/*********************************************************************\
	* Function�� executeQuery_long  
	* Purpose��ִ��sql��䣬�����ҵ�����������
	* Params:  sqlҪִ�е�sql���
	* Return�������ҵ�����������
	* Remarks��	
	**********************************************************************/
	public long executeQuery_long(String sql)
	{
		rs = null;
		long count = 0;
		try
		{
			stmt = conn.createStatement();
			rs	 = stmt.executeQuery(sql);
			while(rs.next())
			{
				count++;	
			}
			stmt.close();
		}	
		catch(SQLException ex)
		{
			ErrorManage.DisplayError(ex.getMessage(),"executeQuery_long");
			//ErrorManage.SaveError(accountname,"executeQuery_long",ex.toString(),ex.getMessage(),"���ؼ�¼����ʧ�ܡ�");
		}
		return(count);
	}
	/*********************************************************************\
	* Function�� executeQuery_col  
	* Purpose��ִ��sql��䣬���ظü�¼���ж�����
	* Params:  sqlҪִ�е�sql���
	* Return�����ظü�¼���ж�����
	* Remarks��	
	**********************************************************************/
	public int executeQuery_col(String sql)//�ü�¼���ж�����
	{
		rs = null;
		int cols = 0;
		try
		{
			stmt = conn.createStatement();
			rs	 = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			cols = rsmd.getColumnCount();
			stmt.close();
		}
		catch(SQLException ex)
		{
			//ErrorManage.DisplayError(ex.getMessage(),"executeQuery_col");
			ErrorManage.SaveError(accountname,"executeQuery_col",ex.toString(),ex.getMessage(),"���ؼ�¼����ʧ�ܡ�");
		}
		return(cols);
	}
	/*********************************************************************\
	* Function�� executeQuery_String  
	* Purpose��ִ��sql��䣬�����ҵ������ݣ�����֮����separator����
	* Params:  sqlҪִ�е�sql���
	* Return�������ҵ������ݣ�����֮����separator����
	* Remarks��	
	**********************************************************************/
	public String executeQuery_String(String sql)
	{
				rs 	   = null;
		int		cols   = 0;
		String	result = "";
		try
		{
			stmt = conn.createStatement();
			rs	 = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			cols = rsmd.getColumnCount();
			while(rs.next())	
			{
				for (int i = 1;i <= cols;i++)
				{
					result = result + rs.getString(i) + separator;
				}
			}
			if (result.trim().compareTo("")!=0)
				result = result.substring(0,result.length() - 1);
			stmt.close();
		}	
		catch(SQLException ex)
		{
			//ErrorManage.DisplayError(ex.getMessage(),"executeQuery_String");
			ErrorManage.SaveError(accountname,"executeQuery_String",ex.toString(),ex.getMessage(),"��������ʧ�ܡ�");
		}
		return(result);
	}
	/*********************************************************************\
	* Function�� executeQuery_Display  
	* Purpose��ִ��sql��䣬��ʾ�ҵ�������
	* Params:  sqlҪִ�е�sql���
	* Return��
	* Remarks��	
	**********************************************************************/
	public void executeQuery_Display(String sql)
	{
				rs 	   = null;
		int		cols   = 0;
		try
		{
			stmt = conn.createStatement();
			rs	 = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			cols = rsmd.getColumnCount();

			for (int i = 1;i <= cols;i++)//�������
			{
				System.out.print(rsmd.getColumnName(i) + "\t");
			}
			System.out.println("");
			while(rs.next())	
			{
				for (int i = 1;i <= cols;i++)
				{
					System.out.print(rs.getString(i) + "\t");
				}
				System.out.println("");
			}
			stmt.close();
		}	
		catch(SQLException ex)
		{
			//ErrorManage.DisplayError(ex.getMessage(),"executeQuery_String");
			ErrorManage.SaveError(accountname,"executeQuery_String",ex.toString(),ex.getMessage(),"��������ʧ�ܡ�");
		}
	}
	/*********************************************************************\
	* Function�� SaveUpdateLog  
	* Purpose����¼�û��ĸ��²���
	* Params:  sqlstrҪִ�е����,account:�û���
	* Return��
	* Remarks��	
	**********************************************************************/
	public void SaveUpdateLog(String account,String sqlstr)
	{
		String	sql = "",type = "",temp = "",tablename = "";
		int i = 0;
		ClassNormal cn = new ClassNormal();
		java.text.SimpleDateFormat df	= new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat df1	= new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date d = new java.util.Date();
		
		if (sqlstr.substring(0,6).compareTo("insert")==0)
		{
			type = "����";
			temp = sqlstr.substring(13);
		}
		else if (sqlstr.substring(0,6).compareTo("delete")==0)
		{
			type = "ɾ��";
			temp = sqlstr.substring(13);
		}
		else if (sqlstr.substring(0,6).compareTo("update")==0)
		{
			type = "����";
			temp = sqlstr.substring(7);
		}
		else
		{
			return;
		}
		i 			= temp.indexOf(" ");
		sqlstr 		= cn.ReplaceString(sqlstr,"'","\"");
		tablename 	= temp.substring(0,i);//��ñ���
		
		sql ="insert into UpdateLog (�û���,ʱ��,SQL���,��������,������) values(";
		sql = sql + "'" + account + "',";
		sql = sql + "'" + df.format(d) + " " + df1.format(d) + "',";
		sql = sql + "'" + sqlstr + "',";
		sql = sql + "'" + type + "',";
		sql = sql + "'" + tablename + "')";
		try
		{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			stmt.close();
		}
		catch(SQLException ex)
		{
			ErrorManage.SaveError(account,"SaveUpdateLog",ex.toString(),ex.getMessage(),"��¼������־����");
		}
	}
	public void destroy()
	{
		try
		{
			stmt.close();
			conn.close();
		}	
		catch(Exception e)
		{
			//ErrorManage.DisplayError(e.getMessage(),"destroy");
			ErrorManage.SaveError(accountname,"destroy",e.toString(),e.getMessage(),"�ͷ���Դʧ�ܡ�");
			e.printStackTrace();
		}
	}
}