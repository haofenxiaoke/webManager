package com.kjs.web.controller.kjs.course;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.orm.model.CourseLecture;
import com.kjs.service.kjs.course.spi.ICourseLectureService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 李恒名 on 2016/6/19.
 */
@Controller
@RequestMapping("/lecture")
public class CourseLectureController {

    @Resource
    private ICourseLectureService lectureService;

    /**
     * 通过课程id获得视频列表， courseLectures只包含id和name 供级联菜单调用
     * @param courseId 课程id
     * @return model
     * @author 李恒名
     * @date 2016年6月20日
     */
    @RequestMapping("/list")
    @ResponseBody
    public ResponseJsonModel list(Long courseId){
        ResponseJsonModel model = new ResponseJsonModel();
        List<CourseLecture> courseLectures = lectureService.findByCourseId(courseId);
        model.setResult(courseLectures);
        return model;
    }

    @RequestMapping("/completeList")
    @ResponseBody
    public ResponseJsonModel completeList(Long courseId){
        ResponseJsonModel model = new ResponseJsonModel();
        List<CourseLecture> courseLectures = lectureService.findByCourseIdComplete(courseId);
        model.setResult(courseLectures);
        return model;
    }

}
