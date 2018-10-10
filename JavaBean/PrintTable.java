package JavaBean.PrintTable;
import java.sql.*;
import java.io.*;
import JavaBean.OperateDataBase.*;
import JavaBean.ErrorManage.*;

public abstract class PrintTable 
{
	public		String				accountname = "";
	//*******************以下属性是表格参数列表******************
	private		String				TClass = "";
	private		String				ID = "";
	private		String				Style = "";
	private		String				Title = "";
	private		String				Border = "";
	private		String				BorderColor = "";
	private		String				Alignment = "";
	private		String				Width = "";
	private		String				Height = "";
	private		String				CellPadding = "";
	private		String				CellSpacing = "";
	private		String				BackgroundColor = "";
	private		String				BackgroundImage = "";
	//*******************表格参数列表结束**************************
	//*******************以下参数是表格标题参数列表****************
	private		String				TR_HAlign = "";
	private		String				TR_HValign = "";
	private		String				TR_HBackgroundColor = "";
	private		String				TR_HBordercolor = "";
	private		String				TR_HBordercolorlight = "";
	private		String				TR_HBordercolordark = "";
	private		String				TR_HHeight = "";
	private		String				TR_Hnowrap = "";
	private		String				TR_HClass = "";
	private		String				TR_HID = "";
	private		String				TR_HStyle = "";
	private		String				TR_HTitle = "";
	//*******************表格标题参数列表结束**********************
	//*******************以下参数是表格奇数行参数列表****************
	private		String				TR_OAlign = "";
	private		String				TR_OValign = "";
	private		String				TR_OBackgroundColor = "";
	private		String				TR_OBordercolor = "";
	private		String				TR_OBordercolorlight = "";
	private		String				TR_OBordercolordark = "";
	private		String				TR_OHeight = "";
	private		String				TR_Onowrap = "";
	private		String				TR_OClass = "";
	private		String				TR_OID = "";
	private		String				TR_OStyle = "";
	private		String				TR_OTitle = "";
	//*******************表格奇数行参数列表结束**********************
	//*******************以下参数是表格偶数行参数列表****************
	private		String				TR_EAlign = "";
	private		String				TR_EValign = "";
	private		String				TR_EBackgroundColor = "";
	private		String				TR_EBordercolor = "";
	private		String				TR_EBordercolorlight = "";
	private		String				TR_EBordercolordark = "";
	private		String				TR_EHeight = "";
	private		String				TR_Enowrap = "";
	private		String				TR_EClass = "";
	private		String				TR_EID = "";
	private		String				TR_EStyle = "";
	private		String				TR_ETitle = "";
	//*******************表格偶数行参数列表结束**********************
	private		String				Tparam = "";//表格参数
	private		String				TR_Hparam = "";//表格标题参数
	private		String				TR_Oparam = "";//奇数行参数
	private		String				TR_Eparam = "";//偶数行参数
	private		ResultSet			rs = null;
	private		ResultSetMetaData	rsmd = null;//声明接口对象
	
