package com.redxun.bpm.form.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.redxun.sys.bo.entity.SysBoAttr;

public class SysBoAttrJdbc implements RowMapper<SysBoAttr> {

	@Override
	public SysBoAttr mapRow(ResultSet rs, int row) throws SQLException {
		SysBoAttr sys = new SysBoAttr();
		sys.setName(rs.getString("NAME_"));
		sys.setComment(rs.getString("COMMENT_"));
		return sys;
	}

}
