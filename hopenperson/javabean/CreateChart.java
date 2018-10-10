package JavaBean.CreateChart;

import JavaBean.JavaConst.*;
import JavaBean.OperateDataBase.*;
import JavaBean.ClassNormal.*;
import JavaBean.ErrorManage.*;
import java.sql.*;
import java.io.*;
import java.lang.*;
import java.math.*;
import java.util.*;
import java.awt.image.BufferedImage;
import java.awt.image.*;
import java.awt.*;
import com.sun.image.codec.jpeg.*;

public class CreateChart
{
	static String filename="";//���ļ���������·��
	public static void main(String args[])
	{
		try
		{
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}		
	private static String GetFilename(String path)//��������ļ���(����·��)
	{
		Random rd=new Random();
		String filenamepath="";
		String num="";//���ɵ������
		while(true)
		{
			num=Integer.toString(Math.abs(rd.nextInt()));
			filenamepath=path+"\\"+num+".jpg";//��������ļ���
			
			File f1=new File(filenamepath);
			if (!f1.exists())//���ļ�������
				break;	
		}
		filename=num+".jpg";
		return (filenamepath);
	}
	/*********************************************************************\
		* Function�� CreatePhoto  
		* Purpose������sql���������Ƭ
		* Params:  sql��sql���,path:���ɵ�Ŀ¼
		* Return��һ��������ɵ��ļ���,���ļ���������·��
		* Remarks��	
		**********************************************************************/
	public static String CreatePhoto(String sql,String path)
	{
		String fname="";//��������ļ���
		try
		{			
			ResultSet rs=null;
			OperateDataBase odb=new OperateDataBase();
			byte b1[]=new byte[2048];
			rs=odb.executeQuery(sql);
			if (rs.next())
			{
				b1=rs.getBytes("C0115");
				fname=GetFilename(path);
				File f1=new File(fname);
				FileOutputStream fout=new FileOutputStream(f1);
				fout.write(b1);
				fout.close();
			}	
			odb.destroy();
		}
		catch(Exception e)
		{
			ErrorManage em = new ErrorManage();
			em.SaveError("","CreatePhoto",e.getMessage(),e.toString(),"û����Ƭ��");
			ErrorManage.DisplayError(e.getMessage(),"CreatePhoto");
		}
		return (filename);
	}	
}
