package com.thinkgem.jeesite.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateOfChinese {
	/**
	 * 数字日期转汉字日期 时间格式
	 * 
	 * @param date
	 * @return
	 */
	public static String chineseNumeral(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = sdf.format(date);
		return chineseNumeral(format);

	}

	/**
	 * 数字日期转汉字日期
	 * 
	 * @param dayTime
	 *            时间格式 yyyy-MM-dd
	 * @return
	 */
	public static String chineseNumeral(String dayTime) {
		StringBuilder capitalForm = new StringBuilder();
		capitalForm.append("");
		if (dayTime.indexOf("-") != -1) {
			String[] times = dayTime.split("-");
			if (times.length == 3) {
				String year = times[0];
				String month = times[1];
				String date = times[2];

				// 年
				capitalForm.append(matchChinese(year));
				capitalForm.append("年");

				// 月
				capitalForm.append(matchChinese(month));
				capitalForm.append("月");

				// 日
				capitalForm.append(matchChinese(date));
				capitalForm.append("日");
			}
		}

		String chineseNumeral = capitalForm.toString();
		return chineseNumeral;
	}

	public static String matchChinese(String num) {
		StringBuilder sb = new StringBuilder();
		sb.append("");
		String result = "";

		if ("10".equals(num)) {
			num = "0";
		} else if (num.length() == 2) {
			String split = num.substring(1, 2);
			if (num.startsWith("1")) {
				num = "0" + split;
			} else if (num.startsWith("2") && !"20".equals(num)) {
				num = "20" + split;
			} else if (num.startsWith("3") && !"30".equals(num)) {
				num = "30" + split;
			} else if (num.startsWith("0")) {
				num = split;
			}
		}

		for (int i = 0; i < num.length(); i++) {
			char n = num.charAt(i);
			if ('0' == n) {
				if (num.length() == 4) {
					result = "〇";
				} else {
					result = "十";
				}
			} else if ('1' == n) {
				result = "一";
			} else if ('2' == n) {
				result = "二";
			} else if ('3' == n) {
				result = "三";
			} else if ('4' == n) {
				result = "四";
			} else if ('5' == n) {
				result = "五";
			} else if ('6' == n) {
				result = "六";
			} else if ('7' == n) {
				result = "七";
			} else if ('8' == n) {
				result = "八";
			} else if ('9' == n) {
				result = "九";
			}
			sb.append(result);
		}
		result = sb.toString();

		return result;

	}
}
