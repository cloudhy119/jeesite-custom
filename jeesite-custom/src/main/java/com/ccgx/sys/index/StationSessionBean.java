package com.ccgx.sys.index;

import java.io.Serializable;

/**
 * 将登陆用户所属或所选择的收费站信息存到session中
 */
public class StationSessionBean implements Serializable {
    private static final long serialVersionUID = 2230751798751524152L;
    private String id;
    private String name;
    private String tsCode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTsCode() {
        return tsCode;
    }

    public void setTsCode(String tsCode) {
        this.tsCode = tsCode;
    }
}
