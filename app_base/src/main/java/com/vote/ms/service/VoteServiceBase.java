package com.vote.ms.service;

import com.github.pagehelper.PageInfo;
import com.vote.ms.exception.APIException;

import java.util.List;

/**
 * 业务基础接口
 *
 * @author 陈泳君
 * @create 2018-01-02 下午3:30
 **/
public interface VoteServiceBase<T> {
    /**
     * 新建
     * @param t
     * @return
     * @throws APIException
     */
    T add(T t) throws APIException;

    /**
     * 查找所有
     * @return
     * @throws APIException
     */
    List<T> findAll() throws APIException;

    /**
     * 分页查找
     * @param pageNum
     * @param pagesize
     * @return
     * @throws APIException
     */
    PageInfo<T> findPage(Integer pageNum,Integer pagesize) throws APIException;

    /**
     * 按ID删除
     * @param id
     * @return
     */
    Integer deleteById(String id);

    /**
     * 按ID查找
     * @param id
     * @return
     */
    T findById(String id);

}
