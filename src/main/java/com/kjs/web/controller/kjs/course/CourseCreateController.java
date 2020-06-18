package com.kjs.web.controller.kjs.course;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.ResponseResult;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.constant.HttpConstant;
import com.kjs.common.constant.SessionConstant;
import com.kjs.common.dto.CourseDto;
//import com.kjs.common.dto.UserStuDto;
import com.kjs.common.dto.course.CourseBaseDto;
import com.kjs.common.dto.course.CourseFilterDto;
import com.kjs.common.dto.course.CourseSortDto;

//import com.kjs.common.util.ShiroUtils;
import com.kjs.common.utils.*;
import com.kjs.orm.model.*;
import com.kjs.service.kjs.category.CategoryIndustryService;
import com.kjs.service.kjs.category.CategoryPositionService;
import com.kjs.service.kjs.category.spi.ICategoryDirectionService;
import com.kjs.service.kjs.category.spi.ICategoryIndustryService;
import com.kjs.service.kjs.category.spi.ICategoryPositionService;
import com.kjs.service.kjs.course.spi.*;
import com.kjs.service.kjs.home.HomeSetService;
import com.kjs.service.kjs.plan.SetPlanCourseService;
import com.kjs.service.kjs.system.spi.ISysTagService;
import com.kjs.service.kjs.teacher.spi.ITeacherService;
import com.kjs.web.serach.kjs.course.CourseConditionBean;
import com.kjs.web.serach.kjs.course.CourseSearchBean;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;

/**
 * Created by Administrator on 2016/5/24 0024.
 */
@Controller
@RequestMapping("/course")
public class CourseCreateController {
    private final static Logger logger = LoggerFactory.getLogger(CourseCreateController.class);
    @Resource
    private ICourseService courseService;
    @Resource
    private ICourseTextService courseTextService;
    @Resource
    private ICourseIndustryService courseIndustryService;
    @Resource
    private ICourseLectureService courseLectureService;
    @Resource
    private ICourseAdvantageService courseAdvantageService;
    @Resource
    private ISysTagService sysTagService;
    @Resource
    private ICourseSuitableService courseSuitableService;
    @Resource
    private ICategoryDirectionService categoryDirectionService;
    
    @Resource
    private ICategoryIndustryService categoryIndustryService;
    
    @Resource
    private ICategoryPositionService categoryPositionService;
    @Resource
    private SetPlanCourseService setPlanCourseService;
    @Resource
    private ITeacherService teacherService;
    @Resource
    private HomeSetService homeSetService;


    @PermissionAnn(menuCode = "addcourse", msg = "你没有进入创建课程页面的权限!")
    @RequestMapping(value = "/create/{operationType}")
    public String createCourse(Model model, CourseSearchBean courseSearchBean, @PathVariable Integer operationType) {
        model.addAttribute("operationType", operationType);
        return "course/course_create";
    }

    @PermissionAnn(menuCode = "addcourse", msg = "你没有进入创建课程页面的权限!")
    @RequestMapping(value = "/backUp/{id}/{operationType}")
    public String backUp(Model model, CourseSearchBean courseSearchBean, @PathVariable Long id, @PathVariable Integer operationType) {
        model.addAttribute("operationType", operationType);
        Course course = courseService.findById(id);
        model.addAttribute("course", course);
        model.addAttribute("courseId", id);
        return "course/course_create";
    }

