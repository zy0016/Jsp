package JavaBean.GridTable;
import java.sql.*;
import JavaBean.PrintTable.*;
import JavaBean.ErrorManage.*;
import JavaBean.ClassNormal.*;
import JavaBean.OperateDataBase.*;

public class GridTable extends PrintTable 
{
	private		long	lCount = 0;//�����ʾ�˶���������
	public static void main(String args[])
	{
		int cols = 0;
		String sql = "";
		String result = "",width = "";
		try
		{
			GridTable gt = new GridTable();
			OperateDataBase odb = new OperateDataBase();
			
			sql = ClassNormal.createselect("A07","","","");
			
			cols = odb.executeQuery_col(sql);
			width = String.valueOf(cols * 110);
			
			gt.setBorder("1");
			gt.setWidth(width);
			gt.setTR_HBackgroundColor("#33FF00");
			gt.setTR_OBackgroundColor("#0066FF");
			gt.setTR_EBackgroundColor("#00FFFF");
			gt.setTR_HAlign("center");
			gt.setTR_OAlign("center");
			gt.setTR_EAlign("center");
			
			result = gt.WriteTable(sql);
			//result = gt.WriteTable(sql,16,10);
			
			System.out.println("����������");
			
			if (gt.OutString(result,"d:\\temp\\GridTable.txt"))
				System.out.println("����ɹ�");
			else
				System.out.println("���ʧ��");
			
			//System.out.println(sql);
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError(e.getMessage(),"main");
		}
	}
	//��ӡ����ʽ�ı��
	public void GridTable()
	{}
	/*********************************************************************\
	* Function�� WriteTable  
	* Purpose��������,���Ǹ���ķ���
	* Params:  
	* Return��
	* Remarks��	
	**********************************************************************/
	public String WriteTable(String sql)
	{
		StringBuffer 		result	= new StringBuffer("");
		int 				cols;//��ò�ѯ���������
		long 				count 	= 0;//������
		String				param 	= "";//������
		String				Hparam 	= "";//���������
		String				Oparam 	= "";//�����в���
		String				Eparam 	= "";//ż���в���
		ResultSet			rs 		= null;
		ResultSetMetaData	rsmd 	= null;
		
		try
		{
			this.InitPrintTable(sql);
			rs		= this.GetResultSet();
			rsmd 	= this.GetResultSetMetaData();
			param	= this.GetParam();//��ñ�����
			Hparam	= this.GetTR_Hparam();//���������
			Oparam	= this.GetTR_Oparam();//�����в���
			Eparam	= this.GetTR_Eparam();//ż���в���
					
			cols 	= rsmd.getColumnCount();//�ò�ѯ����ж�����
			
			result.append("<table");
			result.append(param);
			result.append(">\n");
			
			result.append("<tr");
			result.append(Hparam);
			result.append(">\n");
			
			for (int i = 1;i <= cols;i++)
			{
				String colname = rsmd.getColumnName(i).toString();//�������
				result.append("<td>");
				result.append(colname);
				result.append("</td>");
			}
			result.append("</tr>\n");
			
			count = 0;
			while (rs.next())
			{
				count++;
				
				result.append("<tr");
				if (count % 2 == 1)//������
					result.append(Oparam);
				else				//ż����
					result.append(Eparam);
					
				result.append(">\n");
				
				for (int i = 1;i <= cols;i++)
				{
					String data = rs.getString(i);
					
					if (data == null)
						data = "&nbsp;";
					else if (data.length() == 0)
						data = "&nbsp;";
					else if (data.indexOf("00:00:00") >= 0)
						data = data.replaceAll("00:00:00","");

					result.append("<td>");
					result.append(data);
					result.append("</td>");
				}
				result.append("\n</tr>\n");
			}
			result.append("</table>\n");
			this.destory();
		}
		catch (Exception e)
		{
			ErrorManage.SaveError(this.accountname,"GridTable.WriteTable",e.toString(),e.getMessage(),result.toString() + "ִ��ʧ��");
		}
		lCount = count;
		return (result.toString());
	}
	public long getlCount()
	{
		return (this.lCount);
	}
//*************************************************************************************
	/*********************************************************************\
	* Function�� WriteTable  
	* Purpose����ҳʽ������
	* Params:  sql:��Ҫִ�е�SQL���.iCurrentPage:��ǰ��ҳ��,iPageSize:һҳ��ʾ�ļ�¼��
	* Return��
	* Remarks��	
	**********************************************************************/
	public String WriteTable(String sql,int iCurrentPage,int iPageSize)
	{
		StringBuffer 		result	= new StringBuffer("");
		int 				cols;//��ò�ѯ���������
		long 				count 	= 0;//������
		long				intRowCount;//��¼����
		long				intPageCount;//��ҳ��
		String				param 	= "";//������
		String				Hparam 	= "";//���������
		String				Oparam 	= "";//�����в���
		String				Eparam 	= "";//ż���в���
		ResultSet			rs 		= null;
		ResultSetMetaData	rsmd 	= null;
		
		try
		{
			OperateDataBase odb = new OperateDataBase();
			this.InitPrintTable(sql);
			rs		= this.GetResultSet();
			rsmd 	= this.GetResultSetMetaData();
			param	= this.GetParam();//��ñ�����
			Hparam	= this.GetTR_Hparam();//���������
			Oparam	= this.GetTR_Oparam();//�����в���
			Eparam	= this.GetTR_Eparam();//ż���в���
					
			cols 	= rsmd.getColumnCount();//�ò�ѯ����ж�����
			
			result.append("<table");
			result.append(param);
			result.append(">\n");
			
			result.append("<tr");
			result.append(Hparam);
			result.append(">\n");
			for (int i = 1;i <= cols;i++)
			{
				String colname = rsmd.getColumnName(i).toString();//�������
				result.append("<td>");
				result.append(colname);
				result.append("</td>");
			}
			result.append("</tr>\n");
			
			//rs.absolute((iCurrentPage - 1) * iPageSize + 1);//��֪Ϊʲôִ�г���
			count 			= 0;
			intRowCount 	= odb.executeQuery_long(sql);//��¼����
			intPageCount 	= (intRowCount + iPageSize - 1) / iPageSize;//������ҳ��
			
			while (rs.next())
			{
				count++;
				//if (!((iCurrentPage - 1) * iPageSize + 1 <= count && count <= iPageSize * iCurrentPage))
				//	continue;
				
				if ((iCurrentPage - 1) * iPageSize + 1 > count)
					continue;
				if (iPageSize * iCurrentPage < count)
					break;
				
				result.append("<tr");
				if (count % 2 == 1)//������
					result.append(Oparam);
				else				//ż����
					result.append(Eparam);
					
				result.append(">\n");
				
				for (int i = 1;i <= cols;i++)
				{
					String data = rs.getString(i);
					
					if (data == null)
						data = "&nbsp;";
					else if (data.length() == 0)
						data = "&nbsp;";
					else if (data.indexOf("00:00:00") >= 0)
						data = data.replaceAll("00:00:00","");

					result.append("<td>");
					result.append(data);
					result.append("</td>");
				}
				result.append("\n</tr>\n");
			}
			result.append("</table>\n");
			this.destory();
		}
		catch (Exception e)
		{
			ErrorManage.DisplayError("GridTable.WriteTable",e.getMessage() + "ִ��ʧ��");
		}
		return (result.toString());
	}
}