	public static void main(String args[])
	{
	}
	public void PrintTable()
	{}
	/*********************************************************************\
	* Function： InitPrintTable  
	* Purpose：打印表格的初始化工作
	* Params:  sql:SQL语句
	* Return：
	* Remarks：	
	**********************************************************************/
	protected void InitPrintTable(String sql) 
	{
		try
		{
			OperateDataBase odb = new OperateDataBase();
			rs					= odb.executeQuery(sql); 
			rsmd 				= rs.getMetaData();//不仅需要返回列数,还需要返回列名
			
			Tparam = 	TClass 					+ 
						ID						+ 
						Style					+ 
						Title					+ 
						Border					+ 
						BorderColor				+
						Alignment				+ 
						Width					+ 
						Height					+ 
						CellPadding				+ 
						CellSpacing				+ 
						BackgroundColor			+ 
						BackgroundImage			+
						"";
			
			TR_Hparam =	TR_HAlign				+
						TR_HValign				+
						TR_HBackgroundColor		+
						TR_HBordercolor			+
						TR_HBordercolorlight	+
						TR_HBordercolordark		+
						TR_HHeight				+
						TR_Hnowrap				+
						TR_HClass				+
						TR_HID					+
						TR_HStyle				+
						TR_HTitle				+
						"";
						
			TR_Oparam =	TR_OAlign				+
						TR_OValign				+
						TR_OBackgroundColor		+
						TR_OBordercolor			+
						TR_OBordercolorlight	+
						TR_OBordercolordark		+
						TR_OHeight				+
						TR_Onowrap				+
						TR_OClass				+
						TR_OID					+
						TR_OStyle				+
						TR_OTitle				+
						"";
						
			TR_Eparam =	TR_EAlign				+
						TR_EValign				+
						TR_EBackgroundColor		+
						TR_EBordercolor			+
						TR_EBordercolorlight	+
						TR_EBordercolordark		+
						TR_EHeight				+
						TR_Enowrap				+
						TR_EClass				+
						TR_EID					+
						TR_EStyle				+
						TR_ETitle				+
						"";
		}
		catch(Exception e)
		{
			ErrorManage.SaveError(accountname,"PrintTable",e.toString(),e.getMessage(),"执行失败");
		}
	}
	
	protected String GetParam()
	{
		return (this.Tparam);
	}
	protected String GetTR_Hparam()
	{
		return (this.TR_Hparam);
	}
	protected String GetTR_Oparam()
	{
		return (this.TR_Oparam);
	}
	protected String GetTR_Eparam()
	{
		return (this.TR_Eparam);
	}

	protected ResultSet GetResultSet()
	{
		return (this.rs);
	}
	protected ResultSetMetaData GetResultSetMetaData()
	{
		return (this.rsmd);
	}

	final protected void destory()//这个方法不能被子类重载
	{
		try
		{
			rs.close();
		}
		catch(Exception e)
		{
			ErrorManage.SaveError(accountname,"destory",e.toString(),e.getMessage(),"资源释放失败");
		}
	}
	
	final protected boolean OutString(String str,String filepath)
	{
		boolean result;
		try
		{
			PrintWriter pnt = new PrintWriter(new FileOutputStream(filepath,false));
			pnt.println(str);//输出结果
			pnt.close();
			result = true;
		}
		catch(Exception e)//发生 I/O 错误，如磁盘错误
		{
			System.out.println(e.toString()+" "+e.getMessage());
			result = false;
		}
		return (result);
	}
	public abstract String WriteTable(String sql);//声明抽象方法
//********************************************************************************
	public void setClass(String tclass)
	{
		if (tclass.length() > 0)
			TClass = " class = \"" + tclass + "\"";
	}
	public void setID(String id)
	{
		if (id.length() > 0)
			ID = " id = \"" + id + "\"";
	}
	public void setStyle(String style)
	{
		if (style.length() > 0)
			Style = " style = \"" + style + "\"";
	}
	public void setTitle(String title)
	{
		if (title.length() > 0)
			Title = " title = \"" + title + "\"";
	}
	public void setBorder(String border)
	{
		if (border.length() > 0)
			Border = " border = \"" + border + "\"";
	}
	public void setBorderColor(String bordercolor)
	{
		if (bordercolor.length() > 0)
			BorderColor = " border = \"" + bordercolor + "\"";
	}
	public void setAlignment(String alignment)
	{
		if (alignment.length() > 0)
			Alignment = " align = \"" + alignment + "\"";
	}
	public void setWidth(String width)
	{
		if (width.length() > 0)
			Width = " width = \"" + width + "\"";
	}
	public void setHeight(String height)
	{
		if (height.length() > 0)
			Height = " height = \"" + height + "\"";
	}
	public void setCellpadding(String cellpadding)
	{
		if (cellpadding.length() > 0)
			CellPadding = " cellpadding = \"" + cellpadding + "\"";
	}
	public void setCellSpacing(String cellspacing)
	{
		if (cellspacing.length() > 0)
			CellSpacing = " cellspacing = \"" + cellspacing + "\"";
	}
	public void setBackgroundColor(String backgroundColor)
	{
		if (backgroundColor.length() > 0)
			BackgroundColor = " bgcolor = \"" + backgroundColor + "\"";
	}
	public void setBackgroundImage(String backgroundimage)
	{
		if (backgroundimage.length() > 0)
			BackgroundImage = " background = \"" + backgroundimage + "\"";
	}

