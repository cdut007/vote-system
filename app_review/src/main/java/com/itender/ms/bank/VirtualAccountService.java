package com.itender.ms.bank;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.controller.VirtualAccountController;
import com.itender.ms.domain.TbVirtualAccount;
import com.itender.ms.domain.TbVirtualAccountExample;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.TbVirtualAccountMapper;
import com.itender.ms.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import tk.mybatis.mapper.entity.Example;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class VirtualAccountService {



    @Autowired
    private TbVirtualAccountMapper virtualAccountMapper;

    public PageInfo<TbVirtualAccount> findPage(Integer pageNum, Integer pagesize) throws APIException {
        PageHelper.startPage(pageNum,pagesize);

        TbVirtualAccountExample example = new TbVirtualAccountExample();
        List<TbVirtualAccount> virtualAccountList = null;
        example.setOrderByClause("create_time desc");
        virtualAccountList = virtualAccountMapper.selectByExample(example);

        return new PageInfo<>(virtualAccountList);
    }


    public boolean releasaeSubAccount(String subAccNo) {
       TbVirtualAccount virtualAccount = virtualAccountMapper.selectByPrimaryKey(subAccNo);
       if(virtualAccount!=null){
           SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
           virtualAccount.setAccountNumber(virtualAccount.getAccountNumber()+"(delete_"+format.format(virtualAccount.getCreateTime())+")");
          int count =  virtualAccountMapper.insertSelective(virtualAccount);
          int delete =  virtualAccountMapper.deleteByPrimaryKey(subAccNo);

          return  count ==1 && delete == 1;
       }
       return  false;
    }
}
