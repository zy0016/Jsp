package JavaBean.cryptcode;

import java.io.*;
import java.util.*;

import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.Security;
import java.security.NoSuchAlgorithmException;
import java.security.InvalidKeyException;
import java.security.KeyStore;
import java.security.cert.X509Certificate;

import javax.crypto.KeyGenerator;
import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.BadPaddingException;



public class cryptcode
{
	public static void main(String args[])
    {
    	String pass="1";
//    	String encrystr=encrypt(pass);
//    	String decrystr=decrypt(encrystr);
//    	
//    	System.out.println("密码:"+pass);
//    	System.out.println("密文:"+encrystr);
//    	System.out.println("明文:"+decrystr);
    }
    public void cryptcode()
    {
    }
    /*********************************************************************\
	* Function： encrypt  
	* Purpose：加密程序
	* Params:  password用户的密码
	* Return：加密之后的形式，密文
	* Remarks：	
	**********************************************************************/
    public String encrypt(String pass)
    {
    	String sResult="";
    	try
    	{
	    	Security.addProvider(new com.sun.crypto.provider.SunJCE());
	        Cipher cipher = Cipher.getInstance("DES");         
	        
	        KeyGenerator kg = KeyGenerator.getInstance("DES");
	        
	        Key key = kg.generateKey();
	        sResult=Integer.toString(Cipher.PRIVATE_KEY)+" "+Integer.toString(Cipher.PUBLIC_KEY)+" "+Integer.toString(Cipher.SECRET_KEY);
	        
	        System.out.println("Cipher.PRIVATE_KEY: " + sResult);
	        
			System.out.println("Cipher provider: " + cipher.getProvider());
			System.out.println("Cipher algorithm: " + cipher.getAlgorithm());
			
			System.out.println("Key format: " + key.getFormat());
			System.out.println("Key algorithm: " + key.getAlgorithm());
			
			System.out.println("kg.generateKey()="+kg.generateKey().toString());
			System.out.println("kg.getAlgorithm()="+kg.getAlgorithm());
			System.out.println("kg.generateKey().getEncoded()="+String.valueOf(kg.generateKey().getEncoded()));
			System.out.println("kg.toString()="+kg.toString());
			
			System.out.println("Key.serialVersionUID="+Key.serialVersionUID);
			System.out.println("key.getEncoded()="+new String(key.getEncoded()));
			System.out.println("key.toString()="+key.toString());
			System.out.println("key.getFormat()="+key.getFormat());
			System.out.println("key.getAlgorithm()="+key.getAlgorithm());
	        
	        
	        byte[] data = pass.getBytes();
	        System.out.println("Original data : " + new String(data));
	
	        cipher.init(Cipher.ENCRYPT_MODE, key);
	        byte[] result = cipher.doFinal(data);
	        sResult=result.toString();
	        //System.out.println("Encrypted data: " + new String(result));
	        System.out.println("Encrypted data: " + sResult);
			
	        //cipher.init(Cipher.DECRYPT_MODE, key);
	        //byte[] original = cipher.doFinal(result);
	        //System.out.println("Decrypted data: " + new String(original));
    	}
    	catch (Exception e)
    	{
    		
    	}
    	return sResult;
    }
    /*********************************************************************\
	* Function： decrypt  
	* Purpose：解密程序
	* Params:  crypt:数据库中的密文
	* Return：明文
	* Remarks：	
	**********************************************************************/
    public String decrypt(String crypt)
    {
    	String decryptstr="";
    	try
    	{
    		System.out.println("函数中的密文:"+crypt+" "+crypt.length());
	    	byte[] pass=crypt.getBytes();
	    	
	    	Security.addProvider(new com.sun.crypto.provider.SunJCE());
	    	
			Cipher cipher = Cipher.getInstance("DES");         
			
			KeyGenerator kg = KeyGenerator.getInstance("DES");
			Key key = kg.generateKey();
		    
			cipher.init(Cipher.DECRYPT_MODE, key);
						
			byte[] original = cipher.doFinal(pass);
			
			System.out.println("函数中的132");
			
			System.out.println("Decrypted data: " + new String(original));
			decryptstr=original.toString();
	    }  
	    catch(Exception e)
	    {
	    	System.out.println("出错"+e.toString());
	    }
    	return decryptstr;
    }
    public static boolean isprime(int begin)
    {
    	boolean res=true;
    	for (int i=2;i<begin;i++)
    	{
    		if (begin % i==0)
    		{
    			res = false;
    			System.out.println(i);
    			break;
    		}
    	}
    	return res;
    }
}