	public String getTClass()
	{
		return (this.TClass);
	}
	public String getID()
	{
		return (this.ID);
	}
	public String getStyle()
	{
		return (this.Style);
	}
	public String getTitle()
	{
		return (this.Title);
	}
	public String getBorder()
	{
		return (this.Border);
	}
	public String getAlignment()
	{
		return (this.Alignment);
	}
	public String getWidth()
	{
		return (this.Width);
	}
	public String getHeight()
	{
		return (this.Height);
	}
	public String getCellpadding()
	{
		return (this.CellPadding);
	}
	public String getCellSpacing()
	{
		return (this.CellSpacing);
	}
	public String getBackgroundColor()
	{
		return (this.BackgroundColor);
	}
	public String getBackgroundImage()
	{
		return (this.BackgroundImage);
	}
//*********************************************************************
	public void setTR_HAlign(String tr_halign) 
	{
		if (tr_halign.length() > 0)
			this.TR_HAlign = " align = \"" + tr_halign + "\""; 
	}
	public void setTR_HValign(String tr_hvalign) 
	{
		if (tr_hvalign.length() > 0)
			this.TR_HValign = " valign = \"" + tr_hvalign + "\""; 
	}
	public void setTR_HBackgroundColor(String tr_hbackgroundcolor) 
	{
		if (tr_hbackgroundcolor.length() > 0)
			this.TR_HBackgroundColor = " bgcolor = \"" + tr_hbackgroundcolor + "\""; 
	}
	public void setTR_HBordercolor(String tr_hbordercolor) 
	{
		if (tr_hbordercolor.length() > 0)
			this.TR_HBordercolor = " bordercolor = \"" + tr_hbordercolor + "\""; 
	}
	public void setTR_HBordercolorlight(String tr_hbordercolorlight) 
	{
		if (tr_hbordercolorlight.length() > 0)
			this.TR_HBordercolorlight = " bordercolorlight = \"" + tr_hbordercolorlight + "\""; 
	}
	public void setTR_HBordercolordark(String tr_hbordercolordark) 
	{
		if (tr_hbordercolordark.length() > 0)
			this.TR_HBordercolordark = " bordercolordark = \"" + tr_hbordercolordark + "\""; 
	}
	public void setTR_HHeight(String tr_hheight) 
	{
		if (tr_hheight.length() > 0)
			this.TR_HHeight = " height = \"" + tr_hheight + "\""; 
	}
	public void setTR_Hnowrap(String tr_hnowrap) 
	{
		if (tr_hnowrap.length() > 0)
			this.TR_Hnowrap = " " + tr_hnowrap; 
	}
	public void setTR_HClass(String tr_hclass) 
	{
		if (tr_hclass.length() > 0)
			this.TR_HClass = " class = \"" + tr_hclass + "\""; 
	}
	public void setTR_HID(String tr_hid) 
	{
		if (tr_hid.length() > 0)
			this.TR_HID = " id = \"" + tr_hid + "\""; 
	}
	public void setTR_HStyle(String tr_hstyle) 
	{
		if (tr_hstyle.length() > 0)
			this.TR_HStyle = " style = \"" + tr_hstyle + "\""; 
	}
	public void setTR_HTitle(String tr_htitle) 
	{
		if (tr_htitle.length() > 0)
			this.TR_HTitle = " title = \"" + tr_htitle + "\""; 
	}
	
