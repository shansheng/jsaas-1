package com.redxun.bpm.activiti.image;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.image.ProcessDiagramGenerator;

import com.redxun.bpm.core.entity.BpmNodeStatus;
/**
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * @author mansan
 *
 */
public interface ProcessImageGenerator extends ProcessDiagramGenerator{
	  /**
	   * Generates a diagram of the given process definition, using the
	   * diagram interchange information of the process.
	   * @param bpmnModel bpmn model to get diagram for
	   * @param imageType type of the image to generate.
	   * @param highLightedActivities activities to highlight and status
	   * @param highLightedFlows flows to highlight
	   * @param activityFontName override the default activity font
	   * @param labelFontName override the default label font
	   * @param customClassLoader provide a custom classloader for retrieving icon images
	   */
	  public InputStream generateDiagram(BpmnModel bpmnModel, String imageType, Map<String,BpmNodeStatus> highLightedActivities, List<String> highLightedFlows, 
	      String activityFontName, String labelFontName, ClassLoader customClassLoader, double scaleFactor);
}
