package com.airdrop.common.util;

/**
 * @author aichen.yang
 * @ClassName: ResultMap
 * @Description: 返回结果封装类
 * @company: airdrop
 * @date 2017-10-16 上午08:42:20
 */
public class ResResult {
    private int resCode;//返回的错误代码
    private String resMsg;//返回的信息
    private ResultMap result;//返回的结果
    private Long time = System.currentTimeMillis() / 1000;

    public Long getTime() {
        return time;
    }

    public void setTime(Long time) {
        this.time = time;
    }

    public int getResCode() {
        return resCode;
    }

    public void setResCode(int resCode) {
        this.resCode = resCode;
    }

    public String getResMsg() {
        return resMsg;
    }

    public void setResMsg(String resMsg) {
        this.resMsg = resMsg;
    }

    public ResultMap getResult() {
        return result;
    }

    public void setResult(ResultMap result) {
        this.result = result;
    }


}
