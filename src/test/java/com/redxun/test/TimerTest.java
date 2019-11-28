package com.redxun.test;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TimerTest {
	
	public static void main(String[] args) {
		 	Runnable runnable = new Runnable() {
	            public void run() {
	                System.out.println("ScheduledExecutorService Task is called!");
	            }
	        };
	        ScheduledExecutorService service = Executors.newSingleThreadScheduledExecutor();
	        service.schedule(runnable, 2, TimeUnit.SECONDS);
	}

}
