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
	static String separator	= "";
	static String showdata	= ""/*±£´æ¸÷¸ö·ÖÎöÏî*/;
	static String citem		= ""/*±£´æ¶ÔÓ¦µÄÏîÄ¿µÄÈËÊı*/;
	static int count		= 0;//×ÜÈËÊı
	
	static String filename	= "";//´¿ÎÄ¼şÃû£¬²»º¬Â·¾¶
	public static void main(String args[])
	{
		String sql = "";
		try
		{
			separator = JavaConst.separator;
			//CreateChart("A04.A0405");//A04.A0405,A04.A0440,A13.C1345,A01.A0107
			//CreatePhoto("select C0115 from A01 where id=15","photo.jpg");
			
			//sql=CreatePhoto("select * from A01 where id=115","d:\\computer file\\jsp\\JavaBean\\JavaBean\\CreateChart");
			//CreateChart("A01.A0141","2-3*4-5","Äê");
			String fname = "";
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","ÈËÔ±ĞÔ±ğ½á¹¹·ÖÎö","A01.A0107");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","Ñ§Àú½á¹¹·ÖÎö","A04.A0405");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","Ñ§Î»½á¹¹·ÖÎö","A04.A0440");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","Ö°³ÆµÈ¼¶·ÖÎö","A13.C1345");
			fname = CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","¹¤×÷ÄêÏŞ·ÖÎö","A01.A0141","1-2*4-9*10-20*other","Äê");
			System.out.print("\n" + fname + "\n");
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}		
	public String getShowdata()
	{
		return(this.showdata);	
	}
	public String getcitem()
	{
		return(this.citem);	
	}
	public int getcount()
	{
		return(this.count);	
	}
	/*********************************************************************\
	* Function£º GetFilename  
	* Purpose£ºÉú³ÉËæ»úÎÄ¼şÃû
	* Params:  paht:Éú³ÉÎÄ¼şµÄÂ·¾¶£¬extend£º¸ÃÎÄ¼şµÄÀ©Õ¹Ãû
	* Return£ºÒ»¸öËæ»úÉú³ÉµÄÎÄ¼şÃû(°üÀ¨Â·¾¶)
	* Remarks£º	
	**********************************************************************/
	private static String GetFilename(String path)//Éú³ÉËæ»úÎÄ¼şÃû(°üÀ¨Â·¾¶)
	{
		Random rd = new Random();
		String filenamepath = "";
		String num = "";//Éú³ÉµÄËæ»úÊı
		while(true)
		{
			num = Integer.toString(Math.abs(rd.nextInt()));
			filenamepath = path + "\\" + num + ".jpg";//Éú³ÉËæ»úÎÄ¼şÃû
			
			File f1 = new File(filenamepath);
			if (!f1.exists())//¸ÃÎÄ¼ş²»´æÔÚ
				break;	
		}
		filename = num + ".jpg";
		return (filenamepath);
	}
	/*********************************************************************\
	* Function£º CreatePhoto  
	* Purpose£º¸ù¾İsqlÓï¾äÉú³ÉÕÕÆ¬
	* Params:  sql£ºsqlÓï¾ä,path:Éú³ÉµÄÄ¿Â¼
	* Return£ºÒ»¸öËæ»úÉú³ÉµÄÎÄ¼şÃû
	* Remarks£º	
	**********************************************************************/
	public static String CreatePhoto(String sql,String path)
	{
		String fname = "";//Éú³ÉËæ»úÎÄ¼şÃû
		try
		{			
			ResultSet rs		= null;
			OperateDataBase odb	= new OperateDataBase();
			byte b1[]			= new byte[2048];
			rs					= odb.executeQuery(sql);
			
			if (rs.next())
			{
				b1 		= rs.getBytes("C0115");
				fname	= GetFilename(path);
				File f1	= new File(fname);
				FileOutputStream fout=new FileOutputStream(f1);
				fout.write(b1);
				fout.close();
			}	
			odb.destroy();
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"CreatePhoto");
		}
		return (filename);
	}
	
	public static Color GetChartItemColor(int i)
	{
		Color[] selectedColor = new Color[12];
		selectedColor[0] = Color.black;
		selectedColor[1] = Color.blue;
		selectedColor[2] = Color.cyan;
		selectedColor[3] = Color.darkGray;
		selectedColor[4] = Color.gray;
		selectedColor[5] = Color.green;
		selectedColor[6] = Color.lightGray;
		selectedColor[7] = Color.magenta;
		selectedColor[8] = Color.orange;
		selectedColor[9] = Color.pink;
		selectedColor[10] = Color.red;
		selectedColor[11] = Color.white;		
		return (selectedColor[i%11]);
	}
	/*********************************************************************\
	* Function£º CreateChart  
	* Purpose£º¶Ô·ÖÎöÊı¾İ½øĞĞ³õÊ¼»¯ 
	* Params:  tablename£º±íÃû.×Ö¶ÎÃû£
	* Return£º	ÎŞ
	* Remarks£º	
	**********************************************************************/
	public static void CreateChart(String tablename)
	{
		String code="",table=""/*±íÃû*/,field=""/*×Ö¶ÎÃû*/;
		String result_showdata="";
		String result_citem="";
		double lcount=0;/*»ñµÃ¸÷¸öÍ³¼ÆÏîÍ³¼Æ½á¹ûµÄºÍ£¬ËûÓëcountÏà¼õ»ñµÃÍ³¼Æ¹ı³ÌÖĞÆäËûÊı¾İµÄ¸öÊı*/;
		ResultSet rs=null;
		try
		{
			String temp="";
			double counts=0;//µ¥¸öÍ³¼ÆÏîµÄ¸öÊı
			double per=0.0;
				
			JavaConst jc=new JavaConst();
			OperateDataBase od=new OperateDataBase();
			OperateDataBase cod=new OperateDataBase();
			ClassNormal cn=new ClassNormal();
			
			separator=jc.separator;//»ñµÃ·Ö¸ô·û
			table=cn.getleft_rightstr(tablename,".",-1);/*±íÃû*/
			field=cn.getleft_rightstr(tablename,".",1);/*×Ö¶ÎÃû*/
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+table+"' and field_name='"+field+"'");
			count=Integer.parseInt(od.executeQuery_String("select count(*) from "+table));//»ñµÃ×ÜÈËÊı
					
			rs=od.executeQuery("select Idcode,Name from dataList where code='"+code+"'");
			while(rs.next())
			{
				String idcode=rs.getString("Idcode");
				String sdata=rs.getString("Name");
				
				counts=Double.parseDouble(cod.executeQuery_String("select count(*) from "+table+" where "+field+"='"+idcode+"'"));
				per=counts / count * 100;
				per=cn.get4_5(per,2);
				
				temp=Double.toString(counts);
				temp=temp.substring(0,temp.length()-2);
				result_showdata=result_showdata+
							sdata+"("+temp+"ÈË)"+Double.toString(per)+"%"+
							separator;
							
				temp=Double.toString(counts);
				temp=temp.substring(0,temp.length()-2);
				result_citem=result_citem+temp+separator;
				
				lcount=lcount+counts;
			}
			counts=count-lcount;//»ñµÃÆäËüÀàĞÍµÄÊı¾İµÄ¸öÊı
			per=counts / count * 100;
			per=cn.get4_5(per,2);
			temp=Double.toString(counts);
			temp=temp.substring(0,temp.length()-2);
			
			showdata=result_showdata+"ÆäËü"+"("+temp+"ÈË)"+Double.toString(per)+"%";

			temp=Double.toString(counts);
			temp=temp.substring(0,temp.length()-2);
			citem=result_citem+temp;

			od.destroy();
			cod.destroy();
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"CreateChart");
		}
	}	
	/*********************************************************************\
	* Function£º CreateAnalyzePicture  
	* Purpose£º¶ÔĞÔ±ğ½á¹¹£¬Ñ§Î»½á¹¹£¬Ñ§Àú½á¹¹£¬Ö°³ÆµÈ¼¶½øĞĞ·ÖÎö£¬Éú³É·ÖÎö½á¹ûµÄÍ¼Ïó
	* Params:  path:ÔÚÄÄ¸öÂ·¾¶ÏÂÉú³É£¬title£º·ÖÎö±êÌâ£¬tablefieldname£º·ÖÎöµÄ±íÃûºÍ×Ö¶ÎÃû
	* Return£º Éú³ÉµÄÍ¼ÏóµÄÃû×Ö 
	* Remarks£º	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//Éú³ÉËæ»úµÄÎÄ¼şÃû 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//×ÜÈËÊı
			double	countsingle=0;//µ¥¸öÍ³¼ÆÏîµÄ¸öÊı
			double 	lcount=0;/*»ñµÃ¸÷¸öÍ³¼ÆÏîÍ³¼Æ½á¹ûµÄºÍ£¬ËûÓëcountÏà¼õ»ñµÃÍ³¼Æ¹ı³ÌÖĞÆäËûÊı¾İµÄ¸öÊı*/;
			
			ResultSet rs=null;
			String code="";//¸Ã·ÖÎöÏîcode
			String temp="";
			double per=0.0;
			String sql="";
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//±íÃû
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//×Ö¶ÎÃû
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+tablename+"' and field_name='"+fieldname+"'");
			if (tablename.equals("A01"))
				sql="select count(*) from "+tablename;
			else
				sql="select count(*) from A01,"+tablename+" where A01.id="+tablename+".id";
				
			countall=Integer.parseInt(od.executeQuery_String(sql));//×ÜÈËÊı
			
			rs=od.executeQuery("select Idcode,Name from dataList where code='"+code+"'");
			//¿ªÊ¼»­Í¼/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"½á¹û",30,30);
			g.drawString("¹²Í³¼Æ£º"+Integer.toString(countall)+"ÈË",30,50);
			int c=1;
			int curAngle=0,totalAngle = 0;
			g.drawArc(x,y,xw,yh,0,360);
			
			//////////////////////////////////////////
			while (rs.next())
			{
				String idcode=rs.getString("Idcode");
				String name=rs.getString("Name");
				
				if (tablename.equals("A01"))
					sql="select count(*) from "+tablename+" where "+fieldname+"='"+idcode+"'";
				else
					sql="select count(*) from A01,"+tablename+" where "+fieldname+"='"+idcode+"' and A01.id="+tablename+".id";
					
				countsingle=Double.parseDouble(odinside.executeQuery_String(sql));
				//µ¥¸öÍ³¼ÆÏîµÄ¸öÊı
				
				per=countsingle / countall * 100;//»ñµÃ°Ù·Ö±È
				per=ClassNormal.get4_5(per,2);//±£Áô2Î»Ğ¡Êı				
								
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);
				
				lcount=lcount+countsingle;//Í³¼ÆµÄÈËÊı½øĞĞÀÛ¼Ó
				String word=name+"("+temp+"ÈË)"+Double.toString(per)+"%";//Éú³ÉÏÔÊ¾µÄÎÄ×Ö
				
				///¿ªÊ¼»­Í¼//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//ÉèÖÃÑÕÉ«
				g.fillRect(xword-30,yword*c-10,20,10);//»­Í¼Àı
				g.drawString(word,xword,yword*c);//Ğ´×Ö
				
				curAngle=(int)countsingle * 360 / countall;//ÉèÖÃ½Ç¶È
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//»­ÉÈĞÎ
				
				totalAngle=totalAngle+curAngle;
				c++;
				
			}
			//´¦Àí"ÆäËüÀàĞÍµÄÊı¾İ"µÄÇé¿ö
			if ((int)lcount<countall)
			{
				double ocount=countall-lcount;//»ñµÃÊ£ÓàµÄÈËÊı
				per=ocount / countall * 100;//»ñµÃ°Ù·Ö±È
				per=ClassNormal.get4_5(per,2);//±£Áô2Î»Ğ¡Êı
				
				temp=Double.toString(ocount);
				temp=temp.substring(0,temp.length()-2);
								
				String word="ÆäËü"+"("+temp+"ÈË)"+Double.toString(per)+"%";
				
				g.setColor(GetChartItemColor(c));//ÉèÖÃÑÕÉ«
				g.fillRect(xword-30,yword*c-10,20,10);//»­Í¼Àı
				g.drawString(word,xword,yword*c);//Ğ´×Ö
				
				g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//»­ÉÈĞÎ
			}
			od.destroy();
			odinside.destroy();
			g.setColor(oldcolor);
			
			JPEGImageEncoder jpg=JPEGCodec.createJPEGEncoder(fos);
			jpg.encode(myimage);
		}
		catch(Exception e)
		{
			String exceptionThrown = e.toString();
			String sourceOfException="Method";
			ErrorManage.DisplayError(e.getMessage(),"CreateAnalyzePicture");
		}
		return(filename);
	}
	/*********************************************************************\
	* Function£º CreateAnalyzePicture  
	* Purpose£º¶Ô¹¤×÷ÄêÏŞ£¬±¾¹«Ë¾¹¤×÷ÄêÏŞ£¬ÄêÁä½á¹¹£¬½øĞĞ·ÖÎö£¬Éú³É·ÖÎö½á¹ûµÄÍ¼Ïó
	* Params:  path:ÔÚÄÄ¸öÂ·¾¶ÏÂÉú³É£¬title£º·ÖÎö±êÌâ£¬tablefieldname£º·ÖÎöµÄ±íÃûºÍ×Ö¶ÎÃû,dataitems:¸÷¸ö·ÖÎöÊı¾İµÄ×éºÏ
	* Return£º Éú³ÉµÄÍ¼ÏóµÄÃû×Ö 
	* Remarks£º	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname,String dataitems,String year_old)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//Éú³ÉËæ»úµÄÎÄ¼şÃû 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//×ÜÈËÊı
			double	countsingle=0;//µ¥¸öÍ³¼ÆÏîµÄ¸öÊı
			
			int i=0;
			ResultSet rs=null;
			String temp="";
			double per=0.0;
			String sql="",sqlstr="";
			
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//±íÃû
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//×Ö¶ÎÃû
			
			sql="select count(*) from "+tablename;
			countall=Integer.parseInt(od.executeQuery_String(sql));//×ÜÈËÊı
			//¿ªÊ¼»­Í¼/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"½á¹û",30,30);
			g.drawString("¹²Í³¼Æ£º"+Integer.toString(countall)+"ÈË",30,50);
			
			int c=1;
			int curAngle=0,totalAngle = 0;
			g.drawArc(x,y,xw,yh,0,360);
			//////////////////////////////////////////
			while (true)
			{
				String single="";
				String bTime="",eTime="";
				
				i=dataitems.indexOf(separator);
				if (i<0)
				{
					if (totalAngle<360)
					{
						sqlstr="select count(*) from "+tablename+" where not(" +sqlstr.substring(0,sqlstr.length()-3) +")";
						countsingle=Double.parseDouble(odinside.executeQuery_String(sqlstr));//»ñµÃÈËÊı
						
						per=countsingle / countall * 100;//»ñµÃ°Ù·Ö±È
						per=ClassNormal.get4_5(per,2);//±£Áô2Î»Ğ¡Êı
						
						temp=Double.toString(countsingle);
						temp=temp.substring(0,temp.length()-2);
													
						String word="ÆäËü"+"("+temp+"ÈË)"+Double.toString(per)+"%";
						
						g.setColor(GetChartItemColor(c));//ÉèÖÃÑÕÉ«
						g.fillRect(xword-30,yword*c-10,20,10);//»­Í¼Àı
						g.drawString(word,xword,yword*c);//Ğ´×Ö
						
						g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//»­ÉÈĞÎ
					}
					break;
				}
				single=dataitems.substring(0,i);//»ñµÃ£º1-2
				
				bTime=ClassNormal.getleft_rightstr(single,"-",-1);//»ñµÃ1
				eTime=ClassNormal.getleft_rightstr(single,"-",1);//»ñµÃ2
				
				sql="select count(*) from "+tablename+" where Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime;
				sqlstr=sqlstr+" (Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime+") or ";
				
				countsingle=Double.parseDouble(odinside.executeQuery_String(sql));//»ñµÃÈËÊı
				
				per=countsingle / countall *100;//»ñµÃ°Ù·Ö±È
				per=ClassNormal.get4_5(per,2);//±£ÁôÁ½Î»Ğ¡Êı
				
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);//³ıÈ¥Ğ¡Êı²¿·Ö
								
				String word=single+year_old+"("+temp+"ÈË)"+Double.toString(per)+"%";//Éú³ÉÏÔÊ¾µÄÎÄ×Ö
				dataitems=dataitems.substring(i+1,dataitems.length());
				///¿ªÊ¼»­Í¼//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//ÉèÖÃÑÕÉ«
				g.fillRect(xword-30,yword*c-10,20,10);//»­Í¼Àı
				g.drawString(word,xword,yword*c);//Ğ´×Ö
				
				curAngle=(int)countsingle * 360 / countall;//ÉèÖÃ½Ç¶È
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//»­ÉÈĞÎ
				
				totalAngle=totalAngle+curAngle;
				c++;
			}
			od.destroy();
			odinside.destroy();
			g.setColor(oldcolor);
			
			JPEGImageEncoder jpg=JPEGCodec.createJPEGEncoder(fos);
			jpg.encode(myimage);
		}
		catch(Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"CreateAnalyzePicture");
		}
		return(filename);
	}
}
