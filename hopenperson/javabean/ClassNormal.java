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
    static String filename="";//纯文件名，不含路径
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
        * Function： GetFilename  
        * Purpose：生成随机文件名
        * Params:  paht:生成文件的路径，extend：该文件的扩展名
        * Return：一个随机生成的文件名
        * Remarks：	
        **********************************************************************/
    public static String GetFilename(String path,String extend)//生成随机文件名
    {
        Random rd=new Random();
        String filenamepath="";
        String num="";//生成的随机数
        while(true)
        {
            num=Integer.toString(Math.abs(rd.nextInt()));
            filenamepath=path+"\\"+num+"."+extend;//生成随机文件名
            
            File f1=new File(filenamepath);
            if (!f1.exists())//该文件不存在
                break;	
        }
        filename=num+"."+extend;
        
        return (filenamepath);//
    }
    public static double get4_5(double num,int i)
    {
        int point=Double.toString(num).indexOf(".");//获得小数点的位置
        if (point<0)//没有小数点
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
        * Function： getleft_rightstr  
        * Purpose：在字符串str1中查找字符串str2,i=-1为从左边为开始点开始找，i=1为从右边开始点开始找,返回开始点到str2的字符串     
        * Params:  	在字符串str1中查找字符串str2,i=-1为从左边为开始点开始找，i=1为从右边开始点开始找,返回开始点到str2的字符串 
        * Return：	返回开始点到str2的字符串(例如：str1="12;34",str2=";",i=-1,返回12,i=1返回34)
        * Remarks：	
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
        * Function： createselect  
        * Purpose：生成查询语句     
        * Params:  	tablename:查询哪一个表，fieldname：查询哪一个字段，term：查询条件是什么(=;>;<...)，data：用户输入或选择的数据   
        * Return：	返回查询语句     
        * Remarks：	特别规定：若查询的表不是A01表,则tablename包含2个表，如A01,A04，逗号后边的表是用户要查的表
        **********************************************************************/
    public static String createselect(String tablename,String fieldname,String term,String data)
    {
        String	select=""/*保存有关字段的查询语句的生成结果*/,select_table=""/*保存有关表名的查询语句的生成结果*/,table="";//中间表名
        int		i=0;
        String	result="调用"/*最终结果*/,d_Field=""/*显示给用户的字段名*/;
        String	findtable="";//保存实际在哪一表中查询
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
                
                if (d_Field.indexOf("（")>=0)
                    d_Field=d_Field.replaceAll("（","");
                if (d_Field.indexOf("）")>=0)
                    d_Field=d_Field.replaceAll("）","");
                if (d_Field.indexOf("(")>=0)
                    d_Field=d_Field.replaceAll("(","");
                if (d_Field.indexOf(")")>=0)
                    d_Field=d_Field.replaceAll(")","");
                    
                if (memo.compareTo("0")==0)//通过判断code字段是否为空确定该字段式输入还是选择
                {
                    if (d_Field.compareTo("id")==0)//对id字段进行特殊处理：A01表中不显示id字段，其他表将id字段显示为姓名字段
                    {
                        if (tablename.compareTo("A01")==0)
                            continue;
                        else //非A01表将id字段显示为姓名字段
                            select=select+" A01.A0101"+" as 姓名,";//field_name字段
                    }
                    else if (d_Field.compareTo("id_identity")==0)
                    {
                    	select=select + findtable+"."+field_name+" as 编号,";
                        //continue;
                    }
                    else //非id字段
                    {
                        if (field_name.compareTo("C0115")==0)//不处理照片字段
                            continue;
                        select=select+findtable+"."+field_name+" as "+d_Field+",";//field_name字段	
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
            if ((term.indexOf("like")>=0) && (data.indexOf("%")==-1))//"包含"条件
            {
                if (tablename.compareTo("A01")!=0)//查询涉及到两个表不只是A01表
                    result=select+" "+select_table+" where "+fieldname+" "+term+" '%"+data+"%' and "+"A01.id="+findtable+".id";
                else
                    result=select+" "+select_table+" where "+fieldname+" "+term+" '%"+data+"%'";
            }
            else
            {
                if (tablename.compareTo("A01")!=0)//不是A01表
                    result=select+" "+select_table+" where "+fieldname+" "+term+"'"+data+"' and "+"A01.id="+findtable+".id";
                else//A01表
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
