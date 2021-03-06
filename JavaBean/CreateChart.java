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
	static String showdata	= ""/*保存各个分析项*/;
	static String citem		= ""/*保存对应的项目的人数*/;
	static int count		= 0;//总人数
	
	static String filename	= "";//纯文件名，不含路径
	public static void main(String args[])
	{
		String sql = "";
		try
		{
			separator = JavaConst.separator;
			//CreateChart("A04.A0405");//A04.A0405,A04.A0440,A13.C1345,A01.A0107
			//CreatePhoto("select C0115 from A01 where id=15","photo.jpg");
			
			//sql=CreatePhoto("select * from A01 where id=115","d:\\computer file\\jsp\\JavaBean\\JavaBean\\CreateChart");
			//CreateChart("A01.A0141","2-3*4-5","年");
			String fname = "";
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","人员性别结构分析","A01.A0107");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","学历结构分析","A04.A0405");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","学位结构分析","A04.A0440");
			//fname=CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","职称等级分析","A13.C1345");
			fname = CreateAnalyzePicture("D:\\computer file\\Java\\JavaBean\\JavaBean\\CreateChart","工作年限分析","A01.A0141","1-2*4-9*10-20*other","年");
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
	* Function： GetFilename  
	* Purpose：生成随机文件名
	* Params:  paht:生成文件的路径，extend：该文件的扩展名
	* Return：一个随机生成的文件名(包括路径)
	* Remarks：	
	**********************************************************************/
	private static String GetFilename(String path)//生成随机文件名(包括路径)
	{
		Random rd = new Random();
		String filenamepath = "";
		String num = "";//生成的随机数
		while(true)
		{
			num = Integer.toString(Math.abs(rd.nextInt()));
			filenamepath = path + "\\" + num + ".jpg";//生成随机文件名
			
			File f1 = new File(filenamepath);
			if (!f1.exists())//该文件不存在
				break;	
		}
		filename = num + ".jpg";
		return (filenamepath);
	}
	/*********************************************************************\
	* Function： CreatePhoto  
	* Purpose：根据sql语句生成照片
	* Params:  sql：sql语句,path:生成的目录
	* Return：一个随机生成的文件名
	* Remarks：	
	**********************************************************************/
	public static String CreatePhoto(String sql,String path)
	{
		String fname = "";//生成随机文件名
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
	* Function： CreateChart  
	* Purpose：对分析数据进行初始化 
	* Params:  tablename：表名.字段名�
	* Return：	无
	* Remarks：	
	**********************************************************************/
	public static void CreateChart(String tablename)
	{
		String code="",table=""/*表名*/,field=""/*字段名*/;
		String result_showdata="";
		String result_citem="";
		double lcount=0;/*获得各个统计项统计结果的和，他与count相减获得统计过程中其他数据的个数*/;
		ResultSet rs=null;
		try
		{
			String temp="";
			double counts=0;//单个统计项的个数
			double per=0.0;
				
			JavaConst jc=new JavaConst();
			OperateDataBase od=new OperateDataBase();
			OperateDataBase cod=new OperateDataBase();
			ClassNormal cn=new ClassNormal();
			
			separator=jc.separator;//获得分隔符
			table=cn.getleft_rightstr(tablename,".",-1);/*表名*/
			field=cn.getleft_rightstr(tablename,".",1);/*字段名*/
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+table+"' and field_name='"+field+"'");
			count=Integer.parseInt(od.executeQuery_String("select count(*) from "+table));//获得总人数
					
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
							sdata+"("+temp+"人)"+Double.toString(per)+"%"+
							separator;
							
				temp=Double.toString(counts);
				temp=temp.substring(0,temp.length()-2);
				result_citem=result_citem+temp+separator;
				
				lcount=lcount+counts;
			}
			counts=count-lcount;//获得其它类型的数据的个数
			per=counts / count * 100;
			per=cn.get4_5(per,2);
			temp=Double.toString(counts);
			temp=temp.substring(0,temp.length()-2);
			
			showdata=result_showdata+"其它"+"("+temp+"人)"+Double.toString(per)+"%";

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
	* Function： CreateAnalyzePicture  
	* Purpose：对性别结构，学位结构，学历结构，职称等级进行分析，生成分析结果的图象
	* Params:  path:在哪个路径下生成，title：分析标题，tablefieldname：分析的表名和字段名
	* Return： 生成的图象的名字 
	* Remarks：	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//生成随机的文件名 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//总人数
			double	countsingle=0;//单个统计项的个数
			double 	lcount=0;/*获得各个统计项统计结果的和，他与count相减获得统计过程中其他数据的个数*/;
			
			ResultSet rs=null;
			String code="";//该分析项code
			String temp="";
			double per=0.0;
			String sql="";
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//表名
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//字段名
			
			code=od.executeQuery_String("select code from BasInfTFMenu where table_name='"+tablename+"' and field_name='"+fieldname+"'");
			if (tablename.equals("A01"))
				sql="select count(*) from "+tablename;
			else
				sql="select count(*) from A01,"+tablename+" where A01.id="+tablename+".id";
				
			countall=Integer.parseInt(od.executeQuery_String(sql));//总人数
			
			rs=od.executeQuery("select Idcode,Name from dataList where code='"+code+"'");
			//开始画图/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"结果",30,30);
			g.drawString("共统计："+Integer.toString(countall)+"人",30,50);
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
				//单个统计项的个数
				
				per=countsingle / countall * 100;//获得百分比
				per=ClassNormal.get4_5(per,2);//保留2位小数				
								
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);
				
				lcount=lcount+countsingle;//统计的人数进行累加
				String word=name+"("+temp+"人)"+Double.toString(per)+"%";//生成显示的文字
				
				///开始画图//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//设置颜色
				g.fillRect(xword-30,yword*c-10,20,10);//画图例
				g.drawString(word,xword,yword*c);//写字
				
				curAngle=(int)countsingle * 360 / countall;//设置角度
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//画扇形
				
				totalAngle=totalAngle+curAngle;
				c++;
				
			}
			//处理"其它类型的数据"的情况
			if ((int)lcount<countall)
			{
				double ocount=countall-lcount;//获得剩余的人数
				per=ocount / countall * 100;//获得百分比
				per=ClassNormal.get4_5(per,2);//保留2位小数
				
				temp=Double.toString(ocount);
				temp=temp.substring(0,temp.length()-2);
								
				String word="其它"+"("+temp+"人)"+Double.toString(per)+"%";
				
				g.setColor(GetChartItemColor(c));//设置颜色
				g.fillRect(xword-30,yword*c-10,20,10);//画图例
				g.drawString(word,xword,yword*c);//写字
				
				g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//画扇形
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
	* Function： CreateAnalyzePicture  
	* Purpose：对工作年限，本公司工作年限，年龄结构，进行分析，生成分析结果的图象
	* Params:  path:在哪个路径下生成，title：分析标题，tablefieldname：分析的表名和字段名,dataitems:各个分析数据的组合
	* Return： 生成的图象的名字 
	* Remarks：	
	**********************************************************************/
	public static String CreateAnalyzePicture(String path,String title,String tablefieldname,String dataitems,String year_old)
	{
		String fpath="";
		try
		{
			fpath=GetFilename(path);//生成随机的文件名 
			FileOutputStream fos=new FileOutputStream(fpath);
			BufferedImage myimage=new BufferedImage(500,500,BufferedImage.TYPE_INT_RGB);
			Graphics g=myimage.getGraphics();
			
			OperateDataBase od=new OperateDataBase();
			OperateDataBase odinside=new OperateDataBase();
			int 	countall=0;//总人数
			double	countsingle=0;//单个统计项的个数
			
			int i=0;
			ResultSet rs=null;
			String temp="";
			double per=0.0;
			String sql="",sqlstr="";
			
			separator=JavaConst.separator;
			
			String tablename=ClassNormal.getleft_rightstr(tablefieldname,".",-1);//表名
			String fieldname=ClassNormal.getleft_rightstr(tablefieldname,".",1);//字段名
			
			sql="select count(*) from "+tablename;
			countall=Integer.parseInt(od.executeQuery_String(sql));//总人数
			//开始画图/////////////////////////////////
			int xword=320,yword=30;
			int x=50,y=100,xw=200,yh=200;
			
			Color oldcolor;
			oldcolor=g.getColor();
			g.setColor(Color.white);
			g.fillRect(0,0,500,500);
			g.setColor(Color.BLACK);
			g.drawString(title+"结果",30,30);
			g.drawString("共统计："+Integer.toString(countall)+"人",30,50);
			
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
						countsingle=Double.parseDouble(odinside.executeQuery_String(sqlstr));//获得人数
						
						per=countsingle / countall * 100;//获得百分比
						per=ClassNormal.get4_5(per,2);//保留2位小数
						
						temp=Double.toString(countsingle);
						temp=temp.substring(0,temp.length()-2);
													
						String word="其它"+"("+temp+"人)"+Double.toString(per)+"%";
						
						g.setColor(GetChartItemColor(c));//设置颜色
						g.fillRect(xword-30,yword*c-10,20,10);//画图例
						g.drawString(word,xword,yword*c);//写字
						
						g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//画扇形
					}
					break;
				}
				single=dataitems.substring(0,i);//获得：1-2
				
				bTime=ClassNormal.getleft_rightstr(single,"-",-1);//获得1
				eTime=ClassNormal.getleft_rightstr(single,"-",1);//获得2
				
				sql="select count(*) from "+tablename+" where Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime;
				sqlstr=sqlstr+" (Year(GETDATE()) - YEAR("+fieldname+")>="+bTime+" and Year(GETDATE()) - YEAR("+fieldname+")<="+eTime+") or ";
				
				countsingle=Double.parseDouble(odinside.executeQuery_String(sql));//获得人数
				
				per=countsingle / countall *100;//获得百分比
				per=ClassNormal.get4_5(per,2);//保留两位小数
				
				temp=Double.toString(countsingle);
				temp=temp.substring(0,temp.length()-2);//除去小数部分
								
				String word=single+year_old+"("+temp+"人)"+Double.toString(per)+"%";//生成显示的文字
				dataitems=dataitems.substring(i+1,dataitems.length());
				///开始画图//////////////////////////////////////////
				g.setColor(GetChartItemColor(c));//设置颜色
				g.fillRect(xword-30,yword*c-10,20,10);//画图例
				g.drawString(word,xword,yword*c);//写字
				
				curAngle=(int)countsingle * 360 / countall;//设置角度
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//画扇形
				
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
