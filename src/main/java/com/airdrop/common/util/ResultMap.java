package com.airdrop.common.util;

/**
 * @author aichen.yang
 * @ClassName: QesResult
 * @Description: 业务处理返回实体
 * @company: airdrop
 * @date 2017-10-16 上午08:49:23
 */
public class ResultMap {
    private Object data; //返回的结果
    private int resCode;//返回的错误代码
    private String resMsg;//返回的信息

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
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

}
