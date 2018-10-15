package com.vote.ms.convert;

import com.github.pagehelper.PageInfo;

/**
 * 分页数据转换
 *
 * @author 陈泳君
 * @create 2017-12-28 下午2:21
 **/
public class PageDataConvert {

    /**
     * 转换为Layui的数据格式
     * @param pageInfo
     * @param statusCode
     * @param msg
     * @return
     */
    public static final LayuiTableData convertToLayuiData(PageInfo pageInfo,Integer statusCode,String msg) {
        LayuiTableData<Object> objectLayuiTableData = new LayuiTableData<>();
        objectLayuiTableData.setData(pageInfo.getList());
        objectLayuiTableData.setPageNum(pageInfo.getPageNum());
        objectLayuiTableData.setPages(pageInfo.getPages());
        objectLayuiTableData.setPageSize(pageInfo.getPageSize());
        objectLayuiTableData.setStatusCode(statusCode);
        objectLayuiTableData.setMsg(msg);
        objectLayuiTableData.setTotal(pageInfo.getTotal());
        return objectLayuiTableData;
    }
}