	public String getTR_HAlign() 
	{
		return (this.TR_HAlign); 
	}
	public String getTR_HValign() 
	{
		return (this.TR_HValign); 
	}
	public String getTR_HBackgroundColor() 
	{
		return (this.TR_HBackgroundColor); 
	}
	public String getTR_HBordercolor() 
	{
		return (this.TR_HBordercolor); 
	}
	public String getTR_HBordercolorlight() 
	{
		return (this.TR_HBordercolorlight); 
	}
	public String getTR_HBordercolordark() 
	{
		return (this.TR_HBordercolordark); 
	}
	public String getTR_HHeight() 
	{
		return (this.TR_HHeight); 
	}
	public String getTR_Hnowrap() 
	{
		return (this.TR_Hnowrap); 
	}
	public String getTR_HClass() 
	{
		return (this.TR_HClass); 
	}
	public String getTR_HID() 
	{
		return (this.TR_HID); 
	}
	public String getTR_HStyle()
	{
		return (this.TR_HStyle); 
	}
	public String getTR_HTitle() 
	{
		return (this.TR_HTitle); 
	}	
//**********************************************************************************
	public void setTR_OAlign(String tr_oalign) 
	{
		if (tr_oalign.length() > 0)
			this.TR_OAlign = " align = \"" + tr_oalign + "\""; 
	}
	public void setTR_OValign(String tr_ovalign) 
	{
		if (tr_ovalign.length() > 0)
			this.TR_OValign = " valign = \"" + tr_ovalign + "\""; 
	}
	public void setTR_OBackgroundColor(String tr_obackgroundcolor) 
	{
		if (tr_obackgroundcolor.length() > 0)
			this.TR_OBackgroundColor = " bgcolor = \"" + tr_obackgroundcolor + "\""; 
	}
	public void setTR_OBordercolor(String tr_obordercolor) 
	{
		if (tr_obordercolor.length() > 0)
			this.TR_OBordercolor = " bordercolor = \"" + tr_obordercolor + "\""; 
	}
	public void setTR_OBordercolorlight(String tr_obordercolorlight) 
	{
		if (tr_obordercolorlight.length() > 0)
			this.TR_OBordercolorlight = " bordercolorlight = \"" + tr_obordercolorlight + "\""; 
	}
	public void setTR_OBordercolordark(String tr_obordercolordark) 
	{
		if (tr_obordercolordark.length() > 0)
			this.TR_OBordercolordark = " bordercolordark = \"" + tr_obordercolordark + "\""; 
	}
	public void setTR_OHeight(String tr_oheight) 
	{
		if (tr_oheight.length() > 0)
			this.TR_OHeight = " height = \"" + tr_oheight + "\""; 
	}
	public void setTR_Onowrap(String tr_onowrap) 
	{
		if (tr_onowrap.length() > 0)
			this.TR_Onowrap = " " + tr_onowrap; 
	}
	public void setTR_OClass(String tr_oclass) 
	{
		if (tr_oclass.length() > 0)
			this.TR_OClass = " class = \"" + tr_oclass + "\""; 
	}
	public void setTR_OID(String tr_oid) 
	{
		if (tr_oid.length() > 0)
			this.TR_OID = " id = \"" + tr_oid + "\""; 
	}
	public void setTR_OStyle(String tr_ostyle) 
	{
		if (tr_ostyle.length() > 0)
			this.TR_OStyle = " style = \"" + tr_ostyle + "\""; 
	}
	public void setTR_OTitle(String tr_otitle) 
	{
		if (tr_otitle.length() > 0)
			this.TR_OTitle = " title = \"" + tr_otitle + "\""; 
	}
	
