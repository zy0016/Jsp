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
	public	static	String	dbname	= "hrmdss";//����Դ������
	public	static	String	dbuid  	= "hrmdss";//���ݿ��¼�û���
	public	static	String	dbpwd  	= "hrmdss";//���ݿ��¼����

	public	String	errorfpath = "d:\\hopenhrmdss\\log\\error.log";//�����ļ���·��
	
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
			machine		= fread.readLine();//������ݿ����ڻ�����
			dbname		= fread.readLine();//������ݿ���
			dbuid		= fread.readLine();//��õ�¼���ݿ��û���
			dbpwd		= fread.readLine();//��õ�¼���ݿ�����
			separator	= fread.readLine();//��÷ָ���
			
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
		String hostip="";//����ip��ַ
		try
		{
			InetAddress address = InetAddress.getByName(hostname);//���IP��ַ
			hostip=address.getHostAddress();
		}
		catch(Exception e)
		{
			
		}
		return (hostip);
	}
}