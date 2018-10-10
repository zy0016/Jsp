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
//		System.out.println("��ǰ���ڣ�"+df.format(d));
//		System.out.println("��ǰʱ�䣺"+df1.format(d));

    }
	public void ErrorManage()
	{
	}
	public static void DisplayError(String errormanage,String functionname)
	{
		System.out.println("��ִ�к���:"+functionname+"��ʱ�����,������ʾ:"+errormanage+"\n");	
	}
	public static boolean JustDateTime(String date)//�����ַ����Ƿ��ǺϷ�������
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
	* Function�� SaveError
	* Purpose��  ���������Ϣ
	* Params:  	place����ص�,source:����Դ�����ݣ�content:��������,remark����ע   
	* Return��	
	* Remarks��	
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
			
			sql	=	"insert into errormessage (��¼�û�,����ʱ��,����ص�,��������,����Դ,����ע) values(";
			sql	=	sql + "'" + accountname +"',";//��¼�û�
			sql	=	sql + "'" + df.format(d)+" " + df1.format(d) + "',";//����ʱ��
			sql	=	sql + "'" + place		+"',";//����ص�
			sql	=	sql + "'" + content		+"',";//��������
			sql	=	sql + "'" + source		+"',";//����Դ
			sql	=	sql + "'" + remark		+"')";//����ע
			
			odb.executeUpdate(sql);
		}
		catch(Exception e)
		{
			SaveError(place,content,source,remark);
		}
	}
	/*********************************************************************\
	* Function�� SaveError
	* Purpose��  ���������Ϣ
	* Params:  	place����ص�,source:����Դ�����ݣ�content:��������,remark����ע   
	* Return��	
	* Remarks��	
	**********************************************************************/
	public static void SaveError(String place,String content,String source,String remark)
	{
		String filename = "",str = "",account = "";
		String errorpath = "";
		
		JavaConst jc = new JavaConst();
		errorpath 	 = jc.errorfpath;//������־�ļ���·��
		
		java.text.SimpleDateFormat df	= new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.text.SimpleDateFormat df1	= new java.text.SimpleDateFormat("HH:mm:ss");
		java.util.Date d				= new java.util.Date();

		
		str	=		"����ʱ�䣺" + df.format(d) + " " + df1.format(d) + "  ";
		str	= str + "����ص㣺" + place	+"  ";
		str	= str + "�������ݣ�" + content	+"  ";
		str	= str + "����Դ��"	 + source	+"  ";
		str	= str + "����ע��" + remark	+"\n";
	
		try
		{
			PrintWriter pnt = new PrintWriter(new FileOutputStream(errorpath,true));
			pnt.println(str);//������
			pnt.close();
		}
		catch(Exception e)//���� I/O ��������̴���
		{
			System.out.println(e.toString()+" "+e.getMessage());
		}
	}
}