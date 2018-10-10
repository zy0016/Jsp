package JavaBean.ClassNormal;

import JavaBean.OperateDataBase.*;
import JavaBean.ErrorManage.*;
import java.util.*;
import java.sql.*;
import java.io.*;
//import java.lang.*;
//import java.math.*;

public class ClassNormal
{
    static String filename="";//���ļ���������·��
    public static void main(String args[])
    {
        String sql="";
        ResultSet rs=null;
        try
        {
            //sql.replace(
            int i=0,j=0;
            OperateDataBase odb=new OperateDataBase();
            ErrorManage em=new ErrorManage();
          String  separator="*",subfname="";
          
		  String fName=odb.executeQuery_String("select field from account_set");
		  while (true)
		  {
				i=fName.indexOf(separator);
				if (i==-1)
				{
					System.out.println("<option value="+fName+">"+fName+"</option>");
					break;
				}
				subfname=fName.substring(0,i);
				System.out.println("<option value="+subfname+">"+subfname+"</option>");
				fName=fName.substring(i+1);
				j++;
				if (j>3)
					break;
		  }
		  
//            String log=odb.SaveUpdateLog("","update A01 set A0102='1' where id=281");
//            System.out.print(log);
            //em.SaveError("1","2","3","4","5");
//            boolean b=false;
//            b=em.JustDateTime("2000 2 20");
            
            //System.out.println(b);
//            count=odb.executeUpdate("update A01_account set password='1' where id=259");
//            System.out.println(count);
            
        }
//        catch (NoSuchAlgorithmException e) 
//        {
//            e.printStackTrace();
//        }
//        catch (NoSuchPaddingException e)
//        {
//            e.printStackTrace();
//        }
		
        catch(Exception e)
        {
            ErrorManage.DisplayError(e.getMessage(),"main");
        }
    }	
    
    public ClassNormal()
    {}
    
