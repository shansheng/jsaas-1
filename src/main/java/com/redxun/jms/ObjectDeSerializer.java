package com.redxun.jms;

import java.util.Map;

import org.apache.kafka.common.serialization.Deserializer;

import com.redxun.core.util.FileUtil;

public class ObjectDeSerializer implements Deserializer<Object> {

	@Override
	public void configure(Map<String, ?> configs, boolean isKey) {

	}

	@Override
	public Object deserialize(String topic, byte[] data) {
		try {
			return FileUtil.bytesToObject(data);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub

	}

}
