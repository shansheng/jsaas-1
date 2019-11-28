package com.redxun.core.database;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.core.database.api.ITableOperator;
import com.redxun.core.database.api.model.Column;
import com.redxun.core.database.api.model.Table;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.database.model.DefaultColumn;
import com.redxun.core.database.model.DefaultTable;
import com.redxun.test.BaseTestCase;

public class DbTest extends BaseTestCase {
	
	@Resource
	ITableOperator tableOperator;
	
	//@Test
	public void createTable() throws SQLException{
		Table table=new DefaultTable();
		table.setTableName("w_createtable");
		table.setComment("创建表");
		
		Column colpk=new DefaultColumn();
		colpk.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colpk.setCharLen(50);
		colpk.setFieldName("id_");
		colpk.setComment("主键");
		colpk.setIsPk(true);
		
		table.addColumn(colpk);
		
		Column col1=new DefaultColumn();
		col1.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		col1.setCharLen(50);
		col1.setFieldName("name");
		col1.setComment("姓名");
		
		table.addColumn(col1);
		
		tableOperator.createTable(table);
	}
	
	@Test
	public void getObject() throws Exception{
		//jssas
		 Connection conn= DataSourceUtil.getConnectionByAlias("huiyu");
		 String schemaPattern = "HUIYU";
		 
			DatabaseMetaData databaseMetaData = conn.getMetaData();
			ResultSet rs = databaseMetaData.getColumns(null, schemaPattern,
					"OS_USER".toUpperCase(), "");
			while (rs.next()) {
				System.out.println( rs.getString("COLUMN_NAME") +" " +rs.getString("REMARKS"));
			}
			rs.close();
			conn.close();
	}

}
