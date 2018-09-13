package com.ccgx.common.table2excel.bean;

@com.fasterxml.jackson.annotation.JsonIgnoreProperties(ignoreUnknown = true)
public class BaseBean {
    @com.fasterxml.jackson.annotation.JsonProperty("text")
    private String text;
    @com.fasterxml.jackson.annotation.JsonProperty("rowspan")
    private String rowspan;
    @com.fasterxml.jackson.annotation.JsonProperty("colspan")
    private String colspan;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getRowspan() {
        return rowspan;
    }

    public void setRowspan(String rowspan) {
        this.rowspan = rowspan;
    }

    public String getColspan() {
        return colspan;
    }

    public void setColspan(String colspan) {
        this.colspan = colspan;
    }
}
