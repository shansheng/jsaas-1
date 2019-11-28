package com.redxun.bpm.activiti.image;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Paint;
import java.awt.geom.RoundRectangle2D;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.bpmn.model.Activity;
import org.activiti.bpmn.model.Artifact;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.CallActivity;
import org.activiti.bpmn.model.FlowElement;
import org.activiti.bpmn.model.FlowElementsContainer;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.bpmn.model.Gateway;
import org.activiti.bpmn.model.GraphicInfo;
import org.activiti.bpmn.model.Lane;
import org.activiti.bpmn.model.MultiInstanceLoopCharacteristics;
import org.activiti.bpmn.model.Pool;
import org.activiti.bpmn.model.Process;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.bpmn.model.SubProcess;
import org.activiti.bpmn.model.UserTask;
import org.activiti.image.impl.DefaultProcessDiagramCanvas;
import org.activiti.image.impl.DefaultProcessDiagramGenerator;
import org.apache.commons.lang.StringUtils;

import com.redxun.bpm.core.entity.BpmNodeStatus;

/**
 *  扩展基于Activiti的流程图生成器
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessDiagramGeneratorExt extends DefaultProcessDiagramGenerator implements ProcessImageGenerator{
	
	private Map<String,String> processColors=new HashMap<String, String>();
	private Map<String,String> timeoutColors=new HashMap<String,String>();
    
	public void setProcessColors(Map<String, String> processColors) {
		this.processColors = processColors;
	}

	public Map<String, String> getTimeoutColors() {
		return timeoutColors;
	}

	public void setTimeoutColors(Map<String, String> timeoutColors) {
		this.timeoutColors = timeoutColors;
	}

	public Map<String, String> getProcessColors() {
		return processColors;
	}

	 public InputStream generateDiagram(BpmnModel bpmnModel, String imageType, String activityFontName, 
		      String labelFontName, ClassLoader customClassLoader, double scaleFactor){
		 return super.generateDiagram(bpmnModel, imageType, activityFontName,labelFontName,customClassLoader,scaleFactor);
	 }
	
	protected DefaultProcessDiagramCanvas generateProcessDiagram(BpmnModel bpmnModel, String imageType, Map<String, BpmNodeStatus> highLightedActivities, 
			List<String> highLightedFlows, String activityFontName, String labelFontName, ClassLoader customClassLoader, double scaleFactor) {
        prepareBpmnModel(bpmnModel);
        // 从父类中拷贝如下代码，只为了调用下一个静态方法
        ProcessDiagramCanvasExt processDiagramCanvas =
                initProcessDiagramCanvas(bpmnModel,
                        imageType,
                        activityFontName == null ? "黑体" : activityFontName, 
                        labelFontName == null ? "黑体" : labelFontName,
                        customClassLoader);
  
	    // Draw pool shape, if process is participant in collaboration
	    for (Pool pool : bpmnModel.getPools()) {
	      GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(pool.getId());
	      processDiagramCanvas.drawPoolOrLane(pool.getName(), graphicInfo);
	    }
	    
	    // Draw lanes
	    for (Process process : bpmnModel.getProcesses()) {
	      for (Lane lane : process.getLanes()) {
	        GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(lane.getId());
	        processDiagramCanvas.drawPoolOrLane(lane.getName(), graphicInfo);
	      }
	    }
	    
	    // Draw activities and their sequence-flows
	    for (FlowNode flowNode : bpmnModel.getProcesses().get(0).findFlowElementsOfType(FlowNode.class)) {
	      drawActivity(processDiagramCanvas, bpmnModel, flowNode, highLightedActivities, highLightedFlows, scaleFactor);
	    }
	    
	    // Draw artifacts
	    for (Process process : bpmnModel.getProcesses()) {
	      for (Artifact artifact : process.getArtifacts()) {
	        drawArtifact(processDiagramCanvas, bpmnModel, artifact);
	      }
	    }
	    return processDiagramCanvas;
    }

	protected void drawUserTaskSpec(ProcessDiagramCanvasExt canvas,String textName,GraphicInfo graphicInfo, Color backgroundColor) {
        
		Graphics2D g=canvas.getGraphics2d();
		
		Paint originalPaint = g.getPaint();
        int x = (int) graphicInfo.getX();
        int y = (int) graphicInfo.getY();
        int width = (int) graphicInfo.getWidth();
        int height = (int) graphicInfo.getHeight();
        int arcR = 6;
        
        //RoundRectangle2D rect = new RoundRectangle2D.Double(x, y+32, width, height-32, 0, 0);
        // shape
        RoundRectangle2D rect = new RoundRectangle2D.Double(x, y, width, height, arcR, arcR);
        //g.fill(rect);

    	//获得原来的Paint
    	Paint orgPaint=g.getPaint();
    	g.setColor(backgroundColor);
    	
    	g.fillRoundRect(x, y+32, width, height-32, 0, 0);
    	
    	g.setPaint(orgPaint);
    	//g.draw(rect);
    	g.setPaint(originalPaint);
    	canvas.drawTaskText(textName,graphicInfo);
    	//canvas.drawUserTaskImage(graphicInfo,1.0);
      }
    
	protected Color getTimeoutStatusColor(String status){	
	     Color color=null;
	   	 String colorString=timeoutColors.get(status);
	   	 if(StringUtils.isNotEmpty(colorString)){
	   		 String[] rgb=colorString.split(",");
	   		 color=new Color(Integer.parseInt(rgb[0].trim()),Integer.parseInt(rgb[1].trim()), Integer.parseInt(rgb[2].trim()));
	   	 }
	   	 return color;
	}
	
    protected void drawActivity(ProcessDiagramCanvasExt processDiagramCanvas, BpmnModel bpmnModel, 
    	      FlowNode flowNode, Map<String,BpmNodeStatus> highLightedActivities, List<String> highLightedFlows, double scaleFactor) {
    	  
    		BpmNodeStatus bpmNodeStatus=highLightedActivities.get(flowNode.getId());
    		
    	    ActivityDrawInstruction drawInstruction = activityDrawInstructions.get(flowNode.getClass());
    	    GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(flowNode.getId()); 
    	    if (drawInstruction != null) {

    	      drawInstruction.draw(processDiagramCanvas, bpmnModel, flowNode);
    	      if(flowNode instanceof UserTask){
    	    	  UserTask t=(UserTask)flowNode;
	    	  	//判断其是否为超时字段，通过processDigramCanvas重新画
	      	      if(bpmNodeStatus!=null){
	      	    	 Color bgcolor=getTimeoutStatusColor(bpmNodeStatus.getTimeoutStatus());
	      	 	     if(bgcolor!=null){
	      	 	    	drawUserTaskSpec(processDiagramCanvas,t.getName(),graphicInfo,bgcolor);
	      	    	 }
	      	      }
    	      }

    	      // Gather info on the multi instance marker
    	      boolean multiInstanceSequential = false, multiInstanceParallel = false, collapsed = false;
    	      if (flowNode instanceof Activity) {
    	        Activity activity = (Activity) flowNode;
    	        MultiInstanceLoopCharacteristics multiInstanceLoopCharacteristics = activity.getLoopCharacteristics();
    	        if (multiInstanceLoopCharacteristics != null) {
    	          multiInstanceSequential = multiInstanceLoopCharacteristics.isSequential();
    	          multiInstanceParallel = !multiInstanceSequential;
    	        }
    	      }

    	      // Gather info on the collapsed marker
    	      //GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(flowNode.getId()); 
    	      if (flowNode instanceof SubProcess) {
    	        collapsed = graphicInfo.getExpanded() != null && !graphicInfo.getExpanded();
    	      } else if (flowNode instanceof CallActivity) {
    	        collapsed = true;
    	      }

    	      if (scaleFactor == 1.0) {
    	        // Actually draw the markers
    	        processDiagramCanvas.drawActivityMarkers((int) graphicInfo.getX(), (int) graphicInfo.getY(),(int) graphicInfo.getWidth(), (int) graphicInfo.getHeight(), 
    	                multiInstanceSequential, multiInstanceParallel, collapsed);
    	      }
    	      
    	      // Draw highlighted activities
    	      if (highLightedActivities.containsKey(flowNode.getId())) {
    	    	 String colorString=processColors.get(bpmNodeStatus.getJumpType());
    	    	 Color color=null;
    	    	 if(StringUtils.isNotEmpty(colorString)){
    	    		 String[] rgb=colorString.split(",");
    	    		 color=new Color(Integer.parseInt(rgb[0].trim()),Integer.parseInt(rgb[1].trim()), Integer.parseInt(rgb[2].trim()));
    	    	 }
    	        drawHighLight(processDiagramCanvas, bpmnModel.getGraphicInfo(flowNode.getId()),color,flowNode);
    	      }
    	    }
    	    
    	    // Outgoing transitions of activity
    	    for (SequenceFlow sequenceFlow : flowNode.getOutgoingFlows()) {
    	      boolean highLighted = (highLightedFlows.contains(sequenceFlow.getId()));
    	      String defaultFlow = null;
    	      if (flowNode instanceof Activity) {
    	        defaultFlow = ((Activity) flowNode).getDefaultFlow();
    	      } else if (flowNode instanceof Gateway) {
    	        defaultFlow = ((Gateway) flowNode).getDefaultFlow();
    	      }
    	      
    	      boolean isDefault = false;
    	      if (defaultFlow != null && defaultFlow.equalsIgnoreCase(sequenceFlow.getId())) {
    	        isDefault = true;
    	      }
    	      boolean drawConditionalIndicator = sequenceFlow.getConditionExpression() != null && !(flowNode instanceof Gateway);
    	      
    	      String sourceRef = sequenceFlow.getSourceRef();
    	      String targetRef = sequenceFlow.getTargetRef();
    	      FlowElement sourceElement = bpmnModel.getFlowElement(sourceRef);
    	      FlowElement targetElement = bpmnModel.getFlowElement(targetRef);
    	      List<GraphicInfo> graphicInfoList = bpmnModel.getFlowLocationGraphicInfo(sequenceFlow.getId());
    	      if (graphicInfoList != null && graphicInfoList.size() > 0) {
    	        graphicInfoList = connectionPerfectionizer(processDiagramCanvas, bpmnModel, sourceElement, targetElement, graphicInfoList);
    	        int xPoints[]= new int[graphicInfoList.size()];
    	        int yPoints[]= new int[graphicInfoList.size()];
    	        
    	        for (int i=1; i<graphicInfoList.size(); i++) {
    	          graphicInfo = graphicInfoList.get(i);
    	          GraphicInfo previousGraphicInfo = graphicInfoList.get(i-1);
    	          
    	          if (i == 1) {
    	            xPoints[0] = (int) previousGraphicInfo.getX();
    	            yPoints[0] = (int) previousGraphicInfo.getY();
    	          }
    	          xPoints[i] = (int) graphicInfo.getX();
    	          yPoints[i] = (int) graphicInfo.getY();
    	        }
    	  
    	        processDiagramCanvas.drawSequenceflow(xPoints, yPoints, drawConditionalIndicator, isDefault, highLighted, scaleFactor);
    	  
    	        // Draw sequenceflow label
    	        GraphicInfo labelGraphicInfo = bpmnModel.getLabelGraphicInfo(sequenceFlow.getId());
    	        if (labelGraphicInfo != null) {
    	          processDiagramCanvas.drawLabel(sequenceFlow.getName(), labelGraphicInfo, false);
    	        }
    	      }
    	    }

    	    // Nested elements
    	    if (flowNode instanceof FlowElementsContainer) {
    	      for (FlowElement nestedFlowElement : ((FlowElementsContainer) flowNode).getFlowElements()) {
    	        if (nestedFlowElement instanceof FlowNode) {
    	          drawActivity(processDiagramCanvas, bpmnModel, (FlowNode) nestedFlowElement, highLightedActivities, highLightedFlows, scaleFactor);
    	        }
    	      }
    	    }
    	  }
    
    
    @Override
    public InputStream generateDiagram(BpmnModel bpmnModel, String imageType, Map<String,BpmNodeStatus> highLightedActivities,
    		List<String> highLightedFlows, String activityFontName,
    		String labelFontName, ClassLoader customClassLoader, double scaleFactor) {
    	return generateProcessDiagram(bpmnModel,imageType,highLightedActivities,highLightedFlows,activityFontName,
    			labelFontName,customClassLoader,scaleFactor).generateImage(imageType);
    }
    
    private static void drawHighLight(ProcessDiagramCanvasExt processDiagramCanvas, GraphicInfo graphicInfo,Color color,FlowNode flowNode) {
        processDiagramCanvas.drawHighLight((int) graphicInfo.getX(), (int) graphicInfo.getY(), (int) graphicInfo.getWidth(), (int) graphicInfo.getHeight(),color,flowNode);
    }
    
    
    protected DefaultProcessDiagramCanvas generateProcessDiagram(BpmnModel bpmnModel, String imageType, 
    	      List<String> highLightedActivities, List<String> highLightedFlows,
    	      String activityFontName, String labelFontName, ClassLoader customClassLoader, double scaleFactor) {
    	  	
    	  	prepareBpmnModel(bpmnModel);
    	    
    	    DefaultProcessDiagramCanvas processDiagramCanvas = initProcessDiagramCanvas(bpmnModel, imageType, activityFontName, labelFontName, customClassLoader);
    	    
    	    // Draw pool shape, if process is participant in collaboration
    	    for (Pool pool : bpmnModel.getPools()) {
    	      GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(pool.getId());
    	      processDiagramCanvas.drawPoolOrLane(pool.getName(), graphicInfo);
    	    }
    	    
    	    // Draw lanes
    	    for (Process process : bpmnModel.getProcesses()) {
    	      for (Lane lane : process.getLanes()) {
    	        GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(lane.getId());
    	        processDiagramCanvas.drawPoolOrLane(lane.getName(), graphicInfo);
    	      }
    	    }
    	    
    	    // Draw activities and their sequence-flows
    	    for (FlowNode flowNode : bpmnModel.getProcesses().get(0).findFlowElementsOfType(FlowNode.class)) {
    	      drawActivity(processDiagramCanvas, bpmnModel, flowNode, highLightedActivities, highLightedFlows, scaleFactor);
    	    }
    	    
    	    // Draw artifacts
    	    for (Process process : bpmnModel.getProcesses()) {
    	      for (Artifact artifact : process.getArtifacts()) {
    	        drawArtifact(processDiagramCanvas, bpmnModel, artifact);
    	      }
    	    }
    	    
    	    return processDiagramCanvas;
    }

    /**
     * 从父类中拷贝，修改了return语句所使用的绘图画板类
     *
     * @param bpmnModel
     * @param imageType
     * @param activityFontName
     * @param labelFontName
     * @param customClassLoader
     * @return
     */
    protected static ProcessDiagramCanvasExt initProcessDiagramCanvas(BpmnModel bpmnModel, String imageType,
                                                                          String activityFontName, String labelFontName, ClassLoader customClassLoader) {
    	 // We need to calculate maximum values to know how big the image will be in its entirety
        double minX = Double.MAX_VALUE;
        double maxX = 0;
        double minY = Double.MAX_VALUE;
        double maxY = 0;

        for (Pool pool : bpmnModel.getPools()) {
          GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(pool.getId());
          minX = graphicInfo.getX();
          maxX = graphicInfo.getX() + graphicInfo.getWidth();
          minY = graphicInfo.getY();
          maxY = graphicInfo.getY() + graphicInfo.getHeight();
        }
        
        List<FlowNode> flowNodes = gatherAllFlowNodes(bpmnModel);
        for (FlowNode flowNode : flowNodes) {

          GraphicInfo flowNodeGraphicInfo = bpmnModel.getGraphicInfo(flowNode.getId());
          
          // width
          if (flowNodeGraphicInfo.getX() + flowNodeGraphicInfo.getWidth() > maxX) {
            maxX = flowNodeGraphicInfo.getX() + flowNodeGraphicInfo.getWidth();
          }
          if (flowNodeGraphicInfo.getX() < minX) {
            minX = flowNodeGraphicInfo.getX();
          }
          // height
          if (flowNodeGraphicInfo.getY() + flowNodeGraphicInfo.getHeight() > maxY) {
            maxY = flowNodeGraphicInfo.getY() + flowNodeGraphicInfo.getHeight();
          }
          if (flowNodeGraphicInfo.getY() < minY) {
            minY = flowNodeGraphicInfo.getY();
          }

          for (SequenceFlow sequenceFlow : flowNode.getOutgoingFlows()) {
            List<GraphicInfo> graphicInfoList = bpmnModel.getFlowLocationGraphicInfo(sequenceFlow.getId());
            if (graphicInfoList != null) {
              for (GraphicInfo graphicInfo : graphicInfoList) {
                // width
                if (graphicInfo.getX() > maxX) {
                  maxX = graphicInfo.getX();
                }
                if (graphicInfo.getX() < minX) {
                  minX = graphicInfo.getX();
                }
                // height
                if (graphicInfo.getY() > maxY) {
                  maxY = graphicInfo.getY();
                }
                if (graphicInfo.getY()< minY) {
                  minY = graphicInfo.getY();
                }
              }
            }
          }
        }
        
        List<Artifact> artifacts = gatherAllArtifacts(bpmnModel);
        for (Artifact artifact : artifacts) {

          GraphicInfo artifactGraphicInfo = bpmnModel.getGraphicInfo(artifact.getId());
          
          if (artifactGraphicInfo != null) {
    	      // width
    	      if (artifactGraphicInfo.getX() + artifactGraphicInfo.getWidth() > maxX) {
    	        maxX = artifactGraphicInfo.getX() + artifactGraphicInfo.getWidth();
    	      }
    	      if (artifactGraphicInfo.getX() < minX) {
    	        minX = artifactGraphicInfo.getX();
    	      }
    	      // height
    	      if (artifactGraphicInfo.getY() + artifactGraphicInfo.getHeight() > maxY) {
    	        maxY = artifactGraphicInfo.getY() + artifactGraphicInfo.getHeight();
    	      }
    	      if (artifactGraphicInfo.getY() < minY) {
    	        minY = artifactGraphicInfo.getY();
    	      }
          }

          List<GraphicInfo> graphicInfoList = bpmnModel.getFlowLocationGraphicInfo(artifact.getId());
          if (graphicInfoList != null) {
    	      for (GraphicInfo graphicInfo : graphicInfoList) {
    	          // width
    	          if (graphicInfo.getX() > maxX) {
    	            maxX = graphicInfo.getX();
    	          }
    	          if (graphicInfo.getX() < minX) {
    	            minX = graphicInfo.getX();
    	          }
    	          // height
    	          if (graphicInfo.getY() > maxY) {
    	            maxY = graphicInfo.getY();
    	          }
    	          if (graphicInfo.getY()< minY) {
    	            minY = graphicInfo.getY();
    	          }
    	      }
          }
        }
        
        int nrOfLanes = 0;
        for (Process process : bpmnModel.getProcesses()) {
          for (Lane l : process.getLanes()) {
            
            nrOfLanes++;
            
            GraphicInfo graphicInfo = bpmnModel.getGraphicInfo(l.getId());
            // // width
            if (graphicInfo.getX() + graphicInfo.getWidth() > maxX) {
              maxX = graphicInfo.getX() + graphicInfo.getWidth();
            }
            if (graphicInfo.getX() < minX) {
              minX = graphicInfo.getX();
            }
            // height
            if (graphicInfo.getY() + graphicInfo.getHeight() > maxY) {
              maxY = graphicInfo.getY() + graphicInfo.getHeight();
            }
            if (graphicInfo.getY() < minY) {
              minY = graphicInfo.getY();
            }
          }
        }
        
        // Special case, see https://activiti.atlassian.net/browse/ACT-1431
        if (flowNodes.isEmpty() && bpmnModel.getPools().isEmpty() && nrOfLanes == 0) {
          // Nothing to show
          minX = 0;
          minY = 0;
        }

        // 用修复的办法处理绘图
        return new ProcessDiagramCanvasExt((int) maxX + 10, (int) maxY + 10, (int) minX, (int) minY,
                imageType, activityFontName, labelFontName, customClassLoader);

    }
}
