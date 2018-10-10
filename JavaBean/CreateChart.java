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
	static String showdata	= ""/*�������������*/;
	static String citem		= ""/*�����Ӧ����Ŀ������*/;
	static int count		= 0;//������
	
	static String filename	= "";//���ļ���������·��
	public static void main(String args[])
	{
		String sql = "";
		try
		{
			separator = JavaConst.separator;
			//CreateChart("A04.A0405");//A04.A0405,A04.A0440,A13.C1345,A01.A0107
			//CreatePhoto("select C0115 from A01 where id=15","photo.jpg");
			
			//sql=CreatePhoto("select * from A01 where id=115","d:\\computer file\\jsp\\JavaBean\\JavaBean\\CreateChart");
			//CreateChart("A01.A0141","2-3*4-5","��");
			String fname = "";
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","��Ա�Ա�ṹ����","A01.A0107");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","ѧ���ṹ����","A04.A0405");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","ѧλ�ṹ����","A04.A0440");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","ְ�Ƶȼ�����","A13.C1345");
			fname = CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","�������޷���","A01.A0141","1-2*4-9*10-20*other","��");
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
	* Function�� GetFilename  
	* Purpose����������ļ���
	* Params:  paht:�����ļ���·����extend�����ļ�����չ��
	* Return��һ��������ɵ��ļ���(����·��)
	* Remarks��	
	**********************************************************************/
	private static String GetFilename(String path)//��������ļ���(����·��)
	{
		Random rd = new Random();
		String filenamepath = "";
		String num = "";//���ɵ������
		while(true)
		{
			num = Integer.toString(Math.abs(rd.nextInt()));
			filenamepath = path + "\\" + num + ".jpg";//��������ļ���
			
			File f1 = new File(filenamepath);
			if (!f1.exists())//���ļ�������
				break;	
		}
		filename = num + ".jpg";
		return (filenamepath);
	}
	/*********************************************************************\
	* Function�� CreatePhoto  
	* Purpose������sql���������Ƭ
	* Params:  sql��sql���,path:���ɵ�Ŀ¼
	* Return��һ��������ɵ��ļ���
	* Remarks��	
	**********************************************************************/
	public static String CreatePhoto(String sql,String path)
	{
		String fname = "";//��������ļ���
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
	* Function�� CreateChart  
	* Purpose���Է������ݽ��г�ʼ�� 
	* Params:  tablename������.�ֶ����
	* Return��	��
	* Remarks��	
	**********************************************************************/
	public static void CreateChart(String tablename)
	{
		String code="",table=""/*����*/,field=""/*�ֶ���*/;
		String result_showdata="";
		String result_citem="";
		double lcount=0;/*��ø���ͳ����ͳ�ƽ���ĺͣ�����count������ͳ�ƹ������������ݵĸ���*/;
		ResultSet rs=null;
		try
		{
			String temp="";
			double counts=0;//����ͳ����ĸ���
			double per=0.0;
				
			JavaConst jc=new JavaConst();
			OperateDataBase od=new OperateDataBase();
			OperateDataBase cod=new OperateDataBase();
			ClassNormal cn=new ClassNormal();
			
			separator=jc.separator;//��÷ָ���
			table=cn.getleft_rightstr(tablename,".",-1);/*����*/
			field=cn.getleft_rightstr(tablename,".",1);/*�ֶ���*/
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+table+"' and field_name='"+field+"'");
			count=Integer.parseInt(od.executeQuery_String("select count(*) from "+table));//���������
					
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
							sdata+"("+temp+"��)"+Double.toString(per)+"%"+
							separator;
							
				temp=Double.toString(counts);
				temp=temp.substring(0,temp.length()-2);
				result_citem=result_citem+temp+separator;
				
				lcount=lcount+counts;
			}
			counts=count-lcount;//����������͵����ݵĸ���
			per=counts / count * 100;
			per=cn.get4_5(per,2);
			temp=Double.toString(counts);
			temp=temp.substring(0,temp.length()-2);
			
			showdata=result_showdata+"����"+"("+temp+"��)"+Double.toString(per)+"%";

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
	* Function�� CreateAnalyzePicture  
	* Purpose�����Ա�ṹ��ѧλ�ṹ��ѧ���ṹ��ְ�Ƶȼ����з��������ɷ��������ͼ��
	* Params:  path:���ĸ�·�������ɣ�title���������⣬tablefieldname�������ı������ֶ���
	* Return�� ���ɵ�ͼ������� 
	* Remarks��	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//����������ļ��� 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//������
			double	countsingle=0;//����ͳ����ĸ���
			double 	lcount=0;/*��ø���ͳ����ͳ�ƽ���ĺͣ�����count������ͳ�ƹ������������ݵĸ���*/;
			
			ResultSet rs=null;
			String code="";//�÷�����code
			String temp="";
			double per=0.0;
			String sql="";
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//����
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//�ֶ���
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+tablename+"' and field_name='"+fieldname+"'");
			if (tablename.equals("A01"))
				sql="select count(*) from "+tablename;
			else
				sql="select count(*) from A01,"+tablename+" where A01.id="+tablename+".id";
				
			countall=Integer.parseInt(od.executeQuery_String(sql));//������
			
			rs=od.executeQuery("select Idcode,Name from dataList where code='"+code+"'");
			//��ʼ��ͼ/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"���",30,30);
			g.drawString("��ͳ�ƣ�"+Integer.toString(countall)+"��",30,50);
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
				//����ͳ����ĸ���
				
				per=countsingle / countall * 100;//��ðٷֱ�
				per=ClassNormal.get4_5(per,2);//����2λС��				
								
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);
				
				lcount=lcount+countsingle;//ͳ�Ƶ����������ۼ�
				String word=name+"("+temp+"��)"+Double.toString(per)+"%";//������ʾ������
				
				///��ʼ��ͼ//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//������ɫ
				g.fillRect(xword-30,yword*c-10,20,10);//��ͼ��
				g.drawString(word,xword,yword*c);//д��
				
				curAngle=(int)countsingle * 360 / countall;//���ýǶ�
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//������
				
				totalAngle=totalAngle+curAngle;
				c++;
				
			}
			//����"�������͵�����"�����
			if ((int)lcount<countall)
			{
				double ocount=countall-lcount;//���ʣ�������
				per=ocount / countall * 100;//��ðٷֱ�
				per=ClassNormal.get4_5(per,2);//����2λС��
				
				temp=Double.toString(ocount);
				temp=temp.substring(0,temp.length()-2);
								
				String word="����"+"("+temp+"��)"+Double.toString(per)+"%";
				
				g.setColor(GetChartItemColor(c));//������ɫ
				g.fillRect(xword-30,yword*c-10,20,10);//��ͼ��
				g.drawString(word,xword,yword*c);//д��
				
				g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//������
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
	* Function�� CreateAnalyzePicture  
	* Purpose���Թ������ޣ�����˾�������ޣ�����ṹ�����з��������ɷ��������ͼ��
	* Params:  path:���ĸ�·�������ɣ�title���������⣬tablefieldname�������ı������ֶ���,dataitems:�����������ݵ����
	* Return�� ���ɵ�ͼ������� 
	* Remarks��	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname,String dataitems,String year_old)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//����������ļ��� 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//������
			double	countsingle=0;//����ͳ����ĸ���
			
			int i=0;
			ResultSet rs=null;
			String temp="";
			double per=0.0;
			String sql="",sqlstr="";
			
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//����
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//�ֶ���
			
			sql="select count(*) from "+tablename;
			countall=Integer.parseInt(od.executeQuery_String(sql));//������
			//��ʼ��ͼ/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"���",30,30);
			g.drawString("��ͳ�ƣ�"+Integer.toString(countall)+"��",30,50);
			
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
						countsingle=Double.parseDouble(odinside.executeQuery_String(sqlstr));//�������
						
						per=countsingle / countall * 100;//��ðٷֱ�
						per=ClassNormal.get4_5(per,2);//����2λС��
						
						temp=Double.toString(countsingle);
						temp=temp.substring(0,temp.length()-2);
													
						String word="����"+"("+temp+"��)"+Double.toString(per)+"%";
						
						g.setColor(GetChartItemColor(c));//������ɫ
						g.fillRect(xword-30,yword*c-10,20,10);//��ͼ��
						g.drawString(word,xword,yword*c);//д��
						
						g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//������
					}
					break;
				}
				single=dataitems.substring(0,i);//��ã�1-2
				
				bTime=ClassNormal.getleft_rightstr(single,"-",-1);//���1
				eTime=ClassNormal.getleft_rightstr(single,"-",1);//���2
				
				sql="select count(*) from "+tablename+" where Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime;
				sqlstr=sqlstr+" (Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime+") or ";
				
				countsingle=Double.parseDouble(odinside.executeQuery_String(sql));//�������
				
				per=countsingle / countall *100;//��ðٷֱ�
				per=ClassNormal.get4_5(per,2);//������λС��
				
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);//��ȥС������
								
				String word=single+year_old+"("+temp+"��)"+Double.toString(per)+"%";//������ʾ������
				dataitems=dataitems.substring(i+1,dataitems.length());
				///��ʼ��ͼ//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//������ɫ
				g.fillRect(xword-30,yword*c-10,20,10);//��ͼ��
				g.drawString(word,xword,yword*c);//д��
				
				curAngle=(int)countsingle * 360 / countall;//���ýǶ�
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//������
				
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
