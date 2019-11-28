package com.redxun.jms;

import com.redxun.core.jms.IMessageProducer;

/**
 * 空的消息处理，仅用于测试
 * @author csx
 *
 */
public class EmptyMessageProducer implements IMessageProducer{
	@Override
	public void send(Object model) {
		
	}

	@Override
	public void send(String topic, Object model) {
		// TODO Auto-generated method stub
		
	}
}
