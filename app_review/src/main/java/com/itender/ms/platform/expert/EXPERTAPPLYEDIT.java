package com.itender.ms.platform.expert;

import javax.xml.bind.annotation.*;
import java.util.List;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "platId"
})
/**
 * 抽取专家申请表
 * @author xuexr
 *
 */
@XmlRootElement(name = "expertApply")
public class EXPERTAPPLYEDIT {
	@XmlElement(name = "platId", required = true)
	protected String platId;//数据在交易平台的唯一标识
	
	@XmlElement(name = "expertSpecialtyWSList", required = true)
	protected List<EXPERTSPECIALTYWS> expertSpecialtyWSList;//抽取专家条件组
	
	public String getPlatId() {
		return platId;
	}
	public void setPlatId(String platId) {
		this.platId = platId;
	}
	public List<EXPERTSPECIALTYWS> getExpertSpecialtyWSList() {
		return expertSpecialtyWSList;
	}
	public void setExpertSpecialtyWSList(
			List<EXPERTSPECIALTYWS> expertSpecialtyWSList) {
		this.expertSpecialtyWSList = expertSpecialtyWSList;
	}
}
