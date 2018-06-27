package com.itender.ms.workflow.service;


import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Service;


@Service
public class BaseService   {



    public Object get(String className, String id) {

          //如何产生该类的对象呢？
        try {
            Class clazz = null;
            try {
                clazz = Class.forName(className);
                Object obj  = clazz.newInstance();
                return obj;
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
    }


}
