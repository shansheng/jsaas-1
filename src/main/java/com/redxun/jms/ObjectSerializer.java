package com.redxun.jms;

import java.util.Map;

import org.apache.kafka.common.serialization.Serializer;

import com.redxun.core.util.FileUtil;

public class ObjectSerializer implements Serializer<Object> {

	@Override
	public void configure(Map<String, ?> configs, boolean isKey) {

	}

	@Override
	public byte[] serialize(String topic, Object data) {
		try {
			return FileUtil.objToBytes(data);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public void close() {

	}

}
