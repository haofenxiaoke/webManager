package com.kjs.web.serach.kjs.authority;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import com.kjs.common.bean.DataTablePageModel;

@SuppressWarnings("serial")
@Alias("AuthorityUserWechatBean")
public class AuthorityUserWechatBean extends DataTablePageModel {
	
	private Integer  wechatStatus;
    private String	wechatDi;		
    private String	wechatUrl;
    
    
    
    
    
    
	public Integer getWechatStatus() {
		return wechatStatus;
	}
	public void setWechatStatus(Integer wechatStatus) {
		this.wechatStatus = wechatStatus;
	}
	public String getWechatDi() {
		return wechatDi;
	}
	public void setWechatDi(String wechatDi) {
		this.wechatDi = wechatDi;
	}
	public String getWechatUrl() {
		return wechatUrl;
	}
	public void setWechatUrl(String wechatUrl) {
		this.wechatUrl = wechatUrl;
	}
	@Override
	public String toString() {
		return "AuthorityUserWechatBean [wechatStatus=" + wechatStatus + ", wechatDi=" + wechatDi + ", wechatUrl="
				+ wechatUrl + "]";
	}		
	
	
	
   

}
