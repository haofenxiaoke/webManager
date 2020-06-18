package com.kjs.service.kjs.app;

import com.kjs.orm.mapper.AppNoticeMapper;
import com.kjs.orm.model.AppNotice;
import com.kjs.service.core.BaseService;

import com.kjs.service.kjs.app.spi.INoticeService;
import com.kjs.web.serach.kjs.app.NoticeSearchBean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Date;

/**
 * Created by Administrator on 2016/12/26 0026.
 */
@Service
public class NoticeService extends BaseService<AppNotice,Long> implements INoticeService{
     @Autowired
    private AppNoticeMapper appNoticeMapper;

    @Override
    public void sendNotice(AppNotice appNotice) {
        appNotice.setCreateTime(new Date());
        appNoticeMapper.save(appNotice);
    }

    @Override
    public void findNoticeList(NoticeSearchBean searchBean) {
        List<AppNotice> noticeList=appNoticeMapper.page(searchBean);
        if(!CollectionUtils.isEmpty(noticeList))
        {
            long count = this.appNoticeMapper.count(searchBean);
            searchBean.setRecordsTotal(count);
            searchBean.setRecordsFiltered(count);
            searchBean.setData(noticeList);
        }
    }
}
