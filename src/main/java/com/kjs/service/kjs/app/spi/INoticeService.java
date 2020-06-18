package com.kjs.service.kjs.app.spi;

import com.kjs.orm.model.AppNotice;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.app.NoticeSearchBean;

/**
 * Created by Administrator on 2016/12/26 0026.
 */
public interface INoticeService extends IBaseService<AppNotice,Long> {
    public void sendNotice(AppNotice appNotice);
    public void findNoticeList(NoticeSearchBean searchBean);
}
