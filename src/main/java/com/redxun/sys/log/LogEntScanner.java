package com.redxun.sys.log;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.util.ClassUtils;

/**
 * 扫描有logent注解的类，读取相关的元数据。
 * @author ray
 *
 */
public class LogEntScanner  {
	
	
	private List<String> basePackage;
	
	public void setBasePackage(List<String> basePackage){
		this.basePackage=basePackage;
	}
	
	private ResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver();
	
	public  Set<String> getModule() throws ClassNotFoundException, IOException{
		Set<String> set=new HashSet<>();
		for(String basePack:this.basePackage){
			parseLogEnt( basePack,  set) ;
		}
        return set;
	}
	
	private  void parseLogEnt(String basePackage, Set<String> set) throws ClassNotFoundException, IOException{
		 
		 Resource[] resources = resourcePatternResolver.getResources(basePackage);
         MetadataReaderFactory readerFactory = new CachingMetadataReaderFactory(this.resourcePatternResolver);
         
         for (Resource resource : resources) {
        	 if (!resource.isReadable()) continue;
             MetadataReader reader = readerFactory.getMetadataReader(resource);
             String className = reader.getClassMetadata().getClassName();
             Class<?> clazz = Class.forName(className);
             Method[] methods= clazz.getMethods();
             for(Method method : methods){
            	 LogEnt logEnt = method.getAnnotation(LogEnt.class);
            	 if(logEnt==null) continue;
            	 set.add(logEnt.module() + "<##>" + logEnt.submodule());
             }
         }
	}

}
