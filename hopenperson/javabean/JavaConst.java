package JavaBean.JavaConst;
import java.io.*;
import java.util.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import JavaBean.ClassNormal.*;
import JavaBean.ErrorManage.*;

public class JavaConst
{
	public	static	String	separator = "*";
	public	static	String	dbname	= "hrmdss";//数据源的名字
	public	static	String	dbuid  	= "hrmdss";//数据库登录用户名
	public	static	String	dbpwd  	= "hrmdss";//数据库登录密码

	public	String	errorfpath = "d:\\hopenhrmdss\\log\\error.log";//错误文件的路径
	
	public static String PATH="";
	public void JavaConst()
	{
//		separator	= "*";
//		dbname		= "hrmdss";
//		dbuid		= "hrmdss";
//		dbpwd		= "hrmdss";
//		errorfpath	= "d:\\hopenhrmdss\\log\\error.log";
		float i;
		
		try
		{
			/*File f1=new File(constfile);
			String fpath="";
			fpath=f1.getAbsolutePath();
			fpath=f1.getCanonicalPath();
			fpath=ClassNormal.ReplaceString(fpath,constfile,"")+"JavaBean\\JavaConst\\"+constfile;
			fpath=ClassNormal.ReplaceString(fpath,File.separator,File.separator+File.separator);
			
			BufferedReader fread = new BufferedReader(new FileReader(fpath));
			machine		= fread.readLine();//获得数据库所在机器名
			dbname		= fread.readLine();//获得数据库名
			dbuid		= fread.readLine();//获得登录数据库用户名
			dbpwd		= fread.readLine();//获得登录数据库密码
			separator	= fread.readLine();//获得分隔符
			
			fread.close();
						
			System.out.print(this.toString()+"\n");*/
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
			System.out.println(getHostIP("zhaoyong"));
		}
		catch(Exception e)
		{
			
		}
	}
	public static String getHostIP(String hostname)
	{
		String hostip="";//本机ip地址
		try
		{
			InetAddress address = InetAddress.getByName(hostname);//获得IP地址
			hostip=address.getHostAddress();
		}
		catch(Exception e)
		{
			
		}
		return (hostip);
	}
}