package com.kjs.service.kjs.log;


import com.kjs.orm.mapper.AdminLogMapper;
import com.kjs.common.dto.log.AdminLogDto;
import com.kjs.orm.model.AdminLog;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.log.spi.IAdminLogService;
import com.kjs.web.serach.kjs.log.AdminLogSerachBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * 日志管理业务对象
 * Service Implementation:ClassComment
 * @author duia_builder
 * @date 2016-1-20
 */
@Transactional(rollbackFor=Exception.class)
@Service
public class AdminLogService extends BaseService<AdminLog,Long> implements IAdminLogService {
    @Resource
    private AdminLogMapper adminLogDao;

    private final static Logger logger = LoggerFactory.getLogger(AdminLogService.class);

    /**
     * 查询操作日志列表
     *
     * @param serachBean
     */
    @Override
    public void findAdminLogPage(AdminLogSerachBean serachBean) {
        List<AdminLogDto> adminLogs = adminLogDao.pageDto(serachBean);
        if (!CollectionUtils.isEmpty(adminLogs)) {
            long count = this.iBaseDao.count(serachBean);
            serachBean.setRecordsTotal(count);
            serachBean.setRecordsFiltered(count);
            serachBean.setData(adminLogs);
        }
    }

}
