package JavaBean.JavaConst;
import java.io.*;
import java.util.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import JavaBean.ClassNormal.*;
import JavaBean.ErrorManage.*;

public class JavaConst
{
	final	public	static	String	separator 	= "*";//分隔符
	final 	public	static	String	errorfpath 	= "D:\\Tomcat\\webapps\\ROOT\\hopenhrmdss";//错误文件的路径
	
	final	public	static	String	sdbDriver	= "sun.jdbc.odbc.JdbcOdbcDriver";	
	final	public	static	String 	sdbUrl		= "jdbc:odbc:datawork";//hrmdss
	
	final	public	static	String	dbuid  		= "sa";//"hrmdss";//数据库登录用户名,sa
	final	public	static	String	dbpwd  		= "sa";//"hrmdss";//数据库登录密码,sa

			public	static	String	PATH 		= "";
	public void JavaConst()
	{
		//PATH.substring(
		String constfile="const.ini";
		try
		{
			/*File f1=new File(constfile);
			String fpath="";
			fpath=f1.getAbsolutePath();
			fpath=f1.getCanonicalPath();
			fpath=ClassNormal.ReplaceString(fpath,constfile,"")+"JavaBean\\JavaConst\\"+constfile;
			fpath=ClassNormal.ReplaceString(fpath,File.separator,File.separator+File.separator);
			
			BufferedReader fread=new BufferedReader(new FileReader(fpath));
			separator=fread.readLine();//获得分隔符
			hostname=fread.readLine();//获得本机名
			fread.close();*/
			System.out.print(getHostIP());
		}
		catch(Exception e)
		{
			System.out.print(e.getMessage());
		}
	}	
	public static void main(String args[])
	{
		try
		{
			System.out.println(getHostIP());
			System.out.println(getHostname());
			//System.out.println(InetAddress.getLocalHost());
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}
	public static String getHostIP()//获得本机IP地址
	{
		String hostip = "";//本机ip地址
		try
		{
			hostip = InetAddress.getLocalHost().getHostAddress();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"getHostIP");
			hostip = "127.0.0.1";
		}
		return (hostip);
	}
	public static String getHostname()//获得本机名
	{
		String hostname = "";//本机名
		try
		{
			hostname = InetAddress.getLocalHost().getHostName();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"getHostname");
			hostname = "no name";
		}
		return (hostname);
	}
}