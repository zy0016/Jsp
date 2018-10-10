package JavaBean.JavaConst;
import java.io.*;
import java.util.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import JavaBean.ClassNormal.*;
import JavaBean.ErrorManage.*;

public class JavaConst
{
	final	public	static	String	separator 	= "*";//�ָ���
	final 	public	static	String	errorfpath 	= "D:\\Tomcat\\webapps\\ROOT\\hopenhrmdss";//�����ļ���·��
	
	final	public	static	String	sdbDriver	= "sun.jdbc.odbc.JdbcOdbcDriver";	
	final	public	static	String 	sdbUrl		= "jdbc:odbc:datawork";//hrmdss
	
	final	public	static	String	dbuid  		= "sa";//"hrmdss";//���ݿ��¼�û���,sa
	final	public	static	String	dbpwd  		= "sa";//"hrmdss";//���ݿ��¼����,sa

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
			separator=fread.readLine();//��÷ָ���
			hostname=fread.readLine();//��ñ�����
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
	public static String getHostIP()//��ñ���IP��ַ
	{
		String hostip = "";//����ip��ַ
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
	public static String getHostname()//��ñ�����
	{
		String hostname = "";//������
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