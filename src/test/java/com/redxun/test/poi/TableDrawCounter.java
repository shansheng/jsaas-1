/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.redxun.test.poi;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/**
 * 表格计算
 * @author csx
 */
public class TableDrawCounter {
	
    private int startRowIndex;
    private int startColIndex;
    private Workbook wb;
    private Sheet sheet;
    private int maxLevel=1;

    public Workbook getWb() {
        return wb;
    }
    public void setWb(Workbook wb) {
        this.wb = wb;
    }

    public Sheet getSheet() {
        return sheet;
    }

    public void setSheet(Sheet sheet) {
        this.sheet = sheet;
    }

    public int getStartRowIndex() {
        return startRowIndex;
    }

    public void setStartRowIndex(int startRowIndex) {
        this.startRowIndex = startRowIndex;
    }

    public int getStartColIndex() {
        return startColIndex;
    }

    public void setStartColIndex(int startColIndex) {
        this.startColIndex = startColIndex;
    }

    public TableDrawCounter(int startRowIndex, int startColIndex, int maxLevel,Workbook wb, Sheet sheet) {
        this.startRowIndex = startRowIndex;
        this.startColIndex = startColIndex;
        this.maxLevel=maxLevel;
        this.wb = wb;
        this.sheet = sheet;
    }

    public TableDrawCounter() {
    }

    public int getMaxLevel() {
        return maxLevel;
    }

    public void setMaxLevel(int maxLevel) {
        this.maxLevel = maxLevel;
    }

    
}
