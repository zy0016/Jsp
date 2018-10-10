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
	static String filename="";//纯文件名，不含路径
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
	private static String GetFilename(String path)//生成随机文件名(包括路径)
	{
		Random rd=new Random();
		String filenamepath="";
		String num="";//生成的随机数
		while(true)
		{
			num=Integer.toString(Math.abs(rd.nextInt()));
			filenamepath=path+"\\"+num+".jpg";//生成随机文件名
			
			File f1=new File(filenamepath);
			if (!f1.exists())//该文件不存在
				break;	
		}
		filename=num+".jpg";
		return (filenamepath);
	}
	/*********************************************************************\
		* Function： CreatePhoto  
		* Purpose：根据sql语句生成照片
		* Params:  sql：sql语句,path:生成的目录
		* Return：一个随机生成的文件名,纯文件名，不含路径
		* Remarks：	
		**********************************************************************/
	public static String CreatePhoto(String sql,String path)
	{
		String fname="";//生成随机文件名
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
			em.SaveError("","CreatePhoto",e.getMessage(),e.toString(),"没有照片。");
			ErrorManage.DisplayError(e.getMessage(),"CreatePhoto");
		}
		return (filename);
	}	
}
