package com.itender.ms.domain;

import javax.persistence.*;

/**
 *   行业类型
 * @author Mao.Zeng@MG
 * @date 2018/2/9 11:08
 */
@Table(name = "itender_industry")
public class ItenderIndustry extends ItenderAttrBase{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;

    @Column(name = "industry_name")
    private String industryName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIndustryName() {
        return industryName;
    }

    public void setIndustryName(String industryName) {
        this.industryName = industryName;
    }

    @Override
    public String toString() {
        return "ItenderIndustry{" +
                "id='" + id + '\'' +
                ", industryName='" + industryName + '\'' +
                '}';
    }
}
