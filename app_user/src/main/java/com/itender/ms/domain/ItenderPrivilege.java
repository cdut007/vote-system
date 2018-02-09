package com.itender.ms.domain;

import javax.persistence.*;
import java.util.List;

/**
 * 用户权限
 * @Author Mao.Zeng@MG
 * @Date 2018/1/15 16:19
 */
@Table(name = "itender_privilege")
public class ItenderPrivilege {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name="privilege_name")
    private String privilegeName;
    
    @Column(name="privilege_uri")
    private String privilegeUri;//resource资源路径

    @Column(name = "privilege_method")
    private String privilegeMethod;//method,POST/GET..

    @Column(name = "privilege_alias")
    private String alias; //别名，自定义，可被ref字段关联

    @Column(name = "privilege_icon")
    private String icon;//小图标没有可不填

    @Column(name = "privilege_seq")
    private Integer seq;//序号，用来排序，数字越大越靠后

    @Column(name = "privilege_level")
    private Integer level;//级别，

    @Column(name = "privilege_ref")
    private String ref;//关联字段，如果填写需要指定其他资源的alias字段

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPrivilegeName() {
        return privilegeName;
    }

    public void setPrivilegeName(String privilegeName) {
        this.privilegeName = privilegeName;
    }

    public String getPrivilegeUri() {
        return privilegeUri;
    }

    public void setPrivilegeUri(String privilegeUri) {
        this.privilegeUri = privilegeUri;
    }

    public String getPrivilegeMethod() {
        return privilegeMethod;
    }

    public void setPrivilegeMethod(String privilegeMethod) {
        this.privilegeMethod = privilegeMethod;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref;
    }

    @Override
    public String toString() {
        return "ItenderPrivilege{" +
                "id='" + id + '\'' +
                ", privilegeName='" + privilegeName + '\'' +
                ", privilegeUri='" + privilegeUri + '\'' +
                ", privilegeMethod='" + privilegeMethod + '\'' +
                ", alias='" + alias + '\'' +
                ", icon='" + icon + '\'' +
                ", seq=" + seq +
                ", level=" + level +
                ", ref='" + ref + '\'' +
                '}';
    }
}
