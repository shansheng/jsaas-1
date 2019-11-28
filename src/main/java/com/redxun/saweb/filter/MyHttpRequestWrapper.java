package com.redxun.saweb.filter;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils;

public  class MyHttpRequestWrapper extends HttpServletRequestWrapper {

	private byte[] data;

	public MyHttpRequestWrapper(HttpServletRequest request) throws IOException {
		super(request);
		data = IOUtils.toByteArray(request.getInputStream());
	}

	@Override
	public ServletInputStream getInputStream() throws IOException {
		return new MyServletInputStream(new ByteArrayInputStream(data));
	}
	
	

	class MyServletInputStream extends ServletInputStream{
		private InputStream inputStream;
		
		public MyServletInputStream(InputStream is){
			this.inputStream=is;
		}
		
		@Override
		public int read() throws IOException {
			return inputStream.read();
		}

		@Override
		public boolean isFinished() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean isReady() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public void setReadListener(ReadListener arg0) {
			// TODO Auto-generated method stub
			
		}
	}

		
}
