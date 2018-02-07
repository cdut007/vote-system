package com.itender.ms.directive;

import com.itender.ms.domain.ItenderPrivilege;
import com.itender.ms.domain.ItenderUser;
import freemarker.core.Environment;
import freemarker.template.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 鉴权指令
 *
 * @author jiepeng
 */

@Component
public class ResourceCheckDirective extends SingleDirective<ItenderPrivilege> {

    private static final Logger logger = LoggerFactory.getLogger(ResourceCheckDirective.class);

    @Override
    protected ItenderPrivilege field(Map params, Map<String, Object> envParams) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes()).getRequest();
        String uri = FreemarkerTemplateUtility.getStringValueFromParams(params,
                "url");

        logger.info("to check url:" + uri);

        HttpSession session = request.getSession();
        ItenderUser user = (ItenderUser) session.getAttribute("user");

        //TODO 使用自定义的用户处理
        List<ItenderPrivilege> privileges = user.getPrivileges();

        for (ItenderPrivilege privilege : privileges){
            if(privilege == null){
                return null;
            }
            if(uri.equals(privilege.getPrivilegeUri())){
                envParams.put("AUTH_PRIVILEGE", privilege);
                return privilege;
            }
        }

        return null;
    }
}
