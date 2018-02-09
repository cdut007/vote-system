package com.itender.ms.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;
import com.itender.ms.mapper.ItenderPrivilegeMapper;
import com.itender.ms.mapper.ItenderUserMapper;
import com.itender.ms.service.ItenderUserService;
import com.itender.ms.util.PasswordUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;

/**
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:58
 */
@Service
public class ItenderUserServiceImpl implements ItenderUserService {
    private static final Logger logger = LoggerFactory.getLogger(ItenderUserServiceImpl.class);
    private static final String KEY = "com.itender";
    @Autowired
    private ItenderUserMapper itenderUserMapper;
    @Autowired
    private ItenderPrivilegeMapper itenderPrivilegeMapper;

    @Override
    public ItenderUser add(ItenderUser itenderUser) throws APIException {
        itenderUser.setCreateTime(new Date());
        itenderUser.setUpdateTime(new Date());
        String password = enPassword(itenderUser.getPassword());
        itenderUser.setPassword(password);
        int rows = itenderUserMapper.insertSelective(itenderUser);
        return rows == 0 ? null : itenderUser;
    }

    @Override
    public ItenderUser findById(String itenderUserId) {
        return itenderUserMapper.selectByPrimaryKey(itenderUserId);
    }

    @Override
    public List<ItenderUser> findAll() throws APIException {
        return itenderUserMapper.selectAll();
    }

    @Override
    public PageInfo<ItenderUser> findPage(Integer pageNum, Integer pagesize) throws APIException {
        PageHelper.startPage(pageNum, pagesize);

        Example example = new Example(ItenderUser.class);
        example.orderBy("createTime").desc();
        List<ItenderUser> itenderUser = itenderUserMapper.selectByExample(example);
        return new PageInfo<>(itenderUser);
    }

    @Override
    public Integer deleteById(String id) {
        ItenderUser itenderUser = new ItenderUser();
        itenderUser.setId(id);
        return itenderUserMapper.delete(itenderUser);
    }

    @Override
    public ItenderUser findByUserId(String userId) {
        return itenderUserMapper.selectByUserId(userId);
    }

    @Override
    public ItenderUser findByNameAndPassword(String username, String password) throws APIException {
        ItenderUser user = new ItenderUser();
        user.setUserName(username);
        user.setPassword(password);
        return itenderUserMapper.selectByNameAndPassword(user);
    }

    @Override
    public ItenderUser updateUser(ItenderUser user, boolean updatePassword) throws APIException {
        if (user == null) {
            return null;
        }
        if (updatePassword) {
            String password = enPassword(user.getPassword());
            user.setPassword(password);
        } else {
            user.setPassword(null);
        }
        int rows = itenderUserMapper.updateUser(user);
        return rows == 0 ? null : user;
    }

    @Override
    public ItenderUser userLogin(String username, String password, boolean isSession) throws APIException {
        String enPassword = this.enPassword(password);
        ItenderUser userold = new ItenderUser();
        userold.setUserName(username);
        userold.setPassword(enPassword);
        ItenderUser user = itenderUserMapper.selectByNameAndPassword(userold);
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        if (user == null) {
            return user;
        }

        // 登录成功更新用户信息
        ItenderUser condition = new ItenderUser();
        Date currentTime = new Date();
        condition.setLastLoginTime(currentTime);
        condition.setLastLoginIp(request.getRemoteAddr());
        condition.setUpdateTime(currentTime);
        condition.setId(user.getId());
        itenderUserMapper.updateByPrimaryKeySelective(condition);

        List<ItenderPrivilege> privileges = null;
        if (user.isDefaultAdmin()) {//默认管理员赋予所有权限
            privileges = itenderPrivilegeMapper.selectAll();
        } else {
            privileges = itenderPrivilegeMapper.selectByUserId(user.getId());
        }
        user.setPrivileges(privileges);

        if (isSession) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            logger.debug("[ " + user.getUserName() + " ]登录成功！登录IP:" + request.getRemoteAddr());
        }

        return user;
    }

    @Override
    public String enPassword(String password) throws APIException {
        String str = "";
        try {
            str = PasswordUtil.encrypt(password, KEY);
        } catch (Exception e) {
            e.printStackTrace();
            throw new APIException(500, "100500", "加密错误！");
        }

        return str;
    }

    @Override
    public String dePassword(String password) throws APIException {
        String str = "";
        try {
            str = PasswordUtil.decrypt(password, KEY);
        } catch (Exception e) {
            e.printStackTrace();
            throw new APIException(500, "100500", "解密错误！");
        }
        return str;
    }


    public static void main(String[] args) throws APIException {
        ItenderUserServiceImpl s = new ItenderUserServiceImpl();
        String ss = "123";
        String dss = "iAWSYC2JKHXp8Mxue3ObBg==";
        System.out.println(s.enPassword(ss));
        System.out.println(s.dePassword(dss));

    }
}
