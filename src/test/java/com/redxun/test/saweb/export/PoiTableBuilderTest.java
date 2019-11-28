package com.redxun.test.saweb.export;

import com.redxun.saweb.export.PoiTableBuilder;
import com.redxun.saweb.export.model.PoiTableHeader;
import com.redxun.sys.core.manager.SysGridFieldManager;
import com.redxun.test.BaseTestCase;
import com.redxun.ui.view.model.IGridColumn;
import java.io.FileOutputStream;
import java.util.List;
import javax.annotation.Resource;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.junit.Test;

/**
 *
 * @author csx
 */
public class PoiTableBuilderTest extends BaseTestCase{
    @Resource
    PoiTableBuilder builder;
    @Resource
    SysGridFieldManager sysGridFieldManager;
    
    @Test
    public void genTableHeader() throws Exception{
        String gridViewId="20000000324001";//"20000000093017";
        List<IGridColumn> columns=sysGridFieldManager.getColumnsByGridViewId(gridViewId);
        
        FileOutputStream fos=new FileOutputStream("D:\\demo1-2.xls");	
        Workbook wb=new HSSFWorkbook();
	Sheet sheet=wb.createSheet();
        
        //List<FieldColumn> fieldColumns=new ArrayList<FieldColumn>();
        Integer rowIndex=0;
        Integer colIndex=0;
        int maxRows=builder.calHeaderMaxRows(columns);
        PoiTableHeader counter=new PoiTableHeader(rowIndex,colIndex,maxRows,wb,sheet);
        builder.genTableHeader(columns,counter);
        wb.write(fos);
        fos.close();
    }
}
