package com.kjs.service.kjs.course.spi;

import com.kjs.common.dto.course.CourseBaseDto;
import com.kjs.common.dto.course.CourseSortDto;
import com.kjs.orm.model.Course;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.article.ArticleConditionBean;
import com.kjs.web.serach.kjs.course.CourseConditionBean;
import com.kjs.web.serach.kjs.course.CourseSearchBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:Course
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseService extends IBaseService<Course,Long> {
    /**
     * 更新课程基本信息
     * @param courseBaseDto
     */
    public void updateCourse(CourseBaseDto courseBaseDto);
    /**
     * 保存课程基本信息
     * @param courseBaseDto
     * @return
     */
    public int saveCourseBase(CourseBaseDto courseBaseDto) ;
    /**
     * 根据用户Id获取起最新创建的课程
     * @param userId
     * @return
     */
    public Course searchByUserId(int userId);

    /**
     * 根据审核状态获取课程列表
     * @param courseSearchBean
     * @return
     */
    public void findCourseList(CourseConditionBean courseSearchBean);

    /**
     * 删除课程
     * @param courseSearchBean
     */
    public void deleteCourse(CourseSearchBean courseSearchBean);

    /**
     * 审核课程
     * @param course
     */
    public void courseExamine(Course course);

    /**
     * 取消课程审核
     * @param course
     */
    public void cancelCourse(Course course);

    /**
     * 课程审核不通过 审核状态码改为2
     * @param course
     */
    public void courseExamineFail(Course course);

    public  Course scanCourse(int id);

    List<Course> searchCourseByCateId(Long directionId);

    List<Course> findCourseListByIds(Integer directionId,Integer positionId,List industryIds);

    List<Course> findCourseListBy2Ids(Integer directionId,Integer positionId);

    /**
     * 查看是否有高版本存在
     * @param id
     * @return
     */
    List<Course> findHasHigherVersion(Integer id);

    void updateScore();

    /**
     * @Author liuhuan
     * @Description 根据行业id查询课程
     * @Date  2019/08/08
     * @Param [industryId]
     * @return java.util.List<com.kjs.orm.model.Course>
     **/
    List<Course> searchCourseByIndustryId(Long industryId);
    
    
    
    /**
     * 
     * @param directionId
     * @param industryId
     * @param positionId
     * @return
     */
	public Object findByCourses(String directionId, String industryId, String positionId);
	
	/**
	 * @author jijunda
	 * @description 课程排序
	 * @param courseSortDto
	 * @return
	 */
	public Object sortCourse(CourseSortDto courseSortDto);
	 List<Course> searchCourseByPositionId(Integer positionId);
	
	public void orderUpdate(String course);
	
    
	
	
	
	

}