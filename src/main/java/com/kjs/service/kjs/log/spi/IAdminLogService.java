package com.kjs.service.kjs.log.spi;
import com.kjs.orm.model.AdminLog;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.log.AdminLogSerachBean;

/**
 * Service Interface:ClassComment
 * @author duia_builder
 * @date 2016-1-20
 */
public interface IAdminLogService extends IBaseService<AdminLog,Long> {
    //根据条件获取日志的数据(分页)
    void findAdminLogPage(AdminLogSerachBean serachBean);
}