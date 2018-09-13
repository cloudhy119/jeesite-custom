package com.ccgx.util.date;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils extends Date{
	
	private static SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd");
	
	
	public static String getYMD(){
		Date date=new Date();
		return sd.format(date);
	}

}
