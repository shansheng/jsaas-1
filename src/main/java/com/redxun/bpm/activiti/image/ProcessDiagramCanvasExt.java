package com.redxun.bpm.activiti.image;

import java.awt.*;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.TextAttribute;
import java.awt.font.TextLayout;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.awt.image.ImageObserver;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;
import java.util.ArrayList;
import java.util.List;

import org.activiti.bpmn.model.*;
import org.activiti.bpmn.model.Process;
import org.activiti.image.impl.DefaultProcessDiagramCanvas;

/**o
 * 基于Activiti的流程图画布
 * 
 * 解决 Activiti 5.18 中绘图字体太小造成中文显示不清晰的问题
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessDiagramCanvasExt extends DefaultProcessDiagramCanvas {
    /**
     * 边框大小
     */
    protected static final BasicStroke BS_BORDER=new BasicStroke(1.5f);
    /**
     * 连接线大小
     */
    protected static final BasicStroke BS_CONNECTION=new BasicStroke(1.5f);
    /**
     * 线条颜色
     */
    protected static final Color BORDER_COLOR=new Color(18,183,245);
    /**
     * 填充颜色
     */
    protected static final Color FILL_COLOR=new Color(18,183,245);

    public ProcessDiagramCanvasExt(int width, int height, int minX, int minY, String imageType, String activityFontName, String labelFontName, ClassLoader customClassLoader) {
        super(width, height, minX, minY, imageType, activityFontName, labelFontName, customClassLoader);
    }

    public ProcessDiagramCanvasExt(int width, int height, int minX, int minY, String imageType) {
        super(width, height, minX, minY, imageType);
    }

    @Override
    public void initialize(String imageType) {
        super.initialize(imageType);
        Font font = new Font(activityFontName, Font.PLAIN, 12); // 去除粗体造成的边沿模糊
        ANNOTATION_FONT = new Font(activityFontName, Font.PLAIN, 12);
        g.setFont(font);
        this.fontMetrics = g.getFontMetrics();

        LABEL_FONT = new Font(labelFontName, Font.ITALIC, 12);
    }

    public Graphics2D getGraphics2d() {
        return this.g;
    }
    
    public void drawNoneEndEvent(GraphicInfo graphicInfo, double scaleFactor) {
        Paint originalPaint = g.getPaint();
        Stroke originalStroke = g.getStroke();
        g.setPaint(EVENT_COLOR);
        Ellipse2D circle = new Ellipse2D.Double(graphicInfo.getX(), graphicInfo.getY(), 
            graphicInfo.getWidth(), graphicInfo.getHeight());
        g.fill(circle);
        g.setPaint(BORDER_COLOR);
        if (scaleFactor == 1.0) {
          g.setStroke(END_EVENT_STROKE);
        } else {
          g.setStroke(new BasicStroke(2.0f));
        }
        g.draw(circle);
        g.setStroke(originalStroke);
        g.setPaint(originalPaint);
      }
    
    @Override
    public void drawErrorEndEvent(GraphicInfo graphicInfo, double scaleFactor) {
    	// TODO Auto-generated method stub
    	super.drawErrorEndEvent(graphicInfo, scaleFactor);
    }

    public void drawStartEvent(GraphicInfo graphicInfo, BufferedImage image, double scaleFactor) {
        Paint originalPaint = g.getPaint();
        g.setPaint(FILL_COLOR);
        Ellipse2D circle = new Ellipse2D.Double(graphicInfo.getX(), graphicInfo.getY(),
                graphicInfo.getWidth(), graphicInfo.getHeight());
        g.fill(circle);
        
        g.setStroke(BS_BORDER);
        g.draw(circle);
        g.setPaint(originalPaint);

        if (image != null) {
            // calculate coordinates to center image
            int imageX = (int) Math.round(graphicInfo.getX() + (graphicInfo.getWidth() / 2) - (image.getWidth() / 2 * scaleFactor));
            int imageY = (int) Math.round(graphicInfo.getY() + (graphicInfo.getHeight() / 2) - (image.getHeight() / 2 * scaleFactor));
            g.drawImage(image, imageX, imageY,
                    (int) (image.getWidth() / scaleFactor), (int) (image.getHeight() / scaleFactor), null);
        }

    }
    
    public void drawHighLight(int x, int y, int width, int height, Color color,FlowNode flowNode) {
        Paint originalPaint = g.getPaint();
        Stroke originalStroke = g.getStroke();
        //缺省颜色
        if (color == null) {
            color = new Color(132, 218, 69);
        }
        g.setPaint(color);
        g.setStroke(BS_BORDER);

        if(flowNode instanceof StartEvent || flowNode instanceof EndEvent){
            g.drawOval(x,y,width, height);
        }else if(flowNode instanceof InclusiveGateway) {
        	drawInclusiveGateway(x,y,width,height);
        }else if(flowNode instanceof ExclusiveGateway) {
        	drawExclusiveGateway(x,y,width,height);
        } else if(flowNode instanceof ParallelGateway) {
        	drawParallelGateway(x,y,width,height);
        }else{
        	RoundRectangle2D rect = new RoundRectangle2D.Double(x, y+32, width, height-32, 0, 0);
            //RoundRectangle2D rect = new RoundRectangle2D.Double(x, y, width, height, 12, 12);
            g.draw(rect);
        }

        g.setPaint(originalPaint);
        g.setStroke(originalStroke);
    }
    
    public void drawParallelGateway(int x, int y, int width, int height) {
         
          Line2D.Double line = new Line2D.Double(x + 10, y + height / 2, x + width - 10, y + height / 2); // horizontal
          g.draw(line);
          line = new Line2D.Double(x + width / 2, y + height - 10, x + width / 2, y + 10); // vertical
          g.draw(line);
         
      }

      public void drawExclusiveGateway(int x, int y, int width, int height) {
	        int quarterWidth = width / 4;
	        int quarterHeight = height / 4;

          Line2D.Double line = new Line2D.Double(x + quarterWidth + 3, y + quarterHeight + 3, x + 3 * quarterWidth - 3, y + 3 * quarterHeight - 3);
          g.draw(line);
          line = new Line2D.Double(x + quarterWidth + 3, y + 3 * quarterHeight - 3, x + 3 * quarterWidth - 3, y + quarterHeight + 3);
          g.draw(line);

      }

      public void drawInclusiveGateway(int x, int y, int width, int height) {
    	  int diameter = width / 2;
          Ellipse2D.Double circle = new Ellipse2D.Double(((width - diameter) / 2) + x, ((height - diameter) / 2) + y, diameter, diameter);
          g.draw(circle);
      }

    @Override
    public void drawUserTask(String name, GraphicInfo graphicInfo, double scaleFactor) {
    	// TODO Auto-generated method stub
    	super.drawUserTask(name, graphicInfo, scaleFactor);
    }

    public void drawTask(BufferedImage icon, String name, GraphicInfo graphicInfo, double scaleFactor) {
        drawTask(name, graphicInfo);
        int x=(int)(graphicInfo.getX()+(graphicInfo.getWidth()-icon.getWidth())/2);
        int y= (int) (graphicInfo.getY() + ICON_PADDING / scaleFactor);
        g.drawImage(icon, x,y, (int) (icon.getWidth() / scaleFactor), (int) (icon.getHeight() / scaleFactor), null);
      }

    public void drawInclusiveGateway(GraphicInfo graphicInfo, double scaleFactor) {
    	 g.setPaint(BORDER_COLOR);
    	 g.setStroke(new BasicStroke(2.0f));
        drawGateway(graphicInfo);
        int x = (int) graphicInfo.getX();
        int y = (int) graphicInfo.getY();
        int width = (int) graphicInfo.getWidth();
        int height = (int) graphicInfo.getHeight();

        int diameter = width / 2;

        if (scaleFactor == 1.0) {
          // circle inside rhombus
          Stroke orginalStroke = g.getStroke();
          g.setStroke(GATEWAY_TYPE_STROKE);
          Ellipse2D.Double circle = new Ellipse2D.Double(((width - diameter) / 2) + x, ((height - diameter) / 2) + y, diameter, diameter);
          g.draw(circle);
          g.setStroke(orginalStroke);
        }
    }
    
    @Override
    public void drawExclusiveGateway(GraphicInfo graphicInfo, double scaleFactor) {
    	 g.setPaint(BORDER_COLOR);
    	 g.setStroke(new BasicStroke(2.0f));
        drawGateway(graphicInfo);
        int x = (int) graphicInfo.getX();
        int y = (int) graphicInfo.getY();
        int width = (int) graphicInfo.getWidth();
        int height = (int) graphicInfo.getHeight();

        int quarterWidth = width / 4;
        int quarterHeight = height / 4;
       
        if (scaleFactor == 1.0) {
          // X inside rhombus
          Stroke orginalStroke = g.getStroke();
         
          Line2D.Double line = new Line2D.Double(x + quarterWidth + 3, y + quarterHeight + 3, x + 3 * quarterWidth - 3, y + 3 * quarterHeight - 3);
          g.draw(line);
          line = new Line2D.Double(x + quarterWidth + 3, y + 3 * quarterHeight - 3, x + 3 * quarterWidth - 3, y + quarterHeight + 3);
          g.draw(line);
          g.setStroke(orginalStroke);
        }
    	//super.drawExclusiveGateway(graphicInfo, scaleFactor);
    }

    protected void drawTask(String name, GraphicInfo graphicInfo, boolean thickBorder) {
        Paint originalPaint = g.getPaint();
        int x = (int) graphicInfo.getX();
        int y = (int) graphicInfo.getY();
        int width = (int) graphicInfo.getWidth();
        int height = (int) graphicInfo.getHeight();

        // Create a new gradient paint for every task box, gradient depends on x and y and is not relative
        g.setPaint(TASK_BOX_COLOR);

        int arcR = 5;
        if (thickBorder)
            arcR = 5;

        // shape
        RoundRectangle2D rect = new RoundRectangle2D.Double(x, y, width, height, arcR, arcR);
        g.fill(rect);
        //g.setPaint(new  Color(224,224,224));
        g.setPaint(FILL_COLOR);

        RoundRectangle2D rect2 = new RoundRectangle2D.Double(x, y+32, width, height-32, 0, 0);
        g.fill(rect2);
        //if (thickBorder) {
        Stroke originalStroke = g.getStroke();
        g.setStroke(new BasicStroke(2.0f));
        g.draw(rect);
        g.setStroke(originalStroke);

        g.setPaint(originalPaint);
        // text
        if (name != null && name.length() > 0) {
            int boxWidth = width - (2 * TEXT_PADDING);
//          int boxHeight = height - 16 - ICON_PADDING - ICON_PADDING - MARKER_WIDTH - 2 - 2;
            int boxHeight = height - ICON_PADDING - ICON_PADDING - MARKER_WIDTH - 2 - 2;

            int boxX = x + width / 2 - boxWidth / 2;
            int boxY = y + height / 2 - boxHeight / 2 + ICON_PADDING + ICON_PADDING - 2 - 2;

            drawMultilineText2(name, boxX, boxY, boxWidth, boxHeight,true);
        }
    }


    public void drawUserTaskImage(GraphicInfo graphicInfo, double scaleFactor) {
        g.drawImage(USERTASK_IMAGE, (int) (graphicInfo.getX() + ICON_PADDING / scaleFactor),
                (int) (graphicInfo.getY() + ICON_PADDING / scaleFactor),
                (int) (USERTASK_IMAGE.getWidth() / scaleFactor), (int) (USERTASK_IMAGE.getHeight() / scaleFactor), null);
    }

    public void drawTaskText(String text, GraphicInfo graphicInfo) {
        int x = (int) graphicInfo.getX();
        int y = (int) graphicInfo.getY();
        int width = (int) graphicInfo.getWidth();
        int height = (int) graphicInfo.getHeight();

        // text
        if (text != null && text.length() > 0) {
            int boxWidth = width - (2 * TEXT_PADDING);
            int boxHeight = height - ICON_PADDING - ICON_PADDING - MARKER_WIDTH - 2 - 2;

            int boxX = x + width / 2 - boxWidth / 2;
            int boxY = y + height / 2 - boxHeight / 2 + ICON_PADDING + ICON_PADDING - 2 - 2;

            drawMultilineText2(text, boxX, boxY, boxWidth, boxHeight, true);
        }
    }


    protected void drawMultilineText2(String text, int x, int y, int boxWidth, int boxHeight, boolean centered) {
       
    	
    	  // Create an attributed string based in input text
        AttributedString attributedString = new AttributedString(text);
        attributedString.addAttribute(TextAttribute.FONT, g.getFont());
        //attributedString.addAttribute(TextAttribute.WEIGHT,3.0f);
        attributedString.addAttribute(TextAttribute.FOREGROUND, Color.white);
        
        AttributedCharacterIterator characterIterator = attributedString.getIterator();
        
        int currentHeight = 0;
        // Prepare a list of lines of text we'll be drawing
        List<TextLayout> layouts = new ArrayList<TextLayout>();
        String lastLine = null;
        
        LineBreakMeasurer measurer = new LineBreakMeasurer(characterIterator, g.getFontRenderContext());
        
        TextLayout layout = null;
        while (measurer.getPosition() < characterIterator.getEndIndex() && currentHeight <= boxHeight) {
           
          int previousPosition = measurer.getPosition();
          
          // Request next layout
          layout = measurer.nextLayout(boxWidth);
          
          int height = ((Float)(layout.getDescent() + layout.getAscent() + layout.getLeading())).intValue();
          
          if(currentHeight + height > boxHeight) {
            // The line we're about to add should NOT be added anymore, append three dots to previous one instead
            // to indicate more text is truncated
            if (!layouts.isEmpty()) {
              layouts.remove(layouts.size() - 1);
              
              if(lastLine.length() >= 4) {
                lastLine = lastLine.substring(0, lastLine.length() - 4) + "...";
              }
              layouts.add(new TextLayout(lastLine, g.getFont(), g.getFontRenderContext()));
            }
            break;
          } else {
            layouts.add(layout);
            lastLine = text.substring(previousPosition, measurer.getPosition());
            currentHeight += height;
          }
        }
        
        
        int currentY = y + (centered ? ((boxHeight - currentHeight) /2+6) : 0);
        int currentX = 0;
        
        // Actually draw the lines
        for(TextLayout textLayout : layouts) {
          
          currentY += textLayout.getAscent();
          currentX = x + (centered ? ((boxWidth - ((Double)textLayout.getBounds().getWidth()).intValue()) /2) : 0);
          
          textLayout.draw(g, currentX, currentY);
          currentY += textLayout.getDescent() + textLayout.getLeading();
        }
    	
    }



    public void drawConnection(int[] xPoints, int[] yPoints, boolean conditional, boolean isDefault, String connectionType,
                               AssociationDirection associationDirection, boolean highLighted, double scaleFactor) {

        Paint originalPaint = g.getPaint();
        Stroke originalStroke = g.getStroke();
        g.setPaint(BORDER_COLOR);
        
        if (connectionType.equals("association")) {
            g.setStroke(ASSOCIATION_STROKE);
        } else if (highLighted) {
            g.setPaint(new Color(132, 218, 69));
            g.setStroke(new BasicStroke(1.5f));
        } else {
        	  g.setStroke(new BasicStroke(1.5f));
        }

        for (int i = 1; i < xPoints.length; i++) {
            Integer sourceX = xPoints[i - 1];
            Integer sourceY = yPoints[i - 1];
            Integer targetX = xPoints[i];
            Integer targetY = yPoints[i];
            Line2D.Double line = new Line2D.Double(sourceX, sourceY, targetX, targetY);
            g.draw(line);
        }

        if (isDefault) {
            Line2D.Double line = new Line2D.Double(xPoints[0], yPoints[0], xPoints[1], yPoints[1]);
            drawDefaultSequenceFlowIndicator(line, 0.6);
        }

        if (conditional) {
            Line2D.Double line = new Line2D.Double(xPoints[0], yPoints[0], xPoints[1], yPoints[1]);
            drawConditionalSequenceFlowIndicator(line, 0.6);
        }

        if (associationDirection.equals(AssociationDirection.ONE) || associationDirection.equals(AssociationDirection.BOTH)) {
            Line2D.Double line = new Line2D.Double(xPoints[xPoints.length - 2], yPoints[xPoints.length - 2], xPoints[xPoints.length - 1], yPoints[xPoints.length - 1]);
            drawArrowHead(line, 0.6);
        }
        if (associationDirection.equals(AssociationDirection.BOTH)) {
            Line2D.Double line = new Line2D.Double(xPoints[1], yPoints[1], xPoints[0], yPoints[0]);
            drawArrowHead(line, 0.6);
        }
        g.setPaint(originalPaint);
        g.setStroke(originalStroke);
    }

}