    /*配置章节页面的返回上一步*/
    @PermissionAnn(menuCode = "addcourse", msg = "你没有进入创建课程页面的权限!")
    @RequestMapping(value = "/configBackUp/{id}/{operationType}")
    public String configBackUp(Model model, CourseSearchBean courseSearchBean, @PathVariable Integer id, @PathVariable Integer operationType) {
        model.addAttribute("operationType", operationType);
        CourseText courseText = courseTextService.selectByCourseId(id);
        model.addAttribute("courseText", courseText);
        model.addAttribute("courseId", id);
        return "course/course_brief";
    }
    //根据方向，行业职业id获取对应的课程列表
    @ResponseBody
    @RequestMapping("/courseListByIds")
    public ResponseJsonModel findCourseListByIds(Integer directionId,Integer positionId,String industryIds){
        //split()——用于把字符串分割成逗号间隔的字符串数组
    	//将行业数组中的内容添加到列表中
    	String[] strToInt=industryIds.split(",");     
        List<Integer> intList=new ArrayList<>();
        if(strToInt.length>0&& !"".equals(industryIds)){
            for(int i=0;i<strToInt.length;i++){
                intList.add(Integer.parseInt(strToInt[i]));
            }
        }
        List<Course> courseList=new ArrayList<Course>();
        if(industryIds.equals("")){
            courseList=courseService.findCourseListBy2Ids(directionId,positionId);
        }else{
            courseList=courseService.findCourseListByIds(directionId,positionId, intList);
        }

        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setResult(courseList);
        return responseJsonModel;
    }
    
   
    
    
    
    
    
    
    
    
    
    
    

