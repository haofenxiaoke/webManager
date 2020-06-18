package com.kjs.service.kjs.course;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;


import com.github.pagehelper.PageHelper;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.dto.course.CourseBaseDto;
import com.kjs.common.dto.course.CourseDto;
import com.kjs.common.dto.course.CourseSortDto;
import com.kjs.common.utils.RequestParamUtils;
import com.kjs.orm.mapper.CourseLectureMapper;
import com.kjs.orm.mapper.CourseMapper;
import com.kjs.orm.mapper.CourseTextMapper;
import com.kjs.orm.mapper.UserLectureScoreMapper;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.Course;
import com.kjs.orm.model.CourseLecture;
import com.kjs.orm.model.UserLectureScore;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseService;
import com.kjs.web.serach.kjs.course.CourseConditionBean;
import com.kjs.web.serach.kjs.course.CourseSearchBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Service Implementation:Course
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseService extends BaseService<Course,Long> implements ICourseService {

    @Resource
    private CourseMapper courseDao;
    @Resource
    private CourseLectureMapper courseLectureDao;
    @Resource
    private CourseTextMapper courseTextDao;
    @Resource
    private UserLectureScoreMapper userLectureScoreDao;


    /**
     * 更新课程基本信息
     */

    public void updateCourse(CourseBaseDto courseBaseDto) {
        courseDao.updateCourse(courseBaseDto);
    }

    @Override
    /**
     * 根据课程分类方向ID查询课程信息
     */
    public List<Course> searchCourseByCateId(Long directionId) {
        return this.courseDao.searchCourseByCateId(directionId);
    }

    /**
     * 保存课程基本信息
     */

    public int saveCourseBase(CourseBaseDto courseBaseDto) {
        int result=courseDao.saveCourseBase(courseBaseDto);
        return result;
    }

    @Override
    public Course searchByUserId(int userId) {

        return courseDao.searchByUserId(userId);
    }

    @Override
    public void findCourseList(CourseConditionBean courseSearchBean) {
        List<Course> course = this.courseDao.page(courseSearchBean);
        if(!CollectionUtils.isEmpty(course))
        {
            long count = this.courseDao.count(courseSearchBean);
            courseSearchBean.setRecordsTotal(count);
            courseSearchBean.setRecordsFiltered(count);
            courseSearchBean.setData(course);
        }
    }

    @Override
    public void deleteCourse(CourseSearchBean courseSearchBean) {
        courseTextDao.delByCourseId(courseSearchBean.getId());
        courseLectureDao.deleteLecturesByCourseId(courseSearchBean.getId());
        courseDao.deleteCourse(courseSearchBean.getId());
    }

    @Override
    public void courseExamine(Course course) {
        courseDao.courseExamine(course);
    }

    @Override
    public void cancelCourse(Course course) {
        courseDao.cancelCourse(course);
    }

    @Override
    public void courseExamineFail(Course course) {
        courseDao.courseExamineFail(course);
    }

    @Override
    public Course scanCourse(int id) {
        return courseDao.findById(Long.parseLong(id+""));
    }

    @Override
    public List<Course> findCourseListByIds(Integer directionId, Integer positionId, List industryIds) {
        Map map=new HashMap<>();
        map.put("directionId",directionId);
        map.put("positionId",positionId);
        map.put("industryIds",industryIds);
        return courseDao.findCourseListByIds(map);
    }

    @Override
    public List<Course> findCourseListBy2Ids(Integer directionId, Integer positionId) {
        Map map=new HashMap<>();
        map.put("directionId",directionId);
        map.put("positionId",positionId);
        return courseDao.findCourseListBy2Ids(map);
    }

    @Override
    public List<Course> findHasHigherVersion(Integer id) {
        return courseDao.findHasHigherVersion(id);
    }

    @Override
    public void updateScore() {
        Course course = new Course();
        course.setDeleted(0);
        course.setPublishState(1);
        course.setOnlineState(1);
        List<Course> courseList = courseDao.search(course);

        CourseLecture lecture = new CourseLecture();
        lecture.setDeleted(false);
        lecture.setPublishState(1);
        List<CourseLecture> lectureList = courseLectureDao.search(lecture);

        if (lectureList != null && lectureList.size() > 0) {
            for (CourseLecture l : lectureList) {
                //更新章节平均分
                updateCourseLecture(l);
            }
        }

        if (courseList != null && courseList.size() > 0) {
            for (Course c : courseList) {
                //更新课程平均分
                updateCourse(c);
            }
        }

    }




    //更新课程章节评分
    void updateCourseLecture(CourseLecture lecture) {

        UserLectureScore score = new UserLectureScore();
        score.setLectureId(lecture.getId().intValue());
        List<UserLectureScore> userLectureList = userLectureScoreDao.search(score);

        if (userLectureList != null && userLectureList.size() > 0) {
            Integer totalScore = 0;
            for (UserLectureScore le : userLectureList) {
                String s = new DecimalFormat("0").format(0.3 * le.getClarity() + 0.3 * le.getWittySpeech() + 0.4 * le.getIsFluency());
                totalScore += Integer.valueOf(s);
            }

            int nowScore = totalScore / userLectureList.size();
            int lastScore = lecture.getLectureScore() == null ? 0 : lecture.getLectureScore();
            if (nowScore > lastScore) {
                lecture.setLectureScore(nowScore);
            }

            courseLectureDao.update(lecture);
        }

    }


    //更新课程学习人数
    void updateCourse(Course course) {

        CourseLecture lecture = new CourseLecture();
        lecture.setCourseId(course.getId().intValue());
        List<CourseLecture> lectureList = courseLectureDao.search(lecture);

        if (lectureList != null && lectureList.size() > 0) {
            Integer totalScore = 0;
            for (CourseLecture lec : lectureList) {
                totalScore += lec.getLectureScore();
            }
            int nowScore = totalScore / lectureList.size();
            int lastScore = course.getScore() == null ? 0 : course.getScore();
            if (nowScore > lastScore) {
                course.setScore(nowScore);//平均分
            }

            course.setScoreNum(course.getScoreNum() + 1);//评分人数基数
            courseDao.update(course);
        }

    }

    /**
     * @Author liuhuan
     * @Description 根据行业id查询课程
     * @Date  2019/08/08
     * @Param [industryId]
     * @return java.util.List<com.kjs.orm.model.Course>
     **/
    @Override
    public List<Course> searchCourseByIndustryId(Long industryId) {
        return courseDao.searchCourseByIndustryId(industryId);
    }

	@Override
	public Object findByCourses(String directionId, String industryId, String positionId) {
		PageHelper.startPage(1, 15);
        List<Course> courseList = courseDao.findByCategory(directionId, industryId, positionId);

        return this.convert(courseList);
	}

	private List<CourseDto> convert(List<Course> courseList) {
        String env = ParamUtil.PRODUCT_ID;
        List<CourseDto> courseDtoList = new ArrayList<>();
        if (courseList != null && courseList.size() > 0) {
            List<Map> courseNumList = courseLectureDao.findCourseNum();

//            //根据用户查找看完的章节
//            Map<Integer, Integer> finishLectures = new HashMap<>(16);
//            if (null != ShiroUtils.getSessionUser()) {
//                finishLectures = userCourseService.findFinishLectureByUser(ShiroUtils.getSessionUser().getId());
//            }

            //List集合转Map
            Map<Integer, Integer> courseNumMap = new HashMap<>(16);
            if (courseNumList != null && courseNumList.size() > 0) {
                for (Map map : courseNumList) {
                    String courseId = map.get("courseId") == null ? "" : map.get("courseId").toString();
                    Integer lectureNum = map.get("lectureNum") == null ? 0 : Integer.parseInt(map.get("lectureNum").toString());
                    courseNumMap.put(Integer.valueOf(courseId), lectureNum);
                }
            }
            
            List<Integer> courseIdList = new ArrayList<>();
            for (Course course : courseList) {
                //courseIdList.add(course.getId());
                CourseDto courseDto = new CourseDto();
                //courseDto.setId(course.getId());
                courseDto.setCoverUrl(course.getCoverUrl());
                courseDto.setCourseStuNum(course.getCourseStuNum());
                courseDto.setScore(course.getScore());

                if (courseNumMap.containsKey(course.getId())) {
                    courseDto.setLectureNum(courseNumMap.get(course.getId()));
                }

//                if (finishLectures.containsKey(course.getId())) {
//                    courseDto.setFinishLectureNum(finishLectures.get(course.getId()));
//                }
                courseDtoList.add(courseDto);
            }
            //批量查询课程是否在课程券有效期内
//            if(null != ShiroUtils.getSessionUser() && "kjs".equalsIgnoreCase(env)) {
//                Integer userId = ShiroUtils.getSessionUser().getId();
//                List<Map<Integer, Integer>> validMap = courseTicketService.getCourseTicketValidByCourseIdsAndUserId(courseIdList, userId);
//                if(null != validMap) {
//                    //装配有效状态
//                    for (CourseDto dto : courseDtoList) {
//                        for (Map<Integer, Integer> map : validMap) {
//                            if(dto.getId().equals(map.get("course_id"))) {
//                                dto.setValidStatus(null != map.get("id"));
//                            }
//                        }
//                    }
//                }
//            }
        }
        return courseDtoList;
    }

	@Override
	public Object sortCourse(CourseSortDto courseSortDto) {
//		if(courseSearchBean.getOnlineState()==1){
//			
//		}
		
		return courseDao.sortCourse(courseSortDto);
	}

	@Override
	public List<Course> searchCourseByPositionId(Integer positionId) {
		return courseDao.searchCourseByPositionId(positionId);
	}

	@Override
	public void orderUpdate(String course) {
		JSONArray json = JSONArray.fromObject(course);
		if(json.size()>0){
			  for(int i=0;i<json.size();i++){
				JSONObject job = json.getJSONObject(i);  
			    System.out.println(job.get("id"));
		
			    
			    Long id=Long.valueOf(job.get("id").toString());
			    Course course1=new Course();
			    course1.setId(id);
			    
			    Integer orderIndex=Integer.valueOf(job.get("orderIndex").toString());
			    course1.setOrderIndex(orderIndex);
			    
			    this.courseDao.orderUpdate(course1);
			  }
		}
		
	}
}