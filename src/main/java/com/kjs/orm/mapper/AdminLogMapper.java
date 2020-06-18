package com.kjs.orm.mapper;

import com.kjs.common.dto.log.AdminLogDto;
import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.AdminLog;
import com.kjs.web.serach.kjs.log.AdminLogSerachBean;

import java.util.List;

public interface AdminLogMapper extends BaseMapper<AdminLog,Long> {
    List<AdminLogDto> pageDto(AdminLogSerachBean serachBean);
}