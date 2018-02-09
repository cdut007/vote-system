package com.itender.ms.util;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itender.ms.domain.ItenderPrivilege;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
/**    
 *   
 * @author Mao.Zeng@MG  
 * @date 2018/2/5 16:01
 */ 
public class PrivilegeUtil {
    private static final Logger logger = LoggerFactory.getLogger(PrivilegeUtil.class);

    private static PrivilegeUtil instance = null;

    public static PrivilegeUtil getInstance(){
        return instance==null?new PrivilegeUtil():instance;
    }

    /**
     * 获取所有配置文件json中的权限内容
     * @return
     */
    public List<ItenderPrivilege> getPrivilegesFromJsonFile(){
        List<ItenderPrivilege> itenderPrivileges = new ArrayList<>();

        List<InputStream> inList = scanPrivilegeJson();
        logger.debug("==扫描到权限配置文件数量=="+inList.size());
        if(inList != null && inList.size() > 0) {
            ObjectMapper objectMapper = new ObjectMapper();
            for(InputStream in : inList) {
                try {
                    List<ItenderPrivilege> itenderPrivilege = objectMapper.readValue(in,new TypeReference<List<ItenderPrivilege>>() { });
                    logger.debug(itenderPrivilege.toString());
                    itenderPrivileges.addAll(itenderPrivilege);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return itenderPrivileges;
    }

    /**
     * 扫描工程下所有PrivilegeJson文件，读取到流中
     * @return
     */
    public List<InputStream> scanPrivilegeJson() {
        List<InputStream> ins = new ArrayList<InputStream>();
        Enumeration<URL> en;
        try {
            en = this.getClass().getClassLoader().getResources("privilege.json");
            while (en.hasMoreElements()) {
                URL url = (URL) en.nextElement();
                InputStream in = url.openStream();
                ins.add(in);
            }
            return ins;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

}
