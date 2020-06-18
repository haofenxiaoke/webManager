package com.kjs.web.controller.kjs.home;

import com.kjs.common.bean.MenuCacheModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.model.HomeSet;
import com.kjs.orm.model.HomeSetCarousel;
import com.kjs.service.kjs.authority.spi.IAuthorityOperationService;
import com.kjs.service.kjs.course.spi.ICourseService;
import com.kjs.service.kjs.home.spi.IHomeSetCarouselService;
import com.kjs.service.kjs.home.spi.IHomeSetService;
import com.kjs.service.kjs.system.spi.ISysDictService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 首页设置管理控制器
 * Created by wangsongpeng on 2016/2/25.
 */
@Controller
@RequestMapping("/homeSet")
public class HomeSetController {
    private final static Logger logger = LoggerFactory.getLogger(HomeSetController.class);
    @Resource
    private IHomeSetService homeSetService;
    @Resource
    private ISysDictService sysDictService;
    @Resource
    private ICourseService courseService;
    @Resource
    private IHomeSetCarouselService homeSetCarouselService;
    @Resource
    private IAuthorityOperationService authorityOperationService;
    @Resource
    private MenuCacheModel menuCacheModel;

    /**
     * 跳转到管理页面
     * @return
     */
    @PermissionAnn(menuCode = "homeSet",msg = "你没有进入首页设置管理页面的权限!")
    @RequestMapping(value = "/manager")
    public String forwardManager(Model model){
        //热词
        Map homeSet = this.sysDictService.queryAllDicts();
        if(homeSet!=null) model.addAttribute("homeSet",homeSet);
        //轮播 主键和url
        Map carouse = this.homeSetCarouselService.queryAllCarousels();
        if(carouse!=null) model.addAttribute("carouse",carouse);

        //首页设置
        List<Map> setList = this.homeSetService.queryAllSets();
        List<Map> courseList = this.homeSetService.searchCoursesWithHomeSet();
        model.addAttribute("setList", setList);
        model.addAttribute("courseList",courseList);

        return "homeSet/home_set";
    }

    /**
     *  新增/修改热词
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增/修改首页配置热词信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "save",msg = "你没有新增/修改首页配置热词信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/hot/save",method = RequestMethod.POST)
    public ResponseJsonModel saveHotEmp(HttpServletRequest request,HttpServletResponse response)throws Exception{
        Map paramMap = RequestParamUtils.getParamValues(request);
        this.homeSetService.saveHotEmp(paramMap);
        logger.warn("新增/修改热词:" + paramMap);
        return new ResponseJsonModel();
    }

    /**
     *  新增轮播图片
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增首页配置轮播图片信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "save",msg = "你没有新增首页配置轮播图片信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/carousel/save",method = RequestMethod.POST)
    public ResponseJsonModel saveCarouselEmp(HomeSetCarousel carousel)throws Exception{
        Date now = new Date();
        Integer userid = ShiroUtils.getSessionUser().getId().intValue();
        carousel.setCreateUserid(userid);
        carousel.setLastUpdateUserid(userid);
        carousel.setCreateTime(now);
        carousel.setLastUpdateTime(now);
        this.homeSetCarouselService.save(carousel);
        logger.warn("新增轮播图片信息:" + carousel.getId() + "-" + carousel.getPathUrl());
        return new ResponseJsonModel();
    }

    /**
     *  修改轮播图片
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改首页配置轮播图片信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "save",msg = "你没有新增/修改首页配置轮播图片信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/carousel/update",method = RequestMethod.POST)
    public ResponseJsonModel updateCarouselEmp(HomeSetCarousel carousel)throws Exception{
        Date now = new Date();
        Integer userid = ShiroUtils.getSessionUser().getId().intValue();
        carousel.setCreateUserid(userid);
        carousel.setLastUpdateUserid(userid);
        carousel.setCreateTime(now);
        carousel.setLastUpdateTime(now);
        this.homeSetCarouselService.update(carousel);
        logger.warn("修改轮播图片信息:" + carousel.getId() + "-" + carousel.getPathUrl());
        return new ResponseJsonModel();
    }

    /**
     *  删除轮播图片
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改首页配置轮播图片信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "delete",msg = "你没有新增/修改首页配置轮播图片信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/carousel/delete",method = RequestMethod.POST)
    public ResponseJsonModel deleteCarouselEmp(HomeSetCarousel carousel)throws Exception{
        Long[] ids ={carousel.getId()};
        this.homeSetCarouselService.deleteByIds(ids);
        logger.warn("删除轮播图片信息:" + carousel.getId());
        return new ResponseJsonModel();
    }

    /**
     *  新增首页配置
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "新增首页配置信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "save",msg = "你没有新增首页配置信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseJsonModel saveSetEmp(HomeSet set)throws Exception{
        Date now = new Date();
        Integer userid = ShiroUtils.getSessionUser().getId().intValue();
        set.setCreateUserid(userid);
        set.setLastUpdateUserid(userid);
        set.setCreateTime(now);
        set.setLastUpdateTime(now);

        this.homeSetService.save(set);
        logger.warn("新增首页配置:" + set.getId());
        return new ResponseJsonModel();
    }

    /**
     *  修改首页配置
     * @param
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改首页配置信息")
    @PermissionAnn(menuCode = "HomeSet",operCode = "save",msg = "你没有修改首页配置信息的权限!")
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public ResponseJsonModel updateSetEmp(HomeSet set)throws Exception{
        Date now = new Date();
        Integer userid = ShiroUtils.getSessionUser().getId().intValue();
        set.setLastUpdateUserid(userid);
        set.setLastUpdateTime(now);
        if(StringUtil.isEmpty(set.getLeftHref())){
            set.setLeftHref(new String());
        }
        this.homeSetService.update(set);
        logger.warn("修改首页配置:" + set.getId());
        return new ResponseJsonModel();
    }
}
