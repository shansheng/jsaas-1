package com.redxun.test;

import java.text.DecimalFormat;

public class NumberFormatTest {
	
	public static void main(String[] args) {
		double c=122299.89;
		
		//System.out.println(c);
		 System.out.println(new DecimalFormat("#.####").format(c));        // 299,792,458
		 System.out.println(new DecimalFormat("##.00").format(c));
		 System.out.println(new DecimalFormat("###.00").format(c));
		 System.out.println(new DecimalFormat(",###.00").format(c));
	}

}
