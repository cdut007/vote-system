package com.itender.test;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import com.itender.ms.domain.ItenderIndustry;
import com.itender.ms.mapper.*;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.itender.Application;
import com.itender.ms.domain.ItenderRole;
import com.itender.ms.domain.ItenderUser;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderPrivilegeService;
import com.itender.ms.service.ItenderRoleService;
import com.itender.ms.service.ItenderUserService;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = Application.class)
public class ItenderUserTest {
    private static final Logger logger = LoggerFactory.getLogger(ItenderUserTest.class);

    @Autowired
    private ItenderUserService itenderUserService;
    @Autowired
    private ItenderRoleService itenderRoleService;
    @Autowired
    private ItenderPrivilegeService itenderPrivilegeService;
    @Autowired
    private ItenderRolePrivilegeMapper itenderRolePrivilegeMapper;
    @Autowired
    private ItenderUserMapper itenderUserMapper;
    @Autowired
    private ItenderPrivilegeMapper itenderPrivilegeMapper;
    @Autowired
    private ItenderRoleMapper itenderRoleMapper;
    @Autowired
    private ItenderIndustryMapper itenderIndustryMapper;


//    @Test
//    public void AddUserTest(){
//        ItenderUser itenderUser = new ItenderUser();
//        itenderUser.setUserName("test");
//        itenderUser.setPassword("test");
//        itenderUser.setEmail("test@test.test");
//        itenderUser.setRegisterTime(new Date());
//        itenderUser.setRegisterIp("127.0.0.1");
//        try {
//            itenderUser = itenderUserService.add(itenderUser);
//        } catch (APIException e) {
//            e.printStackTrace();
//        }
//
//        Assert.assertNotNull(itenderUser);
//        logger.debug("#############################################");
//        logger.debug(itenderUser.toString());
//        logger.debug("#############################################");
//    }

//    @Test
//    public void FindUserTest() throws APIException{
//        ItenderUser user = itenderUserService.findById("6306448c64eb0a4ae05347871f0a2faf");
////        ItenderUser user = itenderUserService.findByNameAndPassword("admin", "admin");
////        Collection<ItenderRole> roles = user.getRoles();
//        logger.debug("#############################################");
//        logger.debug(user.toString());
////        user.setDefaultAdmin(true);
////        itenderUserService.updateUser(user);
//        logger.debug(user.toString());
//        logger.debug("#############################################");
//    }

//    @Test
//    public void userLoginTest() throws APIException{
//    	ItenderUser user = itenderUserService.userLogin("test", "123", false);
////    	ItenderUser user = itenderUserMapper.selectByUserId("62ce9367f11f296fe05347871f0acd08");
//    	logger.debug("#############################################");
//    	logger.debug(user.toString());
//    	user.setPassword("234");
//    	user = itenderUserService.updateUser(user, true);
////    	if(user.getRoles()!=null){
////    		for(ItenderRole r : user.getRoles()){
////    			logger.debug(r.toString());
////    		}
////    	}
//    	logger.debug(user.toString());
//    	logger.debug("#############################################");
//    }
    
//    @Test
//    public void AddRoleTest(){
//        ItenderRole role = new ItenderRole();
//        role.setRoleName("USER");
//        try {
//            role = itenderRoleService.add(role);
//        } catch (APIException e) {
//            e.printStackTrace();
//        }
//        Assert.assertNotNull(role);
//        logger.debug("#############################################");
//        logger.debug(role.toString());
//        logger.debug("#############################################");
//    }
//
//    //62cef3ad25c62aeae05347871f0a4a3e
//    @Test
//    public void FindRoleTest() throws APIException{
//        ItenderRole role = itenderRoleService.findById("62cef3ad25c62aeae05347871f0a4a3e");
//        Assert.assertNotNull(role);
//        List<ItenderRole> roles = itenderRoleService.findAll();
//        for(ItenderRole role : roles){
//        	logger.debug("#############################################");
//        	logger.debug(role.toString());
//        	logger.debug("#############################################");        	
//        }
//    }
//
//
//    @Test
//    public void AddPrivilegeTest(){
//        ItenderPrivilege privilege = new ItenderPrivilege();
//        privilege.setPrivilegeName("元模板列表");
//        privilege.setPrivilegeUri("/meta/template");
//        try {
//            privilege = itenderPrivilegeService.add(privilege);
//        } catch (APIException e) {
//            e.printStackTrace();
//        }
//        Assert.assertNotNull(privilege);
//        logger.debug("#############################################");
//        logger.debug(privilege.toString());
//        logger.debug("#############################################");
//    }
//
//    @Test
//    public void FindPrivilegeTest(){
//        ItenderPrivilege privilege = itenderPrivilegeService.findById("62cf05a07e4b2b1ee05347871f0afd22");
//        Assert.assertNotNull(privilege);
//        logger.debug("#############################################");
//        logger.debug(privilege.toString());
//        logger.debug("#############################################");
//    }
//
//    @Test
//    public void findRolePrivilege(){
//        List<ItenderPrivilege> datas =  itenderPrivilegeMapper.selectByUserId("62ce9367f11f296fe05347871f0acd08");
//        logger.debug("#############################################");
//        for (ItenderPrivilege s : datas){
//            logger.debug(s.toString());
//        }
//        logger.debug("#############################################");
//    }

    @Test
    public void findIndustry(){
        String[] a = new String[]{"1ed94c58-0e49-11e8-838b-201a06bed6c8","a2afae8f-0e49-11e8-838b-201a06bed6c8","3"};
        for(String i : a){
            i.toString();
        }

        List<ItenderIndustry> itenderIndustries =  itenderIndustryMapper.selectByIds(a);
        for (ItenderIndustry i : itenderIndustries){
            logger.debug("#############################################");
            logger.debug(i.getIndustryName());
            logger.debug("#############################################");
        }
    }
}
