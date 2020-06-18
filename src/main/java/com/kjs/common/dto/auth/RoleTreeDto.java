package com.kjs.common.dto.auth;
import java.util.ArrayList;
import java.util.List;

/**
 * 角色树Dto
 * Created by wangsongpeng on 2016/2/25.
 */
public class RoleTreeDto {

    private Long id ; /*角色ID*/
    private String name;  /*角色名称*/
    private Integer enable;/*角色是否启用: 1:启用 0:停用*/
    private boolean parent;/*是否是父菜单*/
    private boolean open = false; /*是否展开*/

    private List<RoleTreeDto> children = new ArrayList<RoleTreeDto>();/*当前子角色集合*/


    public RoleTreeDto() {
    }

    public RoleTreeDto(Long id, String name,Integer enable, List<RoleTreeDto> children, boolean open,boolean parent) {
        this.id = id;
        this.name = name;
        this.enable = enable;
        this.open = open;
        this.children = children;;
        this.parent = parent;
    }


    public RoleTreeDto(Long id, String name,boolean parent) {
        this.id = id;
        this.name = name;
        this.parent = parent;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<RoleTreeDto> getChildren() {
        return children;
    }

    public void setChildren(List<RoleTreeDto> children) {
        this.children = children;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public boolean isParent() {
        return parent;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
    }



    @Override
    public String toString() {
        return "RoleTreeDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", enable=" + enable +
                ", parent=" + parent +
                ", open=" + open +
                ", children=" + children +
                '}';
    }
}