    /**
     *
     * @param request
     * @param courseBase 课程基本信息json字符串
     * @param courseText 课程长字段json字符串
     * @param courseLectures 课程章节信息json字符串
     * @param courseId    课程Id
     * @param industryId  课程行业对应关系字符串类型：2,3
     * @param advantageTagId 课程优势字符串 2,3
     * @param suitableTagId  课程适合对象字符串 2,3
     * @param examState       课程的审核状态
     * @return
     */
    @Transactional
    @ResponseBody
    @RequestMapping(value = "/submitAll")
    public ResponseJsonModel submitAll(HttpServletRequest request, String courseBase, String courseText, String courseLectures, Integer courseId,String industryId,String advantageTagId,String suitableTagId,Integer examState) {
        Gson gson = new GsonBuilder().create();
        System.out.println(courseBase);
        System.out.println(courseText);
        System.out.println(courseId);
        System.out.println("__________________________________________________________________________________");
//        Course course = gson.fromJson(courseBase, Course.class);
        CourseText courseText1 = gson.fromJson(courseText, CourseText.class);
          /*保存课程的基本信息*/
        AuthorityUsers user = ShiroUtils.getSessionUser();
        
        JSONObject jsonObject=new JSONObject(courseBase);
        String learningIdeas1= (String) jsonObject.get("learningIdeas1");
        String learningIdeas2= (String) jsonObject.get("learningIdeas2");
        String learningIdeas3= (String) jsonObject.get("learningIdeas3");
      /*  String [] learningIdeas=new String[3];
        learningIdeas[0]=learningIdeas1;
        learningIdeas[1]=learningIdeas2;
        learningIdeas[2]=learningIdeas3;*/
        Map<String,String> data=new TreeMap<String,String>();
        data.put("learningIdeas1",learningIdeas1);
        data.put("learningIdeas2",learningIdeas2);
        data.put("learningIdeas3",learningIdeas3);
        
        CourseBaseDto courseBaseDto = gson.fromJson(courseBase, CourseBaseDto.class);
        courseBaseDto.setLearningIdeas(new Gson().toJson(data));
        
//        courseBaseDto.setOrderIndex(course.getOrderIndex());
        
        courseBaseDto.setUserid(Integer.parseInt(user.getId().toString()));
        //设置审核状态
        courseBaseDto.setPublishState(examState);
        //设置观看视频人数基数
        if (courseBaseDto.getCoursePlayNumber() == 0) {
            courseBaseDto.setCoursePlayNumber(1);
        }
        //创建课程日期
        if (courseBaseDto.getCreateDate() == null || courseBaseDto.getCreateDate().equals("")) {
            courseBaseDto.setCreateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        }
        //更新日期
        courseBaseDto.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
         /*查询课程是否存在，存在更新不存在保存*/
        Course testCourse = null;
        //如果课程存在：
        if (courseId != null && courseId != 0 && !"0".equals(courseId + "")) {
        	//设置课程ID
            courseBaseDto.setId(courseId);
            testCourse = courseService.findById(Long.parseLong(courseId + ""));
        }
        if (testCourse != null) {
            /*课程存在做更新操作并返回结果*/
            if(examState==1){//如果是审核通过则定义在线状态为在线(1)
                //查询是否有更高的版本，没有更高版本改变在线状态，有更高版本不改变在线状态
                List<Course> higherVersionList=courseService.findHasHigherVersion(Integer.parseInt(testCourse.getId()+""));
                //如果有更高版本，不用变在线状态
                if(higherVersionList!=null && higherVersionList.size()>0){

                }else{
                	//如果没有更高版本，则设置在线状态为1
                    courseBaseDto.setOnlineState(1);
                }
//                Course courseOI=courseService.findById(Long.parseLong(courseId + ""));
//                courseBaseDto.setOrderIndex(1);
                
                courseBaseDto.setPublishState(1);
                courseBaseDto.setPublishTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                courseBaseDto.setPublishUserid(Integer.parseInt(user.getId() + ""));
                if(courseBaseDto.getPreCourseId()!=0){//如果是更新课程则现保存现课程，然后更新老版本的发布状态
                    courseService.updateCourse(courseBaseDto);
                    //更新个人计划
                    setPlanCourseService.updatePlanCourse(courseId, courseBaseDto.getPreCourseId());
                    //更新首页配置
                    homeSetService.updateHomeSet(courseBaseDto.getPreCourseId(),courseId);
                    Course preCourse=courseService.findById(Long.parseLong(courseBaseDto.getPreCourseId()+""));
                    preCourse.setOnlineState(0);
                    preCourse.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
//                    preCourse.setOrderIndex(1);
                    courseService.update(preCourse);
                }else{
                    courseService.updateCourse(courseBaseDto);
                }
            }else{
                courseBaseDto.setPublishState(0);
                //courseBaseDto.setId(Integer.parseInt(testCourse.getPreCourseId()+""));
                courseBaseDto.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                
                courseService.updateCourse(courseBaseDto);
            }

            logger.warn("更新课程基本信息:" + courseId + "-" + courseBaseDto.toString() + "-userId:" + user.getId());
            /*删除并保存课程行业对应信息*/
            courseIndustryService.deleteCourseIndustry(courseId);
              /*保存课程和行业的对应信息*/
            String[] industryids =industryId.split(",");
            if (industryids != null && industryids.length > 0 && !industryId.equals("")) {
                for (String industryid : industryids) {
                    CourseIndustry courseIndustry = new CourseIndustry();
                    courseIndustry.setCourseId(courseId);
                    courseIndustry.setIndustryId(Integer.parseInt(industryid));
                    courseIndustry.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseIndustry.setAuthorityUserId(Integer.parseInt(user.getId().toString()));
                    courseIndustryService.saveCourseIndustry(courseIndustry);
                    logger.warn("更新课程基本信息:" + courseId + "-" + "-userId:" + user.getId());
                }
            }
            /*删除并保存课程和课程优势信息*/
            courseAdvantageService.deleteCourseAdvantage(courseId);
             /*保存课程优势信息  同时更新标签表中与视频相关联数量的字段*/
            String[] advantageTagIds = advantageTagId.split(",");
            if (advantageTagIds != null && advantageTagIds.length > 0) {
                for (String sysTagId : advantageTagIds) {
                /*保存课程优势*/
                    CourseAdvantage courseAdvantage = new CourseAdvantage();
                    courseAdvantage.setUserId(Integer.parseInt(user.getId().toString()));
                    courseAdvantage.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseAdvantage.setCourseId(courseId);
                    courseAdvantage.setAdvantageId(Integer.parseInt(sysTagId));
                    courseAdvantageService.save(courseAdvantage);
                    logger.warn("更新课程对应优势标签:" + courseId + "-" + "-userId:" + user.getId());
                }
            }
            /*删除并保存课程适合对象信息*/
            courseSuitableService.deleteCourseSuitable(courseId);
              /*保存适合对象信息  同时更新标签表中与视频相关联数量的字段*/
            String[] suitableTagIds = suitableTagId.split(",");
            if (suitableTagIds != null && suitableTagIds.length > 0) {
                for (String sysTagId : suitableTagIds) {
                /*保存课程优势*/
                    CourseSuitable courseSuitable = new CourseSuitable();
                    courseSuitable.setUserId(Integer.parseInt(user.getId().toString()));
                    courseSuitable.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseSuitable.setCourseId(courseId);
                    courseSuitable.setSuitableId(Integer.parseInt(sysTagId));
                    courseSuitableService.save(courseSuitable);
                    logger.warn("更新课程适合对象:" + courseId + "-" + "-userId:" + user.getId());
                }
            }
            /*更新课程长字段*/
            courseText1.setCourseId(courseId);
            courseText1.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
            courseText1.setDeleted(0);
            courseText1.setJobDuty(courseText1.getJobDuty());
            courseText1.setSummary(courseText1.getSummary());
            courseText1.setTeacherId(courseText1.getTeacherId());
            courseText1.setUpdateDate(new Date());
            courseTextService.update(courseText1);
            logger.warn("更新课程长字段:" + courseId + "-" + "-userId:" + user.getId());
        }else{
            if(examState==1){
                courseBaseDto.setOnlineState(1);
                courseBaseDto.setPublishState(1);
                courseBaseDto.setPublishTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                courseBaseDto.setPublishUserid(Integer.parseInt(user.getId() + ""));
                if(courseBaseDto.getPreCourseId()!=0){//如果是更新课程则现保存现课程，然后更新老版本的发布状态
                    courseService.updateCourse(courseBaseDto);
                    Course preCourse=courseService.findById(Long.parseLong(courseBaseDto.getPreCourseId()+""));
                    preCourse.setOnlineState(0);
                    preCourse.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseService.update(preCourse);
                    //更新个人计划
                    setPlanCourseService.updatePlanCourse(courseId, courseBaseDto.getPreCourseId());
                    //更新首页配置
                    homeSetService.updateHomeSet(courseBaseDto.getPreCourseId(),courseId);
                }else{
                    courseService.updateCourse(courseBaseDto);
                }
            }else{
                courseBaseDto.setPublishTime(new Date());
                courseBaseDto.setPublishUserid(Integer.parseInt(user.getId() + ""));
                courseService.saveCourseBase(courseBaseDto);
            }

            courseId=courseBaseDto.getId();
           /* if(courseBaseDto.getPreCourseId()!=0 && examState.intValue()==1){
                Course oldCourse=courseService.findById(Long.parseLong(courseBaseDto.getPreCourseId() + ""));
                oldCourse.setPublishState(3);
                oldCourse.setOnlineState(0);
                courseService.update(oldCourse);
                //更新个人计划
                setPlanCourseService.updatePlanCourse(courseId,courseBaseDto.getPreCourseId());
            }*/
               /*保存课程和行业的对应信息*/
            String[] industryids =industryId.split(",");
            if (industryids != null && industryids.length > 0 && !industryId.equals("")) {
                for (String industryid : industryids) {
                    CourseIndustry courseIndustry = new CourseIndustry();
                    courseIndustry.setCourseId(courseId);
                    courseIndustry.setIndustryId(Integer.parseInt(industryid));
                    courseIndustry.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseIndustry.setAuthorityUserId(Integer.parseInt(user.getId().toString()));
                    courseIndustryService.saveCourseIndustry(courseIndustry);
                    logger.warn("保存课程行业对应信息:" + courseId + "-" + "-userId:" + user.getId());
                }
            }
        /*保存课程优势信息  同时更新标签表中与视频相关联数量的字段*/
            String[] advantageTagIds = advantageTagId.split(",");
            if (advantageTagIds != null && advantageTagIds.length > 0) {
                for (String sysTagId : advantageTagIds) {
                /*保存课程优势*/
                    CourseAdvantage courseAdvantage = new CourseAdvantage();
                    courseAdvantage.setUserId(Integer.parseInt(user.getId().toString()));
                    courseAdvantage.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseAdvantage.setCourseId(courseId);
                    courseAdvantage.setAdvantageId(Integer.parseInt(sysTagId));
                    courseAdvantageService.save(courseAdvantage);
                    logger.warn("保存课程优势信息:" + courseId + "-" + "-userId:" + user.getId());

                }
            }
         /*保存适合对象信息  同时更新标签表中与视频相关联数量的字段*/
            String[] suitableTagIds =suitableTagId.split(",");
            if (suitableTagIds != null && suitableTagIds.length > 0) {
                for (String sysTagId : suitableTagIds) {
                /*保存课程优势*/
                    CourseSuitable courseSuitable = new CourseSuitable();
                    courseSuitable.setUserId(Integer.parseInt(user.getId().toString()));
                    courseSuitable.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
                    courseSuitable.setCourseId(courseId);
                    courseSuitable.setSuitableId(Integer.parseInt(sysTagId));
                    courseSuitableService.save(courseSuitable);
                    logger.warn("保存课程适合对象信息:" + courseId + "-" + "-userId:" + user.getId());
                }
            }
            courseText1.setCreateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
            courseText1.setDeleted(0);
            courseText1.setCourseId(courseId);
            courseText1.setJobDuty(courseText1.getJobDuty());
            courseText1.setSummary(courseText1.getSummary());
            courseText1.setTeacherId(courseText1.getTeacherId());
            courseTextService.saveCourseText(courseText1);
            logger.warn("保存课程长字段:" + courseId + "-" + "-userId:" + user.getId());
        }
        /*更新添加或者删除课程章节*/
        submitCourse(courseLectures, courseId);
         /*更新完成返回*/
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        return responseJsonModel;
    }


