package com.kjs.orm.model;

import com.kjs.common.bean.BaseEntity;
import com.kjs.common.utils.ShortDateSerializer;
import org.apache.ibatis.type.Alias;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.util.Date;

/**
 * POJO:SysDict
 *
 * @author duia_builder
 * @date 2016-5-23
 */
@SuppressWarnings("serial")
@Alias("SysDict")
public class SysDict extends BaseEntity {


	private Integer	type;		 /* 类型 */
	private String	content;		 /* 内容 */
	private Date	createTime;		 /* 创建时间 */
	private Boolean	state;		 /* 状态（1启用0停用） */

	// getter && setter
	// 在setter方法最后加上"return this;"并把返回参数改为SysDict可以实现连缀设置属性

	public Integer getType() {
		return type;
	}

	public SysDict setType(Integer type) {
		this.type = type;
		return this;
	}


	public String getContent() {
		return content;
	}

	public SysDict setContent(String content) {
		this.content = content;
		return this;
	}

	@JsonSerialize(using = ShortDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}

	public SysDict setCreateTime(Date createTime) {
		this.createTime = createTime;
		return this;
	}


	public Boolean getState() {
		return state;
	}

	public SysDict setState(Boolean state) {
		this.state = state;
		return this;
	}

	@Override
	public String toString() {
		return "SysDict [" + "id=" + getId() + ", type=" + type + ", content=" + content + ", createTime=" + createTime + ", state=" + state +  "]";
	}
}

