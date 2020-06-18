package com.kjs.orm.mapper;

import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.course.CourseBaseDto;
import com.kjs.common.dto.course.CourseSortDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CategoryDirection;
import com.kjs.orm.model.Course;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@CleanCache(key="com.kjs.orm.mapper.CourseMapper")
public interface CourseMapper extends BaseMapper<Course,Long> {
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
     * 根据发布状态获取课程列表
     * @param publishState
     * @return
     */
    public List<Course> findCourseList(int publishState);

    /**
     * 删除课程
     * @param id
     */
    public void deleteCourse(int id);

    /**
     * 审核课程
     * @param course
     *
     */
    public void courseExamine(Course course);

    /**
     * 取消课程审核
     * @param course
     */
    public void cancelCourse(Course course);

    /**
     * 课程审核不通过
     * @param course
     *
     */
    public void courseExamineFail(Course course);

    List<Course> searchCourseByCateId(@Param("directionId")Long directionId);

    int countCheckDel(@Param("directionId")Integer directionId);

    int countCheckDelPos(@Param("positionId")Integer positionId);

    List<Course> findCourseListByIds(Map map);

    List<Course> findCourseListBy2Ids(Map map);

    List<Course> findHasHigherVersion(Integer id);

    /**
     * @Author liuhuan
     * @Description 根据行业id查询课程
     * @Date  2019/08/08
     * @Param [industryId]
     * @return java.util.List<com.kjs.orm.model.Course>
     **/
    List<Course> searchCourseByIndustryId(Long industryId);
	public List<Course> findByCategory( @Param("positionId") String positionId,@Param("directionId") String directionId, @Param("industryId") String industryId);
	
	
	/**
	 * @author jijunda
	 * @description 设置课程顺序
	 * @param courseSortDto
	 * @return
	 */
	public Object sortCourse(CourseSortDto courseSortDto);
	 List<Course> searchCourseByPositionId(Integer positionId);
	 void orderUpdate(Course course);
	
	
	
	

}