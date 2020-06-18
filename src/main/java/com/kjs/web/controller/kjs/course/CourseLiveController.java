package com.kjs.web.controller.kjs.course;

import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.CourseLive;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.course.spi.ICourseLiveConfigService;
import com.kjs.service.kjs.course.spi.ICourseLiveService;
import com.kjs.web.serach.kjs.course.CourseLiveSearchBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by 杨天峰 on 2017/3/28.
 */
@Controller
@RequestMapping("/live")
public class CourseLiveController {
    @Resource
    ICourseLiveService courseLiveService;
    @Resource
    ICategoryDirectionService categoryDirectionService;
    @Resource
    ICourseLiveConfigService courseLiveConfigService;
    /**
     * 直播管理页
     * @return  view
     * @author 李恒名
     * @date 2016年5月31日
     */
    @PermissionAnn(menuCode = "live",msg = "你没有进入直播课管理页面的权限!")
    @RequestMapping("/manager")
    public String manager(Map<String,String> map) {
        map.put("liveType","0");
        map.put("titleName","直播课");
        return "live/live-manager";
    }
    /**
     * 公开课管理页
     * @return  view
     * @author 杨天峰
     * @date 2017年3月31日
     */
    @PermissionAnn(menuCode = "liveOpen",msg = "你没有进入直播课管理页面的权限!")
    @RequestMapping("/open/manager")
    public String openManager(Map<String,String> map) {
        map.put("liveType","1");
        map.put("titleName","公开课");
        return "live/live-manager";
    }
    /**
     * 跳转直播配置页面
     * @return  view
     * @author 杨天峰
     * @date 2017年3月31日
     */
    @PermissionAnn(menuCode = "liveConfig",msg = "你没有进入直播课管理页面的权限!")
    @RequestMapping("/config")
    public String liveConfig(Model model) {
        //获取最近7天日期
        Long currentDate = new Date().getTime();
        ArrayList<String> respTimes = new ArrayList<>();
        ArrayList<Date> betweenTimes = new ArrayList<>();
        SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy/MM/dd");
        for (int i=0;i<7;i++){
            Date date = new Date(currentDate - i * 24 * 3600 * 1000);
            betweenTimes.add(date);
            respTimes.add(sdfTime.format(new Date(currentDate-i* 24 * 3600 * 1000)));
        }
        Map allConfigLive = courseLiveConfigService.findAllConfigLive();
        List<Integer> ids = (List<Integer>) allConfigLive.get("courIdList");
        model.addAttribute("liveCarousel",allConfigLive);
        model.addAttribute("liveNumMap",courseLiveService.findLiveWatchNumByDate(betweenTimes,ids));
        model.addAttribute("liveTimes",respTimes);
        model.addAttribute("liveIds",ids );
        return "live/live-config";
    }


    /**
     * 直播列表接口
     * @return  model
     * @author 李恒名
     * @date 2016年5月31日
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "查询直播课列表")
    @RequestMapping("/list")
    @ResponseBody
    public DataTablePageModel list(CourseLiveSearchBean search){
        if(search.getDerectionId() == null){//未选择任何分类的情况下,默认显示该用户所拥有分类下的直播课程信息
            Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "live", "find");
            search.setDerectionIds(ids);
        }
        return courseLiveService.buildModelBySearch(search) ;
    }

    /**
     * 添加直播接口
     * @return  model
     * @author 李恒名
     * @date 2016年5月31日
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "添加直播课")
    @RequestMapping("/save")
    @ResponseBody
    public ResponseJsonModel save(CourseLive courseLive){
        Date now = new Date();
        ResponseJsonModel model=new ResponseJsonModel() ;
        courseLive.setCreateTime(now);
        courseLive.setUserid(ShiroUtils.getSessionUser().getId());
        courseLive.setInitNum(Integer.valueOf((int) (Math.random()*10+90)));
        courseLive.setSubscriptionCount(0);
        courseLive.setDeleted(0);
        try{
            courseLiveService.save(courseLive);
            courseLiveService.createLiveBookingTask(courseLive.getLiveStart(), courseLive.getId());
        }catch(Exception e){
            model.setCode("500");
            model.setMsg("保存直播课异常，请重试！");
        }
        return model ;
    }

    /**
     * 删除直播接口
     * @return  model
     * @author 李恒名
     * @date 2016年5月31日
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "删除直播课")
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseJsonModel delete(Long id){
        ResponseJsonModel model = new ResponseJsonModel();
        List<Integer> ids = courseLiveConfigService.findAllCourseIds();
        if (ids.contains((Integer) id.intValue())){
            model.setCode("500");
            model.setMsg("该直播课已经配置在首页，请解除配置后再操作删除！");
        }else {
            courseLiveService.logicDelete(id);
            courseLiveService.removeLiveBookingTask(id);
            model.setCode("200");
        }
        return model ;
    }
    /**
     * 修改直播接口
     * @return  model
     * @author 李恒名
     * @date 2016年5月31日
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "修改直播课")
    @RequestMapping("/modify")
    @ResponseBody
    public ResponseJsonModel modify(CourseLive courseLive){
        Date oldLiveTime = courseLiveService.findById(courseLive.getId()).getLiveStart();
        courseLiveService.update(courseLive);
        courseLiveService.updateLiveBookingTask(oldLiveTime,courseLive.getLiveStart(), courseLive.getId());
        return new ResponseJsonModel() ;
    }

    /**
     * 直播详情接口
     * @return  model
     * @author 李恒名
     * @date 2016年5月31日
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "查询直播课详情")
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id){
        ResponseJsonModel model = new ResponseJsonModel();
        CourseLive courseLive = courseLiveService.findById(id);
        model.setResult(courseLive);
        return model;
    }

}
