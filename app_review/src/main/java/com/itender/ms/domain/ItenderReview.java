package com.itender.ms.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 审批
 * @Author jameschen
 * @Date 2018/2/08 15:20
 */
@Table(name = "itender_review")
public class ItenderReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value="id",hidden=true)
    private String id;

    @Column(name="role")

    @ApiModelProperty(value="审批角色",name="role",example="operator,department_leader,branch_leader,approver",required=false,hidden=true)
    private String role;//审批角色


    @Column(name="status")

    private String status;//审批状态


    @Column(name="type")
    @ApiModelProperty(value="审批类型",name="type",example="tender",required=true)

    private String type;//审批类型


    @Column(name="name")

    @ApiModelProperty(value="项目名称",name="name",example="测试项目名称1",required=true)
    private String name;//项目名称


    @Column(name="description")
    private String description;//审批描述


    @Column(name="create_time")
    private Date createTime;//审批任务创建时间



    @Column(name="tender_name")
    @ApiModelProperty(value="招标项目名称",name="tenderName",example="测试招标项目名称1",required=true)
    private String tenderName;//招标项目名称


    @Column(name="tender_no")
    @ApiModelProperty(value="招标编号",name="tenderNo",example="M140323233232331",required=true)
    private String tenderNo;//招标编号

    @Column(name="organization_inner_tender_no")
    @ApiModelProperty(value="机构内部招标编号",name="organizationInnerTenderNo",example="233232331",required=true)
    private String organizationInnerTenderNo;//机构内部招标编号

    @Column(name="tender_type")
    @ApiModelProperty(value="招标项目类型",name="tenderType",example="工程建设项目投标-公路",required=true)
    private String tenderType;//招标项目类型


    @Column(name="apply_person")
    @ApiModelProperty(value="申报责任人",name="applyPerson",example="张三",required=true)
    private String applyPerson;//申报责任人


    @Column(name="tender_method")
    @ApiModelProperty(value="招标方式",name="tenderMethod",example="公开招标",required=true)
    private String tenderMethod;//招标方式


    @Column(name="tender_behavior")
    @ApiModelProperty(value="招标组织形式",name="tenderBehavior",example="委托招标",required=true)
    private String tenderBehavior;//招标组织形式

    @Column(name="tender_content")
    @ApiModelProperty(value="招标内容",name="tenderContent",example="太原高新区发改委一号项目，500亿",required=true)
    private String tenderContent;//招标内容



    @Column(name="tender_contact")
    @ApiModelProperty(value="招标单位联系人",name="tenderContact",example="james",required=true)
    private String tenderContact;//招标单位联系人


    @Column(name="tender_mobile")
    @ApiModelProperty(value="招标单位联系方式",name="tenderMobile",example="18611212222",required=true)
    private String tenderMobile;//招标单位联系方式


    @Column(name="agency_contact")
    @ApiModelProperty(value="代理机构联系人",name="agencyContact",example="李克强",required=true)
    private String agencyContact;//代理机构联系人


    @Column(name="agency_mobile")
    @ApiModelProperty(value="代理机构联系方式",name="agencyMobile",example="18212121221",required=true)
    private String agencyMobile;//代理机构联系方式


    @Column(name="tender_condition")
    @ApiModelProperty(value="招标条件",name="tenderCondition",example="企业为国企，资金不少于30亿",required=true)
    private String tenderCondition;//招标条件



    @Transient
    public List<ItenderAttach> attachs;



    @Transient
    public List<ItenderAttach> confirms;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getTenderName() {
        return tenderName;
    }

    public void setTenderName(String tenderName) {
        this.tenderName = tenderName;
    }

    public String getTenderNo() {
        return tenderNo;
    }

    public void setTenderNo(String tenderNo) {
        this.tenderNo = tenderNo;
    }

    public String getOrganizationInnerTenderNo() {
        return organizationInnerTenderNo;
    }

    public void setOrganizationInnerTenderNo(String organizationInnerTenderNo) {
        this.organizationInnerTenderNo = organizationInnerTenderNo;
    }

    public String getTenderType() {
        return tenderType;
    }

    public void setTenderType(String tenderType) {
        this.tenderType = tenderType;
    }

    public String getApplyPerson() {
        return applyPerson;
    }

    public void setApplyPerson(String applyPerson) {
        this.applyPerson = applyPerson;
    }

    public String getTenderMethod() {
        return tenderMethod;
    }

    public void setTenderMethod(String tenderMethod) {
        this.tenderMethod = tenderMethod;
    }

    public String getTenderBehavior() {
        return tenderBehavior;
    }

    public void setTenderBehavior(String tenderBehavior) {
        this.tenderBehavior = tenderBehavior;
    }

    public String getTenderContent() {
        return tenderContent;
    }

    public void setTenderContent(String tenderContent) {
        this.tenderContent = tenderContent;
    }

    public String getTenderContact() {
        return tenderContact;
    }

    public void setTenderContact(String tenderContact) {
        this.tenderContact = tenderContact;
    }

    public String getTenderMobile() {
        return tenderMobile;
    }

    public void setTenderMobile(String tenderMobile) {
        this.tenderMobile = tenderMobile;
    }

    public String getAgencyContact() {
        return agencyContact;
    }

    public void setAgencyContact(String agencyContact) {
        this.agencyContact = agencyContact;
    }

    public String getAgencyMobile() {
        return agencyMobile;
    }

    public void setAgencyMobile(String agencyMobile) {
        this.agencyMobile = agencyMobile;
    }

    public String getTenderCondition() {
        return tenderCondition;
    }

    public void setTenderCondition(String tenderCondition) {
        this.tenderCondition = tenderCondition;
    }

    public List<ItenderAttach> getAttachs() {
        return attachs;
    }

    public void setAttachs(List<ItenderAttach> attachs) {
        this.attachs = attachs;
    }

    public List<ItenderAttach> getConfirms() {
        return confirms;
    }

    public void setConfirms(List<ItenderAttach> confirms) {
        this.confirms = confirms;
    }
}
