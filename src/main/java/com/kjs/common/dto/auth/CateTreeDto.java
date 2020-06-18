package com.kjs.common.dto.auth;
import java.util.ArrayList;
import java.util.List;

/**
 * Sku树Dto
 * Created by wangsongpeng on 2016/2/25.
 */
public class CateTreeDto {
    private String id; /*cateID*/
    private String name;  /*cate名称*/
    private boolean open = true; /*是否展开*/
    private boolean checked = false; /*是否勾选*/
    private boolean parent; /*是否是父菜单*/
    private List<CateTreeDto> children = new ArrayList<CateTreeDto>();/*子节点*/


    public CateTreeDto() {
    }

    public CateTreeDto(String id, String name, boolean parent) {
        this.id = id;
        this.name = name;
        this.parent = parent;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean getChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public boolean getParent() {
        return parent;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
    }

    public List<CateTreeDto> getChildren() {
        return children;
    }

    public void setChildren(List<CateTreeDto> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "CateTreeDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", open=" + open +
                ", checked=" + checked +
                ", parent=" + parent +
                ", children=" + children +
                '}';
    }
}
