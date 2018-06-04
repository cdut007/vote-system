<#if entityTemplate.packageName??>package <#list entityTemplate.packageName?split(".") as x><#if x_index!=entityTemplate.packageName?split(".")?size-1>${x}.</#if></#list>controller;</#if>

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.mhb.common.exception.DaoException;
import com.mhb.common.model.Ajax;
import com.mhb.common.model.Page;
import com.mhb.common.service.IBaseService;
import java.util.Map;
import org.springframework.beans.BeanUtils;
import <#if entityTemplate.packageName??>${entityTemplate.packageName}.</#if>${entityTemplate.entityName};

@Controller
@RequestMapping(value="${entityTemplate.entityInstanceName}")
public class ${entityTemplate.simpleEntityName}Controller {

	@Resource
	private IBaseService baseService;
	
	@RequestMapping(value = "paging${entityTemplate.simpleEntityName}")
	public String paging${entityTemplate.simpleEntityName}() {
		return "${entityTemplate.entityInstanceName}/paging${entityTemplate.simpleEntityName}";
	}
	
	@RequestMapping(value = "paging${entityTemplate.simpleEntityName}Data")
	@ResponseBody
	public Page paging${entityTemplate.simpleEntityName}Data(Page page) {
		DetachedCriteria dc=DetachedCriteria.forClass(${entityTemplate.entityName}.class,"${entityTemplate.entityInstanceName}");
		return this.baseService.pagingByDetachedCriteria(page,dc);
	}
	
	
	@RequestMapping(value = "list${entityTemplate.simpleEntityName}")
	public String list${entityTemplate.simpleEntityName}() {
		return "${entityTemplate.entityInstanceName}/list${entityTemplate.simpleEntityName}";
	}
	
	@RequestMapping(value = "list${entityTemplate.simpleEntityName}Data")
	@ResponseBody
	public List<${entityTemplate.entityName}> list${entityTemplate.simpleEntityName}Data(Page page) {
		DetachedCriteria dc=DetachedCriteria.forClass(${entityTemplate.entityName}.class,"${entityTemplate.entityInstanceName}");
		return this.baseService.retrieveByDetachedCriteria(dc);
	}
	
	@RequestMapping(value = "${entityTemplate.entityInstanceName}Edit")
	public String ${entityTemplate.entityInstanceName}Edit(${entityTemplate.entityName} ${entityTemplate.entityInstanceName},Map<String,Object> map) {
		if(<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}.get${entityTemplate.simpleEntityName}Id()!=null<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>StringUtils.isNotBlank(${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].getterMethodName}())</#if>){
			DetachedCriteria dc=DetachedCriteria.forClass(${entityTemplate.entityName}.class,"${entityTemplate.entityInstanceName}");
			<#if entityTemplate.primaryFieldWithMappingSize gt 1>
			dc.add(Restrictions.eq("${entityTemplate.entityInstanceName}.${entityTemplate.entityInstanceName}Id", ${entityTemplate.entityInstanceName}.get${entityTemplate.simpleEntityName}Id()));
			<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
			dc.add(Restrictions.eq("${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].fieldName}", ${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].getterMethodName}()));
			</#if>
			${entityTemplate.entityInstanceName}=this.baseService.retrieveUniqueByDetachedCriteria(dc);
		}
		map.put("${entityTemplate.entityInstanceName}", ${entityTemplate.entityInstanceName});
		return "${entityTemplate.entityInstanceName}/${entityTemplate.entityInstanceName}Edit";
	}

	@RequestMapping(value = "createOrUpdate${entityTemplate.simpleEntityName}")
	@ResponseBody
	public Ajax createOrUpdate${entityTemplate.simpleEntityName}(${entityTemplate.entityName} ${entityTemplate.entityInstanceName}) {
		boolean exist=<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}.get${entityTemplate.simpleEntityName}Id()!=null<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>StringUtils.isNotBlank(${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].getterMethodName}())</#if>;
		if(exist){
			DetachedCriteria dc=DetachedCriteria.forClass(${entityTemplate.entityName}.class,"${entityTemplate.entityInstanceName}");
			<#if entityTemplate.primaryFieldWithMappingSize gt 1>
			dc.add(Restrictions.eq("${entityTemplate.entityInstanceName}.${entityTemplate.entityInstanceName}Id", ${entityTemplate.entityInstanceName}.get${entityTemplate.simpleEntityName}Id()));
			<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
			dc.add(Restrictions.eq("${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].fieldName}", ${entityTemplate.entityInstanceName}.${entityTemplate.primaryFieldWithMappingList[0].getterMethodName}()));
			</#if>
			${entityTemplate.entityName} old${entityTemplate.simpleEntityName}=this.baseService.retrieveUniqueByDetachedCriteria(dc);
			BeanUtils.copyProperties(${entityTemplate.entityInstanceName}, old${entityTemplate.simpleEntityName},new String[]{<#if entityTemplate.primaryFieldWithMappingSize gt 1>"${entityTemplate.entityInstanceName}Id"<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>"${entityTemplate.primaryFieldWithMappingList[0].fieldName}"</#if>});
			this.baseService.update(old${entityTemplate.simpleEntityName});
		}else{
			this.baseService.create(${entityTemplate.entityInstanceName});
		}
		return new Ajax(true,(exist?"更新":"添加")+"成功!");
	}

	@RequestMapping(value = "delete${entityTemplate.simpleEntityName}")
	@ResponseBody
	public Ajax delete${entityTemplate.simpleEntityName}(<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityName}Id ${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldType} ${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>) {
		this.baseService.delete(${entityTemplate.entityName}.class,<#if entityTemplate.primaryFieldWithMappingSize gt 1>${entityTemplate.entityInstanceName}Id<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>${entityTemplate.primaryFieldWithMappingList[0].fieldName}</#if>);
		return new Ajax(true,"删除成功!");
	}
}
