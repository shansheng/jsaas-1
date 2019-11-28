package com.airdrop.common.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Map;
import java.util.Set;
/**
 * 
* @ClassName: JsonUtils
* @Description: json解析工具
* @company: airdrop
* @author aichen.yang
* @date 2017-10-31 上午09:38:49
*
 */
public class JsonUtils {
   
    public final static void convert(Object json) {
        if (json instanceof JSONArray) {
            JSONArray arr = (JSONArray) json;
            for (Object obj : arr) {
                convert(obj);
            }
        } else if (json instanceof JSONObject) {
            JSONObject jo = (JSONObject) json;
            Set<String> keys = jo.keySet();
            String[] array = keys.toArray(new String[keys.size()]);
            for (String key : array) {
                Object value = jo.get(key);
                String[] key_strs = key.split("_");
                if(key_strs.length==1){
                	jo.remove(key);
                	if(key_strs[0].toLowerCase().equals("rescode")){
                		 jo.put(key_strs[0], value);
                	}else if(key_strs[0].toLowerCase().equals("resmsg")){
                		 jo.put(key_strs[0], value);
                	}else{
                		jo.put(key_strs[0].toLowerCase(), value);
                	}
                    
                }
                if (key_strs.length > 1) {
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < key_strs.length; i++) {
                        String ks = key_strs[i];
                        if (!"".equals(ks)) {
                            if (i == 0) {
                                sb.append(ks.toLowerCase());
                            } else {
                            	ks= ks.toLowerCase();
                                int c = ks.charAt(0);
                                if (c >= 97 && c <= 122) {
                                    int v = c - 32;
                                    sb.append((char) v);
                                    if (ks.length() > 1) {
                                        sb.append(ks.substring(1));
                                    }
                                } else {
                                    sb.append(ks);
                                }
                            }
                        }
                    }
                    jo.remove(key);
                    jo.put(sb.toString(), value);
                }
                convert(value);
            }
        }
    }
   /**
    * json转化对象
    * @param json
    * @return
    */
    public final static Object convert(String json) {
        Object obj = JSON.parse(json);
        convert(obj);
        return obj;
    }
    
    
    private static ObjectMapper objectMapper = new ObjectMapper();  
    
    public static <T> String bean2Json(T bean) {  
        try {  
            return objectMapper.writeValueAsString(bean);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "";  
    }  
      
    public static String map2Json(Map map) {  
        try {  
            return objectMapper.writeValueAsString(map);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "";  
    }  
      
    public static String list2Json(List list) {  
        try {  
            return objectMapper.writeValueAsString(list);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "";  
    }  
      
    public static <T> T json2Bean(String json, Class<T> beanClass) {  
        try {  
            return objectMapper.readValue(json, beanClass);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
      
    public static <T> List<T> json2List(String json, Class<T> beanClass) {  
        try {  
              
            return (List<T>)objectMapper.readValue(json, getCollectionType(List.class, beanClass));  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
      
    public static Map json2Map(String json) {  
        try {  
              
            return (Map)objectMapper.readValue(json, Map.class);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
      
      
    public static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {     
        return objectMapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);     
    }   
}