	public String getTR_OAlign() 
	{
		return (this.TR_OAlign); 
	}
	public String getTR_OValign() 
	{
		return (this.TR_OValign); 
	}
	public String getTR_OBackgroundColor() 
	{
		return (this.TR_OBackgroundColor); 
	}
	public String getTR_OBordercolor() 
	{
		return (this.TR_OBordercolor); 
	}
	public String getTR_OBordercolorlight() 
	{
		return (this.TR_OBordercolorlight); 
	}
	public String getTR_OBordercolordark() 
	{
		return (this.TR_OBordercolordark); 
	}
	public String getTR_OHeight() 
	{
		return (this.TR_OHeight); 
	}
	public String getTR_Onowrap() 
	{
		return (this.TR_Onowrap); 
	}
	public String getTR_OClass() 
	{
		return (this.TR_OClass); 
	}
	public String getTR_OID() 
	{
		return (this.TR_OID); 
	}
	public String getTR_OStyle()
	{
		return (this.TR_OStyle); 
	}
	public String getTR_OTitle() 
	{
		return (this.TR_OTitle); 
	}	
//**********************************************************************************
	public void setTR_EAlign(String tr_ealign) 
	{
		if (tr_ealign.length() > 0)
			this.TR_EAlign = " align = \"" + tr_ealign + "\""; 
	}
	public void setTR_EValign(String tr_evalign) 
	{
		if (tr_evalign.length() > 0)
			this.TR_EValign = " valign = \"" + tr_evalign + "\""; 
	}
	public void setTR_EBackgroundColor(String tr_ebackgroundcolor) 
	{
		if (tr_ebackgroundcolor.length() > 0)
			this.TR_EBackgroundColor = " bgcolor = \"" + tr_ebackgroundcolor + "\""; 
	}
	public void setTR_EBordercolor(String tr_ebordercolor) 
	{
		if (tr_ebordercolor.length() > 0)
			this.TR_EBordercolor = " bordercolor = \"" + tr_ebordercolor + "\""; 
	}
	public void setTR_EBordercolorlight(String tr_ebordercolorlight) 
	{
		if (tr_ebordercolorlight.length() > 0)
			this.TR_EBordercolorlight = " bordercolorlight = \"" + tr_ebordercolorlight + "\""; 
	}
	public void setTR_EBordercolordark(String tr_ebordercolordark) 
	{
		if (tr_ebordercolordark.length() > 0)
			this.TR_EBordercolordark = " bordercolordark = \"" + tr_ebordercolordark + "\""; 
	}
	public void setTR_EHeight(String tr_eheight) 
	{
		if (tr_eheight.length() > 0)
			this.TR_EHeight = " height = \"" + tr_eheight + "\""; 
	}
	public void setTR_Enowrap(String tr_enowrap) 
	{
		if (tr_enowrap.length() > 0)
			this.TR_Enowrap = " " + tr_enowrap; 
	}
	public void setTR_EClass(String tr_eclass) 
	{
		if (tr_eclass.length() > 0)
			this.TR_EClass = " class = \"" + tr_eclass + "\""; 
	}
	public void setTR_EID(String tr_eid) 
	{
		if (tr_eid.length() > 0)
			this.TR_EID = " id = \"" + tr_eid + "\""; 
	}
	public void setTR_EStyle(String tr_estyle) 
	{
		if (tr_estyle.length() > 0)
			this.TR_EStyle = " style = \"" + tr_estyle + "\""; 
	}
	public void setTR_ETitle(String tr_etitle) 
	{
		if (tr_etitle.length() > 0)
			this.TR_ETitle = " title = \"" + tr_etitle + "\""; 
	}
	
	public String getTR_EAlign() 
	{
		return (this.TR_EAlign); 
	}
	public String getTR_EValign() 
	{
		return (this.TR_EValign); 
	}
	public String getTR_EBackgroundColor() 
	{
		return (this.TR_EBackgroundColor); 
	}
	public String getTR_EBordercolor() 
	{
		return (this.TR_EBordercolor); 
	}
	public String getTR_EBordercolorlight() 
	{
		return (this.TR_EBordercolorlight); 
	}
	public String getTR_EBordercolordark() 
	{
		return (this.TR_EBordercolordark); 
	}
	public String getTR_EHeight() 
	{
		return (this.TR_EHeight); 
	}
	public String getTR_Enowrap() 
	{
		return (this.TR_Enowrap); 
	}
	public String getTR_EClass() 
	{
		return (this.TR_EClass); 
	}
	public String getTR_EID() 
	{
		return (this.TR_EID); 
	}
	public String getTR_EStyle()
	{
		return (this.TR_EStyle); 
	}
	public String getTR_ETitle() 
	{
		return (this.TR_ETitle); 
	}
}