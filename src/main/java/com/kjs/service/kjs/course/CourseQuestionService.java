package com.kjs.service.kjs.course;

import com.google.common.collect.Maps;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.dto.course.CourseQuestionDto;
import com.kjs.common.utils.StringUtil;
import com.kjs.orm.mapper.CourseQuestionMapper;
import com.kjs.orm.mapper.CourseQuestionReplyMapper;
import com.kjs.orm.model.CourseQuestion;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseQuestionService;
import com.kjs.common.dto.user.ExportCsvForAnswerDto;
import com.kjs.web.serach.kjs.operation.QuestionSearchBean;
import com.kjs.web.serach.kjs.user.UserManagerSerachBean;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * Service Implementation:CourseQuestion
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseQuestionService extends BaseService<CourseQuestion,Long> implements ICourseQuestionService {
    @Resource
    private CourseQuestionMapper courseQuestionDao;
    @Resource
    private CourseQuestionReplyMapper courseQuestionReplyDao;

    @Override
    public List<Map> serachAnswersById(Map paramMap) {
        List mapList = new ArrayList<>();
        //查询问题信息
        mapList.add(this.courseQuestionDao.getQuestions(paramMap));
        //查询回复新信息
        mapList = this.courseQuestionReplyDao.getQuestionReply(paramMap);

        return mapList;
    }

    @Override
    public CourseQuestion detail(Long id) {
        return courseQuestionDao.detail(id);
    }

    @Override
    public Map<String, Long> findCountInfo() {
        Map<String, Long> info = Maps.newHashMap();
        info.put("noReplyCount",courseQuestionDao.noReplyCount());
        info.put("todayAddCount",courseQuestionDao.todayAddCount());
        return info;
    }

    @Override
    public void findPage(UserManagerSerachBean serachBean) {
        List<Map> list = this.courseQuestionDao.pageInfo(serachBean);
        if(!CollectionUtils.isEmpty(list))
        {
            long count = this.courseQuestionDao.countInfo(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(list);
        }
    }
    @Override
    public DataTablePageModel buildModelBySearch(DataTablePageModel search) {
        List<CourseQuestionDto> data = courseQuestionDao.page4DataTable(search);
        if(!data.isEmpty()){
            Long count = courseQuestionDao.count4DataTable(search);
            search.setRecordsTotal(count);
            search.setRecordsFiltered( count);
            search.setData(data);
        }
        return search;
    }

    @Override
    public List<ExportCsvForAnswerDto> exportCsvAnswers(QuestionSearchBean search) {
        List<ExportCsvForAnswerDto> dtoList = new ArrayList<>();
        List<ExportCsvForAnswerDto> mapList = this.courseQuestionDao.exportCsvForAnswer(search);
        if(!CollectionUtils.isEmpty(mapList))
        {
            Map<Integer,StringBuffer> contentMap = new HashMap<Integer,StringBuffer>();
            for(ExportCsvForAnswerDto dto : mapList){
                StringBuffer sbf = new StringBuffer();
                Integer qid = dto.getId();
                String answer = StringUtil.isEmpty(dto.getReplyContent()) ? "" : (dto.getReplyTime()+":"+dto.getReplyContent()+"\r\n");
                if(contentMap.containsKey(qid)){
                    sbf = contentMap.get(qid);
                    sbf.append(answer);
                    contentMap.put(qid,sbf);
                }else{
                    sbf.append(answer);
                    contentMap.put(qid,sbf);
                }
            }

            //替换
            List tempList = new ArrayList();

            for(ExportCsvForAnswerDto dto : mapList){
                if(!tempList.contains(dto.getId())){
                   String answers = contentMap.get(dto.getId()).length() == 0 ? "" :
                            "\""+contentMap.get(dto.getId()).toString().replaceAll("\"","“")+"\"";
                    dto.setAnswers(answers);
                    dtoList.add(dto);
                    tempList.add(dto.getId());
                }
            }
        }

        return dtoList;
    }
}
