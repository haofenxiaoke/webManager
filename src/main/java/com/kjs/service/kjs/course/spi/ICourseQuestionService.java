package com.kjs.service.kjs.course.spi;

import com.kjs.orm.model.CourseQuestion;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.common.dto.user.ExportCsvForAnswerDto;
import com.kjs.web.serach.kjs.operation.QuestionSearchBean;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;

import java.util.List;
import java.util.Map;

/**
 * Service Interface:CourseQuestion
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ICourseQuestionService extends IBaseService<CourseQuestion,Long> {
    void findPage(UserManagerSerachBean serachBean);

    List<Map> serachAnswersById(Map paramMap);

    List<ExportCsvForAnswerDto> exportCsvAnswers(QuestionSearchBean search);

    /**
     * 提问详情，包含问题回答列表
     * @param id
     * @author 李恒名
     * @date 2016-06-20
     */
    CourseQuestion detail(Long id);

    /**
     * 获得统计信息 当日新增问题数，未回复问题数
     * @author 李恒名
     * @date 2016-06-20
     */
    Map<String,Long> findCountInfo();

}