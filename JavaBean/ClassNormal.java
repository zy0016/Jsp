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
	static String filename="";//���ļ���������·��(����������Ƭ)
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
				System.out.println("���ݿ�����ʧ�ܡ�");
			else
				System.out.println("���ݿ����ӳɹ���");
			
			//odb.executeQuery_Display(sqlTable);
			//odb.executeQuery_Display("select * from usi_infor");
			//�г����ݿ������еı�
			sql = "create trigger system_wind on usi_infor for insert as begin rollback transaction end";
			if (odb.executeQuery(sql) == null)
				System.out.println("ʧ��");
			else
				System.out.println("�ɹ�");
			//System.out.print(icols);
			//GridTable gt = new GridTable();
			
			
			/*sql = "select * from usi_infor";
			res = gt.WriteTable(sql);
			System.out.println("����������");
			
			if (gt.OutString(res,"d:\\temp\\GridTable.txt"))
				System.out.println("����ɹ�");
			else
				System.out.println("���ʧ��");*/
				
			//String ss = String.valueOf(9);
			
			/*sql = "select * from A01 where id = -1";
			rs = odb.executeQuery(sql);
			rsmd = rs.getMetaData();
			icols = rsmd.getColumnCount();
			
			System.out.println("һ��" + icols +"��");
			for (int i = 1;i <= icols;i++)
			{
				String Colname = rsmd.getColumnName(i);
				System.out.println(Colname + "���ͱ��:" + rsmd.getColumnType(i));
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
		* Function�� output_excel  
		* Purpose������sql�������excel�ļ�
		* Params:  sql��sql���,path:���ɵ�Ŀ¼
		* Return��һ��������ɵ��ļ���
		* Remarks��	
		**********************************************************************/
	public static String output_excel(String sql,String path)
	{
		String fname = "";//��������ļ���
		ResultSet rs = null;
		String res   = "";
		StringBuffer result = new StringBuffer("");

		try
		{
			ResultSetMetaData rsmd;//�����ӿڶ���
			
			OperateDataBase odb = new OperateDataBase();
			rs 					= odb.executeQuery(sql);

			rsmd 				= rs.getMetaData();
			int col 			= rsmd.getColumnCount();//�ò�ѯ����ж�����
			
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

			for (int i = 1;i <= col;i++)//�������
			{
				String colname = rsmd.getColumnName(i);//�������
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
			pnt.println(res);//������
			pnt.close();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"output_excel");
		}
		return (filename);//fname
	}
	/*********************************************************************\
	* Function�� GetFilename  
	* Purpose����������ļ���
	* Params:  paht:�����ļ���·����extend�����ļ�����չ��
	* Return��һ��������ɵ��ļ���(����·��)
	* Remarks��	
	**********************************************************************/
	public static String GetFilename(String path,String extend)//��������ļ���(����·��)
	{
		Random rd = new Random();
		String filenamepath="";
		String num = "";//���ɵ������
		while(true)
		{
			num = Integer.toString(Math.abs(rd.nextInt()));
			filenamepath = path + "\\" + num + "." + extend;//��������ļ���
			
			File f1 = new File(filenamepath);
			if (!f1.exists())//���ļ�������
				break;	
		}
		filename = num + "." + extend;
		
		return (filenamepath);//
	}
	public static double get4_5(double num,int i)
	{
		int point = Double.toString(num).indexOf(".");//���С�����λ��
		if (point < 0)//û��С����
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
		* Function�� getleft_rightstr  
		* Purpose�����ַ���str1�в����ַ���str2,i=-1Ϊ�����Ϊ��ʼ�㿪ʼ�ң�i=1Ϊ���ұ߿�ʼ�㿪ʼ��,���ؿ�ʼ�㵽str2���ַ���     
		* Params:  	���ַ���str1�в����ַ���str2,i=-1Ϊ�����Ϊ��ʼ�㿪ʼ�ң�i=1Ϊ���ұ߿�ʼ�㿪ʼ��,���ؿ�ʼ�㵽str2���ַ��� 
		* Return��	���ؿ�ʼ�㵽str2���ַ���(���磺str1="12;34",str2=";",i=-1,����12,i=1����34)
		* Remarks��	
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
	* Function�� ReplaceString  
	* Purpose���ַ����滻
	* Params:  strSource:Դ�ַ���,strFrom:��Ҫ�滻���ַ���,strTo:�滻�ɵ��ַ���
	* Return��	�滻��ϵ��ַ���
	* Remarks��	
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
	* Function�� createselect  
	* Purpose�����ɲ�ѯ���     
	* Params:  	tablename:��ѯ��һ����fieldname����ѯ��һ���ֶΣ�term����ѯ������ʲô(=;>;<...)��data���û������ѡ�������   
	* Return��	���ز�ѯ���     
	* Remarks��	�ر�涨������ѯ�ı���A01��,��tablename����2������A01,A04�����ź�ߵı����û�Ҫ��ı�
	**********************************************************************/
	public static String createselect(String tablename,String fieldname,String term,String data)
	{
		String		select = ""/*�����й��ֶεĲ�ѯ�������ɽ��*/,select_table = ""/*�����йر����Ĳ�ѯ�������ɽ��*/,table = "";//�м����
		int			i = 0;
		String		result = "����"/*���ս��*/,d_Field = ""/*��ʾ���û����ֶ���*/;
		String		findtable = "";//����ʵ������һ���в�ѯ
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
				
				if (d_Field.indexOf("��")>=0)
					d_Field = d_Field.replaceAll("��","");
				if (d_Field.indexOf("��")>=0)
					d_Field = d_Field.replaceAll("��","");
				if (d_Field.indexOf("(")>=0)
					d_Field = d_Field.replaceAll("(","");
				if (d_Field.indexOf(")")>=0)
					d_Field = d_Field.replaceAll(")","");
					
				if (memo.compareTo("0")==0)//ͨ���ж�code�ֶ��Ƿ�Ϊ��ȷ�����ֶ�ʽ���뻹��ѡ��
				{
					if (d_Field.compareTo("id")==0)//��id�ֶν������⴦��A01���в���ʾid�ֶΣ�������id�ֶ���ʾΪ�����ֶ�
					{
						if (tablename.compareTo("A01")==0)
							continue;
						else //��A01��id�ֶ���ʾΪ�����ֶ�
							select = select + " A01.A0101" + " as ����,";//field_name�ֶ�
					}
					else if (d_Field.compareTo("id_identity")==0)
						continue;
					else //��id�ֶ�
					{
						if (field_name.compareTo("C0115")==0)//��������Ƭ�ֶ�
							continue;
						select = select + findtable + "." + field_name + " as " + d_Field + ",";//field_name�ֶ�	
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
			
			if (fieldname.length() > 0)//�в�ѯ����
			{
				if ((term.indexOf("like")>=0) && (data.indexOf("%")==-1))//"����"����
				{
					if (tablename.compareTo("A01")!=0)//��ѯ�漰��������ֻ��A01��
						result = select + " " + select_table + " where " + fieldname + " " + term + " '%" + data + "%' and " + "A01.id=" + findtable + ".id";
					else
						result = select + " " + select_table + " where " + fieldname + " " + term + " '%" + data + "%'";
				}
				else
				{
					if (tablename.compareTo("A01")!=0)//����A01��
						result = select + " " + select_table + " where " + fieldname + " " + term + "'" + data + "' and " + "A01.id=" + findtable + ".id";
					else	//A01��
						result = select + " " + select_table + " where " + fieldname + " " + term + "'" + data + "'";
				}
			}
			else	//û�в�ѯ����
			{
				if (tablename.compareTo("A01")!=0)//����A01��
					result = select + " " + select_table + " where A01.id=" + findtable + ".id";
				else	//A01��
					result = select + " " + select_table;
			}
		}
		catch(Exception e)
		{
			//result="����ʧ��"+"d_Field="+d_Field+",code="+code+",select="+select+",memo="+memo+",findtable="+findtable;	
			//result=result+",i="+String.valueOf(i)+e.getMessage();
			ErrorManage.DisplayError(e.getMessage(),"createselect");
		}		
		return (result);
	}
}
