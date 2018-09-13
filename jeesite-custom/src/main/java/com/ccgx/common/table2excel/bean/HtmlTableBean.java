package com.ccgx.common.table2excel.bean;

import java.util.List;

/**
 * Created by Huangyun on 2018/8/4 0004.
 */
@com.fasterxml.jackson.annotation.JsonIgnoreProperties(ignoreUnknown = true)
public class HtmlTableBean {

    @com.fasterxml.jackson.annotation.JsonProperty("heads")
    private List<List<HeadsBean>> heads;
    @com.fasterxml.jackson.annotation.JsonProperty("bodys")
    private List<List<BodysBean>> bodys;
    @com.fasterxml.jackson.annotation.JsonProperty("foots")
    private List<List<FootsBean>> foots;

    public List<List<HeadsBean>> getHeads() {
        return heads;
    }

    public void setHeads(List<List<HeadsBean>> heads) {
        this.heads = heads;
    }

    public List<List<BodysBean>> getBodys() {
        return bodys;
    }

    public void setBodys(List<List<BodysBean>> bodys) {
        this.bodys = bodys;
    }

    public List<List<FootsBean>> getFoots() {
        return foots;
    }

    public void setFoots(List<List<FootsBean>> foots) {
        this.foots = foots;
    }

}
