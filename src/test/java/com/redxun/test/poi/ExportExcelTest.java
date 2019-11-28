/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.redxun.test.poi;

import java.io.FileOutputStream;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.junit.Test;

import com.redxun.sys.core.manager.SysGridFieldManager;
import com.redxun.test.BaseTestCase;
import com.redxun.ui.view.model.FieldColumn;
import com.redxun.ui.view.model.GroupColumn;
import com.redxun.ui.view.model.IGridColumn;

/**
 *
 * @author X230
 */
public class ExportExcelTest extends BaseTestCase{
    @Resource
    SysGridFieldManager sysGridFieldManager;
    
    @Test
    public void testExport(){
        String gridViewId="20000000324001";//"20000000093017";
        List<IGridColumn> columns=sysGridFieldManager.getColumnsByGridViewId(gridViewId);
        System.out.println("cal max level is:"+ calHeaderMaxRows(columns));
        int colNums=0;
        for(IGridColumn gc:columns){
            colNums+=calColumnChilds(gc);
        }
        System.out.println("total culumns:" + colNums);
    }
    
    public int calHeaderMaxRows(List<IGridColumn> columns){
        int maxChildLevel=1;

        for(IGridColumn col:columns){
            int tmpLevel=calColumnLevel(col);
            if(maxChildLevel<tmpLevel){
                maxChildLevel=tmpLevel;
            }
        }
        return maxChildLevel;
    }
    
    private int calColumnLevel(IGridColumn col){
        int level=1;
        int subLevel=0;
        if(col instanceof GroupColumn){
             subLevel=1;
             GroupColumn gc=(GroupColumn)col;
             for(int i=0;i<gc.getColumns().size();i++){
                 //取得子列下的最大层数
                 int maxLevl=calColumnLevel(gc.getColumns().get(i));
                 if(maxLevl>subLevel){
                     subLevel=maxLevl;
                 }
             }
        }
        return level+subLevel;
    }
    
    private int calMaxChildLevel(List<IGridColumn> cols){
        int maxLevl=1;
        for(IGridColumn gc:cols){
            int level=calColumnLevel(gc);
            if(maxLevl<level)maxLevl=level;
        }
        return maxLevl;
    }
   
    private int calColumnChilds(IGridColumn col){
        if(col instanceof FieldColumn) return 1;
        if(col instanceof GroupColumn){
            GroupColumn gc=(GroupColumn)col;
            int cn=0;
            for(IGridColumn gcn:gc.getColumns()){
                cn+=calColumnChilds(gcn);
            }
            return cn;
        }
        return 0;
    }
    
    public void genTableCell(List<IGridColumn> gridColumns,TableDrawCounter tdDraw){
        //计算同行中最大的层数
        int maxLevl=calMaxChildLevel(gridColumns);
        //保存当前索引行
        int rowIndex=tdDraw.getStartRowIndex();
        
        HSSFCellStyle cellStyle=(HSSFCellStyle)tdDraw.getWb().createCellStyle();
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框
                
        for(IGridColumn gc:gridColumns){
            Row row=tdDraw.getSheet().getRow(tdDraw.getStartRowIndex());
            if(row==null){
                row=tdDraw.getSheet().createRow(tdDraw.getStartRowIndex());
            }
            if(gc instanceof GroupColumn){
                //取得该组下的所有列
                int colNums=calColumnChilds(gc);
                //取得合并的最后序号
                int endColumnIndex=tdDraw.getStartColIndex()+colNums-1;
                GroupColumn gcTmp=(GroupColumn)gc;
                
                //创建合并区域
                CellRangeAddress cra=new CellRangeAddress(tdDraw.getStartRowIndex(),tdDraw.getStartRowIndex(),tdDraw.getStartColIndex(), endColumnIndex);
                tdDraw.getSheet().addMergedRegion(cra);
               
                //创建表格
                Cell cell=row.createCell(tdDraw.getStartColIndex());
                cell.setCellValue(gc.getHeader());
                cell.setCellStyle(cellStyle);
                //tdDraw.getSheet().setColumnWidth(tdDraw.getStartColIndex(), gc.getWidth());
                RegionUtil.setBorderBottom(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderTop(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderLeft(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderRight(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                
                //递增该列序号
                tdDraw.setStartRowIndex(tdDraw.getStartRowIndex()+1);
                genTableCell(gcTmp.getColumns(),tdDraw);
                //恢复原行号
                tdDraw.setStartRowIndex(rowIndex);
                
            }else if(gc instanceof FieldColumn){//为字段表头
                /**
                 * 当字段所在的行达不到最大行值时，合并其单元格至最大行
                 */
                int endRow=tdDraw.getStartRowIndex()+maxLevl-1;
                if(endRow<tdDraw.getMaxLevel()-1){
                    endRow=tdDraw.getMaxLevel()-1;
                }
                CellRangeAddress cra=new CellRangeAddress(tdDraw.getStartRowIndex(),endRow,tdDraw.getStartColIndex(), tdDraw.getStartColIndex());
                tdDraw.getSheet().addMergedRegion(cra);
                
                Cell cell=row.createCell(tdDraw.getStartColIndex());
                System.out.println("gc width:" + gc.getWidth());
                RegionUtil.setBorderBottom(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderTop(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderLeft(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                RegionUtil.setBorderRight(HSSFCellStyle.BORDER_THIN, cra, tdDraw.getSheet(), tdDraw.getWb());
                
                tdDraw.getSheet().setColumnWidth(tdDraw.getStartColIndex(), gc.getWidth());
                cell.setCellValue(gc.getHeader());
                cell.setCellStyle(cellStyle);
               
                //对列的索引行加1
                tdDraw.setStartColIndex(tdDraw.getStartColIndex()+1);
                
                
            }
        }
        
    }
    
    public void genExcel(List<IGridColumn> gridColumns) throws Exception{
        FileOutputStream fos=new FileOutputStream("D:\\demo1-2.xls");	
        Workbook wb=new HSSFWorkbook();
	Sheet sheet=wb.createSheet();
        
        //List<FieldColumn> fieldColumns=new ArrayList<FieldColumn>();
        Integer rowIndex=0;
        Integer colIndex=0;
        int maxLevel=calMaxChildLevel(gridColumns);
        TableDrawCounter counter=new TableDrawCounter(rowIndex,colIndex,maxLevel,wb,sheet);
        genTableCell(gridColumns,counter);
        wb.write(fos);
        fos.close();
    }
    
    @Test
    public void genHeaders() throws Exception{
        String gridViewId="20000000324001";//"20000000093017";
        List<IGridColumn> columns=sysGridFieldManager.getColumnsByGridViewId(gridViewId);
        genExcel(columns);
    }
    
    public static void main(String[]args){
        Integer cn=1;
        System.out.println("cn:"+cn);
        gen(cn);
        System.out.println("cn2:"+cn);
    }
    
    public static void gen(Integer cn){
        cn+=2;
    }
}
