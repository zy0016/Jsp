package JavaBean.ErrorManage;
import java.io.*;
import java.util.*;
import java.text.*;
import JavaBean.OperateDataBase.*;
import JavaBean.JavaConst.*;

public class ErrorManage
{
	public static void main(String args[])
    {
    	/*Date now = new Date();
    	long l=now.getTime();
    	long l1=now.getYear();
    	int x = new java.util.Date().getDate();
    	int x= DateFormat.getDateInstance(now.getDate()).toString();
    	String d=DateFormat.getTimeInstance().format(now);
    	System.out.print(d);*/
//    	java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
//		java.text.SimpleDateFormat df1=new java.text.SimpleDateFormat("HH:mm:ss");
//		java.util.Date d=new java.util.Date();
//		System.out.println("当前日期："+df.format(d));
//		System.out.println("当前时间："+df1.format(d));

    }
	public void ErrorManage()
	{
	}
	public static void DisplayError(String errormanage,String functionname)
	{
		System.out.println("在执行函数:"+functionname+"的时候出错,出错提示:"+errormanage+"\n");	
	}
	public static boolean JustDateTime(String date)//考察字符串是否是合法的日期
    {//2002-2-32
    	boolean result=false;
    	Date now = new Date();
    	try
    	{
    		SimpleDateFormat df2 = new SimpleDateFormat("yyyy MM dd");
	        Date parsedDate = df2.parse(date);

    		//now = new Date (date);
    		//SimpleDateFormat dd =new SimpleDateFormat("YYYY/MM/DD");
    		//now=dd.parse(date);
    		//now = DateFormat.getInstance().parse(date);
    		//DateFormat.getInstance().parse(
    		result=true;
    	}
    	catch(Exception e)
    	{
    		result=false;
    		System.out.println(e.toString()+" "+e.getMessage());
    	}
    	return (result);
    }
	/*********************************************************************\
	* Function： SaveError
	* Purpose：  保存错误信息
	* Params:  	place错误地点,source:错误源的内容，content:错误内容,remark错误备注   
	* Return：	
	* Remarks：	
	**********************************************************************/
	public static void SaveError(String accountname,String place,String content,String source,String remark)
	{
		String sql="";
		java.text.SimpleDateFormat df  	= new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat df1 	= new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date d 				= new java.util.Date();
		try
		{
			OperateDataBase odb=new OperateDataBase();
			
			sql	=	"insert into errormessage (登录用户,错误时间,错误地点,错误内容,错误源,错误备注) values(";
			sql	=	sql + "'" + accountname +"',";//登录用户
			sql	=	sql + "'" + df.format(d)+" " + df1.format(d) + "',";//错误时间
			sql	=	sql + "'" + place		+"',";//错误地点
			sql	=	sql + "'" + content		+"',";//错误内容
			sql	=	sql + "'" + source		+"',";//错误源
			sql	=	sql + "'" + remark		+"')";//错误备注
			
			odb.executeUpdate(sql);
		}
		catch(Exception e)
		{
			SaveError(place,content,source,remark);
		}
	}
	/*********************************************************************\
	* Function： SaveError
	* Purpose：  保存错误信息
	* Params:  	place错误地点,source:错误源的内容，content:错误内容,remark错误备注   
	* Return：	
	* Remarks：	
	**********************************************************************/
	public static void SaveError(String place,String content,String source,String remark)
	{
		String filename = "",str = "",account = "";
		String errorpath = "";
		
		JavaConst jc = new JavaConst();
		errorpath 	 = jc.errorfpath;//错误日志文件的路径
		
		java.text.SimpleDateFormat df	= new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat df1	= new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date d				= new java.util.Date();

		
		str	=		"错误时间：" + df.format(d) + " " + df1.format(d) + "  ";
		str	= str + "错误地点：" + place	+"  ";
		str	= str + "错误内容：" + content	+"  ";
		str	= str + "错误源："	 + source	+"  ";
		str	= str + "错误备注：" + remark	+"\n";
	
		try
		{
			PrintWriter pnt = new PrintWriter(new FileOutputStream(errorpath,true));
			pnt.println(str);//输出结果
			pnt.close();
		}
		catch(Exception e)//发生 I/O 错误，如磁盘错误
		{
			System.out.println(e.toString()+" "+e.getMessage());
		}
	}
}