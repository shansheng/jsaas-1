package com.redxun.ui.grid.column.render;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.core.entity.GridHeader;
import com.redxun.core.util.DateUtil;
import com.redxun.sys.core.enums.MiniGridColumnType;

public class MiniGridColumnRenderDate implements MiniGridColumnRender{
	
	protected  Logger logger=LogManager.getLogger(MiniGridColumnRenderDate.class);
	
	@Override
	public String getRenderType() {
		return MiniGridColumnType.DATE.name();
	}

	@Override
	public String render(GridHeader gridHeader, Map<String,Object> rowData,Object val, boolean isExport) {
		if(val==null) return "";
		String format=gridHeader.getRenderConfObj().getString("format");
		if(StringUtils.isEmpty(format)) {
			format="yyyy-MM-dd";
		}
		DateFormat df=new SimpleDateFormat(format);
		try{
			if(val instanceof Date){
				return df.format((Date)val);
			}else{
				Date ndate=DateUtil.parseDate(val.toString());
				return df.format(ndate);
			}
		}catch(Exception e){
			logger.error(e.getMessage());
			return val.toString();
		}
	}

}
