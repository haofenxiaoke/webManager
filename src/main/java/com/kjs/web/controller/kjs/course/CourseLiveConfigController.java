package com.kjs.web.controller.kjs.course;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.CourseLive;
import com.kjs.orm.model.CourseLiveConfig;
import com.kjs.service.kjs.course.spi.ICourseLiveConfigService;
import com.kjs.service.kjs.course.spi.ICourseLiveService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by 杨天峰 on 2017/3/29.
 */
@Controller
@RequestMapping("/configlive")
public class CourseLiveConfigController {
    @Resource
    ICourseLiveService courseLiveService;
    @Resource
    ICourseLiveConfigService courseLiveConfigService;


    /**
     * 保存直播配置
     *
     * @param courseLiveConfig
     * @auther 杨天峰
     * @date 2017年3月129日
     * @return model
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "添加直播配置")
    @RequestMapping("/save")
    @ResponseBody
    public ResponseJsonModel saveCarousel(CourseLiveConfig courseLiveConfig) {
        ResponseJsonModel model = new ResponseJsonModel();
        AuthorityUsers user = ShiroUtils.getSessionUser();
        List<Integer> ids = courseLiveConfigService.findAllCourseIds();
        if (ids.contains(courseLiveConfig.getCourseId())){
            model.setCode("500");
            model.setMsg("该课程已经保存！");
        }else {
            CourseLive courseLive = courseLiveService.findById((long) courseLiveConfig.getCourseId());
            courseLiveConfig.setHrefUrl(courseLive.getCourseUrl());
            courseLiveConfig.setCategoryId(courseLive.getCategoryId());
            courseLiveConfig.setCreateTime(new Date());
            courseLiveConfig.setCreateUserid(Integer.parseInt(user.getId().toString()));
            courseLiveConfigService.save(courseLiveConfig);
            model.setCode("200");
            model.setMsg("该课程保存成功！");
        }
        return model;
    }
    /**
     * 更新直播配置
     *
     * @param courseLiveConfig
     * @auther 杨天峰
     * @date 2017年3月129日
     * @return model
     */

    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "更新配置")
    @RequestMapping("/update")
    @ResponseBody
    public ResponseJsonModel updateCarousel(CourseLiveConfig courseLiveConfig) {
        ResponseJsonModel model = new ResponseJsonModel();
        AuthorityUsers user = ShiroUtils.getSessionUser();
        List<Integer> ids = courseLiveConfigService.findAllCourseIds();
        if (ids.contains(courseLiveConfig.getCourseId())){
            model.setCode("500");
            model.setMsg("该课程已经存在！");
        }else {
            CourseLive courseLive = courseLiveService.findById((long) courseLiveConfig.getCourseId());
            courseLiveConfig.setHrefUrl(courseLive.getCourseUrl());
            courseLiveConfig.setCategoryId(courseLive.getCategoryId());
            courseLiveConfig.setLastUpdateTime(new Date());
            courseLiveConfig.setLastUpdateUserid(Integer.parseInt(user.getId().toString()));
            courseLiveConfigService.update(courseLiveConfig);
            model.setCode("200");
            model.setMsg("该课程更新成功！");
        }
        return model;
    }
    /**
     * 删除直播配置
     *
     * @param id
     * @auther 杨天峰
     * @date 2017年3月129日
     * @return model
     */
    @AdminLogAnn(operType = OperType.COURSE,operLevel = OperLevel.NORM,operDescribe = "删除直播配置")
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseJsonModel deleteCarousel(Long id) {
        Long[] ids = {Long.parseLong(id + "")};
        courseLiveConfigService.deleteByIds(ids);
        return new ResponseJsonModel();
    }


    @ResponseBody
    @RequestMapping("/list/live/find")
    public ResponseJsonModel findliveListByIdAndType(Integer directionId,Integer type){
        ResponseJsonModel model = new ResponseJsonModel();
        List<CourseLive> courseLiveConfigs=courseLiveConfigService.findliveListByIdAndType(directionId,type);
        model.setCode("200");
        model.setResult(courseLiveConfigs);
        return model;
    }


}
