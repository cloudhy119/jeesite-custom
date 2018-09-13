package com.thinkgem.jeesite.common.utils;

public class StringFomatUtils {
	
	public static String tickSymbol = "√";
	public static String noTickSymbol = "□";
	
	public String addSpaceBothSides(String text, int stringSize) {
		StringBuilder sb = new StringBuilder();
		if(text == null || text.length() == 0){
			for (int i = 0; i < stringSize; i++) {
				sb.append(" ");
			}
			return sb.toString();
		}
		if (text.length() <= stringSize){
			int space = stringSize - text.length();
			int half = (int)space/2;
			for (int i = 0; i < half; i++) {
				sb.append(" ");
			}
			sb.append(text);
			if(space%2 != 0){
				half = half+1;
			}
			for (int i = 0; i < half; i++) {
				sb.append(" ");
			}
		}else{
			sb.append(text);
		}
		return sb.toString();
	}
	
	public static String addSpaceBehind(String text, int stringSize) {
		StringBuilder sb = new StringBuilder();
		if(text == null || text.length() == 0){
			for (int i = 0; i < stringSize; i++) {
				sb.append(" ");
			}
			return sb.toString();
		}
		if (text.length() <= stringSize){
			int space = stringSize - text.length();
			sb.append(text);
			for (int i = 0; i < space; i++) {
				sb.append(" ");
			}
		}else{
			sb.append(text);
		}
		return sb.toString();
	}
	

}
