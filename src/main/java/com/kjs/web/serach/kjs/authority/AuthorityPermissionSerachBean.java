package com.kjs.web.serach.kjs.authority;
import org.apache.ibatis.type.Alias;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色授权请求参数实体
 * Created by wangsongpeng on 2016/1/18.
 */
@SuppressWarnings("serial")
@Alias("AuthorityPermissionSerach")
public class AuthorityPermissionSerachBean{

    private Long roleId;/*角色ID*/
    private Long menuId;/*菜单ID*/
    private Long operId;/*操作ID*/
    private List<String> categoryIds = new ArrayList<>();/*categoryId集合*/
    private String resCode;/*菜单code*/
    private String operCode;/*操作code*/
    private boolean delMenuFlag;/*是否删除角色下的菜单权限 true:删除false:不删除*/
    private boolean delOperFlag;/*是否删除角色下的菜单下的操作权限 true:删除false:不删除*/

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Long getOperId() {
        return operId;
    }

    public void setOperId(Long operId) {
        this.operId = operId;
    }

    public List<String> getCategoryIds() {
        return categoryIds;
    }

    public void setSkuIds(List<String> categoryIds) {
        this.categoryIds = categoryIds;
    }

    public boolean getDelMenuFlag() {
        return delMenuFlag;
    }

    public void setDelMenuFlag(boolean delMenuFlag) {
        this.delMenuFlag = delMenuFlag;
    }

    public boolean getDelOperFlag() {
        return delOperFlag;
    }

    public void setDelOperFlag(boolean delOperFlag) {
        this.delOperFlag = delOperFlag;
    }

    public String getResCode() {
        return resCode;
    }

    public void setResCode(String resCode) {
        this.resCode = resCode;
    }

    public String getOperCode() {
        return operCode;
    }

    public void setOperCode(String operCode) {
        this.operCode = operCode;
    }

    @Override
    public String toString() {
        return "AuthorityPermissionSerachBean{" +
                "roleId=" + roleId +
                ", menuId=" + menuId +
                ", operId=" + operId +
                ", categoryIds=" + categoryIds +
                ", resCode='" + resCode + '\'' +
                ", operCode='" + operCode + '\'' +
                ", delMenuFlag=" + delMenuFlag +
                ", delOperFlag=" + delOperFlag +
                '}';
    }
}
