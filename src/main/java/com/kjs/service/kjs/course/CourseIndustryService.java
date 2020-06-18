package com.kjs.service.kjs.course;

import com.kjs.orm.mapper.CategoryIndustryMapper;
import com.kjs.orm.mapper.CourseIndustryMapper;
import com.kjs.orm.model.CourseIndustry;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.course.spi.ICourseIndustryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service Implementation:CourseIndustry
 * @author duia_builder
 * @date 2016-5-23
 */
@Service
public class CourseIndustryService extends BaseService<CourseIndustry,Long> implements ICourseIndustryService {

    @Autowired
    private CourseIndustryMapper courseIndustryDao;
    @Autowired
    private CategoryIndustryMapper categoryIndustryDao;

    @Override
    public void saveCourseIndustry(CourseIndustry courseIndustry) {
           courseIndustryDao.save(courseIndustry);
    }

    @Override
    public void deleteCourseIndustry(Integer courseId) {
        courseIndustryDao.deleteCourseIndustry( courseId);
    }

    @Override
    public Boolean countCheckDelInd(Integer industryId) {
        Boolean flag = false;
        if(this.courseIndustryDao.countCheckDelInd(industryId) > 0 ){
            flag =true;
        }
        return flag;
    }
}
