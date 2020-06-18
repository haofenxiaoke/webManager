package com.kjs.service.kjs.system.spi;

import com.kjs.orm.model.SysFeedback;
import com.kjs.service.core.spi.IBaseService;

/**
 * Service Interface:SysFeedback
 * @author duia_builder
 * @date 2016-5-23
 */
public interface ISysFeedbackService extends IBaseService<SysFeedback,Long> {

    /**
     * 回复意见
     * @param id  意见id
     * @param content 回复内容
     * @author 李恒名
     * @date 2016年6月15日11:44:21
     */
    void reply(Long id,String content);

}

