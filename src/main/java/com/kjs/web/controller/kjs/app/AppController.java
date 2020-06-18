package com.kjs.web.controller.kjs.app;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.AppCarousel;
import com.kjs.orm.model.AppNotice;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.service.PushService;
import com.kjs.service.kjs.app.AppCarouselService;
import com.kjs.service.kjs.app.NoticeService;
import com.kjs.web.serach.kjs.app.NoticeSearchBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by Administrator on 2016/12/22 0022.
 */
@Controller
@RequestMapping("/app")
public class AppController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Resource
    private NoticeService noticeService;
    @Resource
    private AppCarouselService appCarouselService;
    @Value("${app.push.topic.notice}")
    private String topic;

    @PermissionAnn(menuCode = "appNotice", operCode = "view", msg = "你没有通知发送页面的查询权限!")
    @RequestMapping("/notice")
    public String notice() {
        return "app/notice";
    }

    @PermissionAnn(menuCode = "appNotice", operCode = "save", msg = "你没有发送通知的查询权限!")
    @AdminLogAnn(operType = OperType.MSG, operLevel = OperLevel.NORM, operDescribe = "通知发送")
    @RequestMapping("/notice/send")
    @ResponseBody
    public ResponseJsonModel sendNotice(final AppNotice appNotice) throws IOException {
        AuthorityUsers user = ShiroUtils.getSessionUser();
        appNotice.setCreateTime(new Date());
        appNotice.setUserId(Integer.valueOf(user.getId().toString()));
        noticeService.sendNotice(appNotice);

        final PushService pushService = new PushService();
        Map<String, Object> data = Maps.newLinkedHashMap();
        data.put("title",appNotice.getTitle());
        data.put("url",appNotice.getContent());
        data.put("noticeId",appNotice.getId());
        final String message = JSONObject.toJSONString(data);


        //IOS APN 附件参数
        Map<String, Object> aps = Maps.newLinkedHashMap();
        aps.put("alert", appNotice.getTitle());
        aps.put("badge", 1);
        aps.put("sound", "bingbong.aiff");
        aps.put("url", appNotice.getContent());
        aps.put("noticeId", appNotice.getId());

        Map<String, Object> apn_json = Maps.newLinkedHashMap();
        apn_json.put("aps", aps);

        final Map<String, Object> opts =  Maps.newLinkedHashMap();
        opts.put("apn_json", apn_json);
        if (appNotice.getType() == 0) {
            pushService.publishPush(topic, message, opts);
        } else {
            Timer timer = new Timer(true);
            TimerTask task = new TimerTask() {
                public void run() {
                    pushService.publishPush(topic, message, opts);
                }
            };
            //以下是调度task的方法：
            timer.schedule(task, appNotice.getSendTime());
        }
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    @PermissionAnn(menuCode = "appNotice", operCode = "find", msg = "你没有查看通知列表的权限!")
    @RequestMapping("/notice/list")
    @ResponseBody
    public DataTablePageModel noticeList(NoticeSearchBean searchBean) {
        noticeService.findNoticeList(searchBean);
        return searchBean;
    }

    /**
     * 通知详情接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appNotice", operCode = "find", msg = "你没有查看通知详情的权限!")
    @RequestMapping("/notice/detail")
    @ResponseBody
    public ResponseJsonModel detail(Long id) {
        AppNotice notice = noticeService.findById(id);
        ResponseJsonModel model = new ResponseJsonModel();
        model.setResult(notice);
        return model;
    }

    /**
     * 删除消息接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appNotice", operCode = "delete", msg = "你没有删除通知的权限!")
    @AdminLogAnn(operType = OperType.MSG, operLevel = OperLevel.NORM, operDescribe = "通知删除")
    @RequestMapping("/notice/delete")
    @ResponseBody
    public ResponseJsonModel delete(Long id) {
        noticeService.deleteByIds(new Long[]{id});
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * app轮播图页面跳转接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appCarousel", operCode = "find", msg = "你没有查看app轮播图页面的权限!")
    @RequestMapping("/carousel")
    public String appCarousel(Model model) {
        model.addAttribute("appCarousel", appCarouselService.findAll());
        return "app/appCarousel";
    }

    /**
     * app轮播图保存接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appCarousel", operCode = "save", msg = "你没有保存app轮播图的权限!")
    @AdminLogAnn(operType = OperType.MSG, operLevel = OperLevel.NORM, operDescribe = "保存app轮播图")
    @RequestMapping("/carousel/save")
    @ResponseBody
    public ResponseJsonModel saveCarousel(AppCarousel appCarousel) {
        AuthorityUsers user = ShiroUtils.getSessionUser();
        appCarousel.setCreateUserid(Integer.parseInt(user.getId().toString()));
        appCarousel.setCreateTime(new Date());
        String hrefUrl = appCarousel.getHrefUrl();
        Integer index = hrefUrl.indexOf(",");
        Integer lastIndex = hrefUrl.length();
        if(appCarousel.getType() == 1){
            hrefUrl = hrefUrl.substring(0,index);
        }else{
            hrefUrl = hrefUrl.substring(index+1,lastIndex);
        }
        appCarousel.setHrefUrl(hrefUrl);
        appCarouselService.save(appCarousel);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * app轮播图更新接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appCarousel", operCode = "save", msg = "你没有修改app轮播图的权限!")
    @AdminLogAnn(operType = OperType.MSG, operLevel = OperLevel.NORM, operDescribe = "修改app轮播图")
    @RequestMapping("/carousel/update")
    @ResponseBody
    public ResponseJsonModel updateCarousel(AppCarousel appCarousel) {
        AuthorityUsers user = ShiroUtils.getSessionUser();
        appCarousel.setLastUpdateUserid(Integer.parseInt(user.getId().toString()));
        appCarousel.setLastUpdateTime(new Date());

        String hrefUrl = appCarousel.getHrefUrl();
        Integer index = hrefUrl.indexOf(",");
        Integer lastIndex = hrefUrl.length();

        if(appCarousel.getType() == 1){
            hrefUrl = hrefUrl.substring(0,index);
        }else{
            hrefUrl = hrefUrl.substring(index+1,lastIndex);
        }

        appCarousel.setHrefUrl(hrefUrl);

        appCarouselService.update(appCarousel);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }

    /**
     * app轮播图删除接口
     *
     * @return model
     * @author
     * @date 2016年6月15日
     */
    @PermissionAnn(menuCode = "appCarousel", operCode = "delete", msg = "你没有删除app轮播图的权限!")
    @AdminLogAnn(operType = OperType.MSG, operLevel = OperLevel.NORM, operDescribe = "删除app轮播图")
    @RequestMapping("/carousel/delete")
    @ResponseBody
    public ResponseJsonModel deleteCarousel(Integer id) {
        Long[] ids = {Long.parseLong(id + "")};

        appCarouselService.deleteByIds(ids);
        ResponseJsonModel model = new ResponseJsonModel();
        return model;
    }
}
