package com.kjs.orm.mapper;

import com.kjs.common.bean.PageModel;
import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.course.CourseQuestionDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.CourseQuestion;
import com.kjs.common.dto.user.ExportCsvForAnswerDto;
import com.kjs.web.serach.kjs.operation.QuestionSearchBean;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
@CleanCache(key="com.kjs.orm.mapper.CourseQuestionMapper")
public interface CourseQuestionMapper extends BaseMapper<CourseQuestion,Long> {
    List<Map> pageInfo(UserManagerSerachBean serachBean);

    Long countInfo(UserManagerSerachBean serachBean);

    Map getQuestions(Map paramMap);

    /**
     * @param pageModel
     * @return count
     * @author 李恒名
     * @date 2016-06-20
     */
    Long count4DataTable(PageModel pageModel);

    /** 未回复问题数
     * @return count
     * @author 李恒名
     * @date 2016-06-20
     */
    Long noReplyCount();

    /**今日新增问题数
     * @return count
     * @author 李恒名
     * @date 2016-06-20
     */
    Long todayAddCount();

    /**
     * 问题列表列表
     * @param pageModel
     * @return 提问列表
     * @author 李恒名
     * @date 2016-06-20
     */
    List<CourseQuestionDto> page4DataTable(PageModel pageModel);

    /**
     * @param id
     * @return CourseQuestion
     * @author 李恒名
     * @date 2016-06-20
     */
    CourseQuestion detail(Long id);

    /**
     * 查询答疑导出数据
     * @return
     */
    List<ExportCsvForAnswerDto> exportCsvForAnswer(QuestionSearchBean search);
}