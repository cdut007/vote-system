package com.itender.ms.util;

import com.itender.ms.domain.ItenderPrivilege;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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
        if(inList != null && inList.size() > 0) {
            for(InputStream in : inList) {
                BufferedReader br = null;
                StringBuffer message=new StringBuffer();
                try {
                    br = new BufferedReader(new InputStreamReader(in));
                    String line = null;
                    while((line = br.readLine()) != null) {
                        String newLine = line.replaceAll("//\\S*","");//去掉注释
                        message.append(newLine);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                String defaultStr=message.toString();
                String result = defaultStr.replace("\r\n", "").replaceAll(" +", "");
                logger.info(result);

                JSONObject jsonObject = JSONObject.fromObject(result);
                JSONArray jsonArray = jsonObject.getJSONArray("privileges");
                JSONObject object = null;

                if(jsonArray!=null && jsonArray.size()>0) {
                    for (int i = 0; i < jsonArray.size(); i++) {
                        object = jsonArray.getJSONObject(i);
                        ItenderPrivilege itenderPrivilege = new ItenderPrivilege();
                        itenderPrivilege.setPrivilegeName(object.getString("name"));
                        itenderPrivilege.setAlias(object.getString("alias"));
                        itenderPrivilege.setPrivilegeUri(object.getString("resource"));
                        itenderPrivilege.setPrivilegeMethod(object.getString("method"));
                        itenderPrivilege.setIcon(object.getString("icon"));
                        itenderPrivilege.setSeq(object.getInt("seq"));
                        itenderPrivilege.setLevel(object.getInt("level"));
                        itenderPrivilege.setRef(object.getString("ref"));
                        itenderPrivileges.add(itenderPrivilege);
                    }
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
