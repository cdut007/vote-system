<#if entityTemplate.packageName??>package ${entityTemplate.packageName};</#if>
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
<#if entityTemplate.primaryFieldWithMappingSize gt 1>
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import org.hibernate.annotations.GenericGenerator;
</#if>
import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
/***************************************************
* <#if entityTemplate.comment??>${entityTemplate.comment}</#if>
* @author ZORO
* @date 2015-10-30 16:58:40
***************************************************/
@Entity
@Table(name="${entityTemplate.tableName}")
public class ${entityTemplate.entityName} implements Serializable{
	/**
	* 
	*/
	private static final long serialVersionUID = 1L;
	<#if entityTemplate.primaryFieldWithMappingSize gt 1>
	
	/*****
	*	联合主键对象
	******/
	@Embeddable
	public static class ${entityTemplate.entityName}Id implements Serializable{
		/**
		* 
		*/
		private static final long serialVersionUID = 1L;
		<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
		private ${fieldWithMapping.fieldType} ${fieldWithMapping.fieldName};
		</#list>
		<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
		public ${fieldWithMapping.fieldType} ${fieldWithMapping.getterMethodName}(){
			return this.${fieldWithMapping.fieldName};
		}
		public void ${fieldWithMapping.setterMethodName}(${fieldWithMapping.fieldType} ${fieldWithMapping.fieldName}){
			this.${fieldWithMapping.fieldName}=${fieldWithMapping.fieldName};
		}
		</#list>
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
			result = prime * result + ((${fieldWithMapping.fieldName} == null) ? 0 : ${fieldWithMapping.fieldName}.hashCode());
			</#list>
			return result;
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			${entityTemplate.entityName}Id other = (${entityTemplate.entityName}Id) obj;
			<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
			if (${fieldWithMapping.fieldName} == null) {
				if (other.${fieldWithMapping.fieldName} != null)
					return false;
				} else if (!${fieldWithMapping.fieldName}.equals(other.${fieldWithMapping.fieldName}))
					return false;
			</#list>
			return true;
		}
		
		@Override
		public String toString() {
			return "${entityTemplate.entityName}Id [<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>${fieldWithMapping.fieldName}=" + ${fieldWithMapping.fieldName} + "<#if fieldWithMapping_index!=entityTemplate.primaryFieldWithMappingList?size-1>, </#if></#list>]";
		}
	}
	private ${entityTemplate.entityName}Id ${entityTemplate.entityInstanceName}Id;
	</#if>
	
	<#list entityTemplate.fieldWithMappingList as fieldWithMapping>
	<#if entityTemplate.primaryFieldWithMappingSize lt 2||!fieldWithMapping.primary>
	<#if 'Date'==fieldWithMapping.fieldType>
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	</#if>
	private ${fieldWithMapping.fieldType} ${fieldWithMapping.fieldName};	<#if fieldWithMapping.comment??>//${fieldWithMapping.comment}</#if>
	</#if>
	</#list>
	
	<#if entityTemplate.primaryFieldWithMappingSize gt 1>
	@EmbeddedId
	@AttributeOverrides({ 
	<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
		@AttributeOverride(name = "${fieldWithMapping.fieldName}", column = @Column(name = "${fieldWithMapping.columnName}", nullable = <#if fieldWithMapping.notNull>false<#else>true</#if>))<#if entityTemplate.primaryFieldWithMappingList?size-1!=fieldWithMapping_index>,</#if> 
	</#list>	
	})
	public ${entityTemplate.simpleEntityName}Id get${entityTemplate.simpleEntityName}Id(){
		return this.${entityTemplate.entityInstanceName}Id;
	}
	public void set${entityTemplate.simpleEntityName}Id(${entityTemplate.simpleEntityName}Id ${entityTemplate.entityInstanceName}Id){
		this.${entityTemplate.entityInstanceName}Id=${entityTemplate.entityInstanceName}Id;
	}
	</#if>
	
	<#list entityTemplate.fieldWithMappingList as fieldWithMapping>
	<#if entityTemplate.primaryFieldWithMappingSize lt 2||!fieldWithMapping.primary>
	/***************************************************
	* <#if fieldWithMapping.comment??>//${fieldWithMapping.comment}</#if>
	* @nullable <#if fieldWithMapping.notNull>false<#else>false</#if>
	* @return
	***************************************************/
	<#if fieldWithMapping.primary>
	@Id
	@GenericGenerator(name = "uuid", strategy = "org.hibernate.id.UUIDGenerator")
	@GeneratedValue(generator = "uuid")
	</#if>
	@Column(name="${fieldWithMapping.columnName}",nullable=<#if fieldWithMapping.notNull>false<#else>false</#if>)
	public ${fieldWithMapping.fieldType} ${fieldWithMapping.getterMethodName}(){
		return this.${fieldWithMapping.fieldName};
	}
	public void ${fieldWithMapping.setterMethodName}(${fieldWithMapping.fieldType} ${fieldWithMapping.fieldName}){
		this.${fieldWithMapping.fieldName}=${fieldWithMapping.fieldName};
	}
	</#if>
	</#list>
	
	
	<#if entityTemplate.primaryFieldWithMappingSize gt 1>
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((${entityTemplate.entityInstanceName}Id == null) ? 0 : ${entityTemplate.entityInstanceName}Id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		${entityTemplate.entityName} other = (${entityTemplate.entityName}) obj;
		if (${entityTemplate.entityInstanceName}Id == null) {
			if (other.${entityTemplate.entityInstanceName}Id != null)
				return false;
			} else if (!${entityTemplate.entityInstanceName}Id.equals(other.${entityTemplate.entityInstanceName}Id))
				return false;
		return true;
	}
	<#elseif entityTemplate.primaryFieldWithMappingSize gt 0>
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
		result = prime * result + ((${fieldWithMapping.fieldName} == null) ? 0 : ${fieldWithMapping.fieldName}.hashCode());
		</#list>
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		${entityTemplate.entityName} other = (${entityTemplate.entityName}) obj;
		<#list entityTemplate.primaryFieldWithMappingList as fieldWithMapping>
		if (${fieldWithMapping.fieldName} == null) {
			if (other.${fieldWithMapping.fieldName} != null)
				return false;
			} else if (!${fieldWithMapping.fieldName}.equals(other.${fieldWithMapping.fieldName}))
				return false;
		</#list>
		return true;
	}
	</#if>
}