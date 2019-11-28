package com.redxun.jms;

import javax.annotation.Resource;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.listener.MessageListener;

import com.redxun.core.jms.MessageConsumer;

public class KafkaConsumerListener implements MessageListener<String, Object> {

	@Resource
	MessageConsumer messageConsumer;
	
	@Override
	public void onMessage(ConsumerRecord<String, Object> record) {
		try {
			messageConsumer.handleMessage(record.value());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
