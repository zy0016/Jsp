//package JavaBean.ChartApplet;

import JavaBean.JavaConst.*;
import JavaBean.ClassNormal.*;
import JavaBean.CreateChart.*;

import java.awt.*;
import java.applet.Applet;

public class ChartApplet extends Applet
{
	String separator="*";
	String label="";
	String count="";//总人数
	String showdata=""/*保存显示数据*/,citem=""/*各个项目有多少人*/;
	String debugstr="";
	public void init()//生成分析结果的Applet
	{
		label=getParameter("label");
		count=getParameter("count");
		showdata=getParameter("showdata");
		citem=getParameter("citem");
	}
	public String getcount()
	{
		return (this.debugstr);	
	}
	public static Color GetChartItemColor(int i)
	{
		Color[] selectedColor=new Color[12];
		selectedColor[0] = Color.black;
		selectedColor[1] = Color.blue;
		selectedColor[2] = Color.cyan;
		selectedColor[3] = Color.darkGray;
		selectedColor[4] = Color.gray;
		selectedColor[5] = Color.green;
		selectedColor[6] = Color.yellow;
		selectedColor[7] = Color.magenta;
		selectedColor[8] = Color.orange;
		selectedColor[9] = Color.pink;
		selectedColor[10] = Color.red;
		selectedColor[11] = Color.white;
		
		return (selectedColor[i%11]);
		
	}
	public void paint(Graphics g)	
	{
		String table="";
		String field="";
		String num="";
		int icount=0/*获得单个统计项的数量*/,lcount=0/*获得各个统计项统计结果的和，他与count相减获得统计过程中其他数据的个数*/;
		int xword=350,yword=30;
		int x=50,y=100,xw=200,yh=200;
		String showdatap=showdata;
		String citemp=citem;
		
		try
		{
			g.drawString(label+"结果",30,30);
			g.drawString("共统计："+count+"人",30,50);
			int i=0,j=0,c=1;
			int curAngle=0,totalAngle = 0;
			String sdata="";
			String sitem="";
			g.drawArc(x,y,xw,yh,0,360);
			
			Color oldcolor;
			oldcolor=g.getColor();
						
			while(true)
			{
				i=showdatap.indexOf(separator);
				j=citemp.indexOf(separator);
				if (i==-1)
				{
					if (totalAngle<360)
					{
						g.setColor(GetChartItemColor(c));//设置颜色
						g.fillRect(xword-30,yword*c-10,20,10);//画图例
						g.drawString(showdatap,xword,yword*c);//写字
						
						g.fillArc(x,y,xw,yh,totalAngle,360-totalAngle);//画扇形
					}
					break;	
				}
				sdata=showdatap.substring(0,i);
				sitem=citemp.substring(0,j);//获得人数
				
				g.setColor(GetChartItemColor(c));//设置颜色
				g.fillRect(xword-30,yword*c-10,20,10);//画图例
				g.drawString(sdata,xword,yword*c);//写字
				
				curAngle=Integer.parseInt(sitem) * 360 / Integer.parseInt(count);//设置角度
				g.fillArc(x,y,xw,yh,totalAngle,curAngle);//画扇形
				
				showdatap=showdatap.substring(i+1,showdatap.length());
				citemp=citemp.substring(j+1,citemp.length());
				
				totalAngle=totalAngle+curAngle;
				c++;
			}
			g.setColor(oldcolor);
		}
		catch(Exception ex)
		{
			System.out.println(ex.getMessage());
			debugstr=showdatap;
		}
	}
}