    /*********************************************************************\
        * Function�� GetFilename  
        * Purpose����������ļ���
        * Params:  paht:�����ļ���·����extend�����ļ�����չ��
        * Return��һ��������ɵ��ļ���
        * Remarks��	
        **********************************************************************/
    public static String GetFilename(String path,String extend)//��������ļ���
    {
        Random rd=new Random();
        String filenamepath="";
        String num="";//���ɵ������
        while(true)
        {
            num=Integer.toString(Math.abs(rd.nextInt()));
            filenamepath=path+"\\"+num+"."+extend;//��������ļ���
            
            File f1=new File(filenamepath);
            if (!f1.exists())//���ļ�������
                break;	
        }
        filename=num+"."+extend;
        
        return (filenamepath);//
    }
    public static double get4_5(double num,int i)
    {
        int point=Double.toString(num).indexOf(".");//���С�����λ��
        if (point<0)//û��С����
            return (num);
        String nu=Double.toString(num);
        String leftnu=getleft_rightstr(nu,".",-1);
        String rightnu=getleft_rightstr(nu,".",1);
        String result="";
        if (rightnu.length()<=i)
            return (num);
        else
        {
            result=leftnu+"."+rightnu.substring(0,i);
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
        String	result="";
        if (str1.trim().compareTo("")==0)
            result="";
        else
            switch (i)
            {
                case -1:result=str1.substring(0,str1.indexOf(str2));
                    break;
                case 1:result=str1.substring(str1.indexOf(str2)+1,str1.length()).trim();
                    break;
            }
        return (result);
    }
    public static String ReplaceString(String strSource,String strFrom,String strTo)
    { 
        String strDest = ""; 
        int intFromLen = strFrom.length(); 
        int intPos; 

        while((intPos=strSource.indexOf(strFrom))!=-1)
        { 
            strDest = strDest + strSource.substring(0,intPos); 
            strDest = strDest + strTo; 
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
        String	select=""/*�����й��ֶεĲ�ѯ�������ɽ��*/,select_table=""/*�����йر����Ĳ�ѯ�������ɽ��*/,table="";//�м����
        int		i=0;
        String	result="����"/*���ս��*/,d_Field=""/*��ʾ���û����ֶ���*/;
        String	findtable="";//����ʵ������һ���в�ѯ
        ResultSet rs=null;
        String code="",field_name="",memo="";
        
        findtable=tablename;
        try
        {
            OperateDataBase odb = new OperateDataBase();
            rs=odb.executeQuery("select * from BasInfTFMenu where table_name='"+findtable+"'");
            select="select ";
            if (tablename.compareTo("A01")==0)
                select_table=" from "+tablename;
            else
                select_table=" from A01,"+tablename;
            
            i=0;
            while(rs.next())
            {
                table=" T"+Integer.toString(i);
                d_Field=rs.getString("field_hz");
                field_name=rs.getString("field_name");
                memo=rs.getString("memo");
                code=rs.getString("code");
                
                if (d_Field.indexOf("��")>=0)
                    d_Field=d_Field.replaceAll("��","");
                if (d_Field.indexOf("��")>=0)
                    d_Field=d_Field.replaceAll("��","");
                if (d_Field.indexOf("(")>=0)
                    d_Field=d_Field.replaceAll("(","");
                if (d_Field.indexOf(")")>=0)
                    d_Field=d_Field.replaceAll(")","");
                    
                if (memo.compareTo("0")==0)//ͨ���ж�code�ֶ��Ƿ�Ϊ��ȷ�����ֶ�ʽ���뻹��ѡ��
                {
                    if (d_Field.compareTo("id")==0)//��id�ֶν������⴦��A01���в���ʾid�ֶΣ�������id�ֶ���ʾΪ�����ֶ�
                    {
                        if (tablename.compareTo("A01")==0)
                            continue;
                        else //��A01��id�ֶ���ʾΪ�����ֶ�
                            select=select+" A01.A0101"+" as ����,";//field_name�ֶ�
                    }
                    else if (d_Field.compareTo("id_identity")==0)
                    {
                    	select=select + findtable+"."+field_name+" as ���,";
                        //continue;
                    }
                    else //��id�ֶ�
                    {
                        if (field_name.compareTo("C0115")==0)//��������Ƭ�ֶ�
                            continue;
                        select=select+findtable+"."+field_name+" as "+d_Field+",";//field_name�ֶ�	
                    }
                }
                else
                {
                    if (code.indexOf("B02")>=0)
                    {
                        select=select+table+".b0205"+" as "+d_Field+",";
                        select_table=select_table+" LEFT OUTER JOIN b02 "+table+" on "+table+".b0210="+findtable+"."+field_name;
                    }
                    else
                    {
                        select=select+table+".name"+" as "+d_Field+",";
                        select_table=select_table+" LEFT OUTER JOIN datalist "+table+" on "+table+".idcode="+findtable+"."+field_name+" and "+table+".code='"+code+"'";
                    }
                }
                i++;
            }
            select=select.substring(0,select.length()-1);
            if ((term.indexOf("like")>=0) && (data.indexOf("%")==-1))//"����"����
            {
                if (tablename.compareTo("A01")!=0)//��ѯ�漰��������ֻ��A01��
                    result=select+" "+select_table+" where "+fieldname+" "+term+" '%"+data+"%' and "+"A01.id="+findtable+".id";
                else
                    result=select+" "+select_table+" where "+fieldname+" "+term+" '%"+data+"%'";
            }
            else
            {
                if (tablename.compareTo("A01")!=0)//����A01��
                    result=select+" "+select_table+" where "+fieldname+" "+term+"'"+data+"' and "+"A01.id="+findtable+".id";
                else//A01��
                    result=select+" "+select_table+" where "+fieldname+" "+term+"'"+data+"'";
            }
        }
        catch(Exception e)
        {
            ErrorManage.DisplayError(e.getMessage(),"createselect");
        }		
        return (result);
    }
}
