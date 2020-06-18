package com.kjs.common.bean;
import com.kjs.common.dto.auth.MenuDto;
import com.kjs.service.kjs.authority.spi.IAuthorityMenuService;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 菜单缓存对象
 * Created by wangsongpeng on 2016/4/8.
 */
@Component
public class MenuCacheModel {

    @Resource
    private IAuthorityMenuService authorityMenuService;

    //存放所有用户菜单key为用户ID,value为菜单.concurrentHashMap能保证多线程的并发下安全,同时是在写入时锁住写入的key和value,来提升性能
    private ConcurrentHashMap<Long, List<MenuDto>> menuMap = new ConcurrentHashMap<Long,List<MenuDto>>();

    /**
     * 装入用户菜单到menuMap中
     */
    public void loadUserMenu(Long uid){
        List<MenuDto> menuDtos =  this.authorityMenuService.findUserAuthMenu();//获取当前用户的菜单数据
        this.menuMap.putIfAbsent(uid,menuDtos);
    }

    /**
     * 重新装入用户菜单到menuMap中
     */
    public void reLoadUserMenu(Long uid){
        this.clearMapMenuByUserId(uid);//清空当前用户菜单
        List<MenuDto> menuDtos =  this.authorityMenuService.findUserAuthMenu();//获取当前用户的菜单数据
        this.menuMap.putIfAbsent(uid,menuDtos);
    }

    /**
     * 清空菜单map
     */
    public void clearMapMenu(){
        this.menuMap.clear();
    }


    /**
     * 清空map中当前用户的菜单
     */
    public void clearMapMenuByUserId(Long uid){
        this.menuMap.remove(uid);
    }

    /**
     * 清空map中当前用户集合的菜单
     */
    public void clearMapMenuByUserId(List<Long> uid){
        for(Long id :uid){
            clearMapMenuByUserId(id);
        }
    }

    /**
     * 根据用户ID获取map中的菜单
     */
    public List<MenuDto> getMenu(Long uid){
       return  this.menuMap.get(uid);
    }




}