    /**
     * 最终提交章节
     * @param  lectureStr 章节json字符串
     * @param
     */
    public void submitCourse(String lectureStr,Integer courseId){
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        AuthorityUsers user = ShiroUtils.getSessionUser();
        Gson gson =new Gson();
        List<CourseLecture> lectures =gson.fromJson(lectureStr, new TypeToken<List<CourseLecture>>() {
        }.getType()) ;
        //courseId=lectures.get(0).getCourseId();
         /*提审时 publishState修改为0 */
        Course course=new Course();
        course.setId(Long.parseLong(courseId + ""));
        course.setPublishUserid(Integer.parseInt(user.getId() + ""));
         List<Integer> ids=new ArrayList();
        for(int i=0;i<lectures.size();i++){
            ids.add(lectures.get(i).getId().intValue());
        }
        List<CourseLecture> delList=courseLectureService.findByCourseId(Long.parseLong(courseId + ""));
        for(CourseLecture lecture:delList){
           boolean flag= ids.contains(lecture.getId().intValue());
            if(!flag){
                courseLectureService.deleteById(lecture.getId());
            }
        }
        List<CourseLecture> updateList=new ArrayList<>();
        List<CourseLecture> addList=new ArrayList<>();
        for(int i = 0; i < lectures.size() ; i++)
        {
            CourseLecture lecture = lectures.get(i);
            String videoId=lecture.getVideoId().trim();
            String videoUnique="";
            String video_duration="";//视频时长  单位为秒

            /*根据乐视id获取videoUnique*/
            if(videoId!=null && !"".equals(videoId) && Integer.parseInt(videoId)>0 ){
                Integer leTVId=Integer.parseInt(videoId);
                LetvCloudV1 client = new LetvCloudV1(ParamUtil.letvUserUnique, ParamUtil.letvSecretKey);
                try {
                    String res = client.videoGet(leTVId);
                    if(StringOperUtils.isEmpty(res)){

                    }
                    JSONObject jsonObj = new JSONObject(res);
                    Integer code = (Integer)jsonObj.get("code");
                    if(code==Integer.parseInt("0")){
                        JSONObject dataObj= (JSONObject) jsonObj.get("data");
                        String videUnique=String.valueOf(dataObj.get("video_unique"));
                        video_duration=String.valueOf(dataObj.get("video_duration"));
                        if(videUnique!=null && !"".equals(videUnique) && !videUnique.equals("null")){
                            videoUnique=videUnique;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            //cc视频长度
            if(StringUtil.isNotEmpty(lecture.getCcVideoUnique())){
                video_duration = new CcDevloperV2().getDuration(lecture.getCcVideoUnique());
            }

            lecture.setVideoLength(video_duration);
            lecture.setCourseId(courseId);
            lecture.setPublishDate(new Date());
            lecture.setVideoUnique(videoUnique);
            lecture.setUserId(Integer.parseInt(user.getId() + ""));
            lecture.setPublishState(1);
            if (StringUtil.isEmpty(lecture.getDeleted())){
                lecture.setDeleted(false);
            }
            if(lecture.getId()!=null &&lecture.getId()>0){
                updateList.add(lecture);
            }else{
                addList.add(lecture);
            }
        }
        if(addList!=null && addList.size()>0){
            courseLectureService.insertLecture(addList);
        }
        for(CourseLecture cl:updateList){
            courseLectureService.update(cl);
        }
        logger.warn("保存课程视频信息:" + courseId + "-" + "-userId:" + user.getId());
    }


    @PermissionAnn(menuCode = "course",msg = "你没有进入管理课程页面的权限!")
    @RequestMapping(value="/manager")
    public String managerCourse(HttpServletRequest request, HttpServletResponse response){
      return "/course/course_exam";

    }

    /**
     * 跳转到课程管理Tab页面
     * @return
     */
    @PermissionAnn(menuCode = "course",msg = "你没有进入课程管理Tab页面的权限!")
    @RequestMapping(value = "/managerTab/{id}/{desc}")
    public String forwardManagerTab(Model model,@PathVariable Integer id,@PathVariable String desc){
        model.addAttribute("publishState", id);
        return "/course/course_exam";
    }

    /**
     * 获取课程列表
     * @return
     */
    @PermissionAnn(menuCode = "course",msg = "你没有进入获取课程列表的权限!")
    @RequestMapping(value = "/list")
    @ResponseBody
    public DataTablePageModel searchCourseList(CourseConditionBean courseSearchBean){
        if(courseSearchBean.getDirectionId() == null){//未选择任何分类的情况下,默认显示该用户所拥有分类下的直播课程信息
            Long[] ids = categoryDirectionService.findCateIdsByUserIdAndResourceCodeAndOperationCode(ShiroUtils.getSessionUser().getId(), "course", "find");
            courseSearchBean.setDerectionIds(ids);
        }
        courseService.findCourseList(courseSearchBean);
        return courseSearchBean;
    }

    /**
     * 删除课程
     * @param model
     * @param courseSearchBean
     * @return
     */
//    @PermissionAnn(menuCode = "course",msg = "你没有删除课程的权限!")
    @RequestMapping(value = "/deleteCourse")
    @ResponseBody
    public CourseSearchBean deleteCourse(Model model,CourseSearchBean courseSearchBean,HttpServletRequest request){
        AuthorityUsers user = (AuthorityUsers) request.getSession().getAttribute(SessionConstant.LOGIN_USER);
       
        courseService.deleteCourse(courseSearchBean);
        courseIndustryService.deleteCourseIndustry(courseSearchBean.getId());
        logger.warn("删除课程:" + courseSearchBean.getId() + "-" + "-userId:" + user.getId());
        return courseSearchBean;
    }


    /**
     * 审核课程 通过
     * @param model
     * @param course
     */
    @PermissionAnn(menuCode = "course",msg = "你没有审核课程的权限!")
    @RequestMapping(value = "/courseExamine")
    @ResponseBody
    public ResponseJsonModel courseExamine(Model model,Course course,HttpServletRequest request){
        AuthorityUsers user = (AuthorityUsers) request.getSession().getAttribute(SessionConstant.LOGIN_USER);
        course.setPublishTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        course.setPublishUserid(Integer.parseInt(user.getId() + ""));
        course.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        courseService.courseExamine(course);
        logger.warn("审核课程:" + course.getId() + "-" + "-userId:" + user.getId());
        System.out.println(new ResponseJsonModel());
        return new ResponseJsonModel();

    }

    /**
     * 课程列表查看按钮返回 到创建课程页面并回写内容
     * @param model
     * @param courseSearchBean
     * @return
     */
    @PermissionAnn(menuCode = "course",msg = "你没有审核课程的权限!")
    @RequestMapping(value = "/scanCourse/{id}/{type}")
//    @ResponseBody
    public String scanCourse(Model model,CourseSearchBean courseSearchBean,@PathVariable Integer id,@PathVariable Integer type){
        model.addAttribute("course", courseService.scanCourse(id));
        model.addAttribute("courseText", courseTextService.selectByCourseId(id));
        model.addAttribute("courseLecture", courseLectureService.findByCourseId(id.longValue()));
        model.addAttribute("courseId", id);
//        model.addAttribute("optionType", type);
        model.addAttribute("operationType", type);
        
        return "/course/course_create";
    }

    /**
     * 取消课程审核同时将课程下线
     * @param model
     * @param course
     * @return
     */
    @PermissionAnn(menuCode = "course",msg = "你没有取消审核课程的权限!")
    @RequestMapping(value = "/cancelCourse")
    @ResponseBody
    public Course cancelCourse(HttpServletRequest request,Model model,Course course){
        AuthorityUsers user = (AuthorityUsers) request.getSession().getAttribute(SessionConstant.LOGIN_USER);
        course.setPublishCancelTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        course.setPublishUserid(Integer.parseInt(user.getId() + ""));
        course.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        courseService.cancelCourse(course);
        logger.warn("审核课程取消:" + course.getId() + "-" + "-userId:" + user.getId());
        return course;
    }

    /**
     *审核课程不通过
     * @param model
     * @param course
     */
    @PermissionAnn(menuCode = "course",msg = "你没有审核课程的权限!")
    @RequestMapping(value = "/courseExamineFail")
    @ResponseBody
    public ResponseJsonModel courseExamineFail(HttpServletRequest request,Model model,Course course){
        AuthorityUsers user = (AuthorityUsers) request.getSession().getAttribute(SessionConstant.LOGIN_USER);
        course.setPublishTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        course.setPublishUserid(Integer.parseInt(user.getId() + ""));
        course.setUpdateDate(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        courseService.courseExamineFail(course);
        logger.warn("审核课程不通过:" + course.getId() + "-" + "-userId:" + user.getId());
        return new ResponseJsonModel();
    }

    /**
     * 根据方向查询课程列表
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/select/list/{cateId}",method = RequestMethod.GET)
    public ResponseJsonModel serachAllCourseInfo(@PathVariable Long cateId){
        List<Course> list=courseService.searchCourseByCateId(cateId);
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        responseJsonModel.setResult(list);
        return responseJsonModel;
    }

    /**
     * 讲义预览
     * @return  view
     * @author
     * @date 2016年5月31日
     */
    @PermissionAnn(menuCode = "course",msg = "你没有预览PDF页面的权限!")
    @RequestMapping("/preview")
    public String manager(Model model,String swfUrl,String pdfUrl) {
        model.addAttribute("swfUrl", swfUrl);
        model.addAttribute("pdfUrl", pdfUrl);
        return "course/course_preview";
    }
    /**
     * 简介预览
     * @return  view
     * @author
     * @date 2016年5月31日
     */
    @PermissionAnn(menuCode = "course",msg = "你没有预览PDF页面的权限!")
    @RequestMapping("/editorPreview")
    public String editorPreview(Model model, String jobDuty,String courseBrief,Integer teacherId,String pid) {
        if(teacherId!=null){
            Teacher  teacher=teacherService.findById(Long.parseLong(teacherId + ""));
            model.addAttribute("teacher",teacher);
        }
        model.addAttribute("courseBrief",courseBrief);
        if(pid.equals("kjs")){
            model.addAttribute("jobDuty",jobDuty);
        }
        model.addAttribute("pid",pid);
        return "course/course_brief_preview";
    }
    @RequestMapping(value = "/updateCourseFileLength")
    public void updateCourseFileLength(){
        courseLectureService.findAll();

    }

    
    
    /**
     * @Author liuhuan
     * @Description 根据行业查询课程
     * @Date  2019/08/08
     * @Param [industryId]
     * @return com.kjs.common.bean.ResponseJsonModel
     **/
    @ResponseBody
    @RequestMapping(value = "/findCourseByIndustryId/{industryId}",method = RequestMethod.GET)
    public ResponseJsonModel findCourseByIndustryId(@PathVariable Long industryId){
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        List<Course> list= null;
        try {
            list = courseService.searchCourseByIndustryId(industryId);
            responseJsonModel.setResult(list);
        } catch (Exception e) {
            responseJsonModel.setCode(HttpConstant.ERROR_CODE);
            logger.error(e.getMessage(),e);
        }
        return responseJsonModel;
    }
    
    
    /**
     * 根据职位返回课程列表，用作排序
     * @Author 嵇俊达
     * @Date  2020/04/02
     * @param model
     * @param courseSearchBean
     * @param operationType
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/findCourseByPositionId",method = RequestMethod.GET)
    public ResponseJsonModel findCourseByPositionId(Integer positionId){
    	System.out.println(positionId);
        ResponseJsonModel responseJsonModel=new ResponseJsonModel();
        List<Course> list= null;
        try {
            list = courseService.searchCourseByPositionId(positionId);
            responseJsonModel.setResult(list);
        } catch (Exception e) {
            responseJsonModel.setCode(HttpConstant.ERROR_CODE);
            logger.error(e.getMessage(),e);
        }
        return responseJsonModel;
    }
    
    
    
    
    /**
     *  修改课程顺序
     * @Author 嵇俊达
     * @Date  2020/04/03
     * @param cate
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "修改分类方向")
//  @PermissionAnn(menuCode = "cate",operCode = "update",msg = "你没有修改分类方向的权限!")
  @ResponseBody
  @RequestMapping(value = "/update"/*,method = RequestMethod.POST*/)
  public ResponseJsonModel orderUpdate(String course){
//      System.out.println(course);

         this.courseService.orderUpdate(course);
         return new ResponseJsonModel();
  }
    
    
    
    /**
     * 返回课程排序页面
     * @Author 嵇俊达
     * @Date  2020/04/02
     * @param mv
     * @param request
     * @return
     */
    @RequestMapping("/sort")
    public ModelAndView courseSort(ModelAndView mv, HttpServletRequest request) {
       //传递参数
        String directionId = request.getParameter("directionId");
        String industryId = request.getParameter("industryId");
        String positionId = request.getParameter("positionId");
        mv.addObject("directionId", directionId);
        mv.addObject("positionId", positionId);
        mv.addObject("industryId", industryId);

        //课程信息
        mv.addObject("courses", courseService.findByCourses(directionId, industryId, positionId));

//        //方向信息
        mv.addObject("directions", categoryDirectionService.find4HomePage());

        CourseFilterDto dto = new CourseFilterDto();
        //行业信息
        dto = categoryIndustryService.find6IndustryPage(directionId, true);
        mv.addObject("industrys", dto.getIndustryList());
        mv.addObject("industryMore", dto.isShowMore());
//
        //职位信息
        dto = categoryPositionService.find6PositionPage(directionId, true);
        mv.addObject("positions", dto.getPositionList());
        mv.addObject("positionMore", dto.isShowMore());

        mv.setViewName("course/course_sort");
        
       
        return mv;
    }
}
    
   
