
package com.redxun.test.id;

import com.redxun.test.BaseTestCase;

import java.util.UUID;

import org.junit.Test;

/**
 *
 * @author X230
 */
public class IdGeneratorTest extends BaseTestCase{

    @Test
    public void testGenerateIds(){
//        for(int i=0;i<100;i++){
//          String id=idGenerator.getSID();
//          System.out.println("id:"+id);
//        }
    	
    }
    public static void main(String[] args) {
    	System.out.println( UUID.randomUUID().toString().replace("-", "").substring(0, 16));
	}
}
