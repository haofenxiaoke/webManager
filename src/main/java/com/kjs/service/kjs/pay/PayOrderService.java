package com.kjs.service.kjs.pay;

import com.github.kevinsawicki.http.HttpRequest;
import com.google.common.collect.Collections2;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ParamUtil;
import com.kjs.common.dto.FinanceStatisticsDTO;
import com.kjs.common.dto.TrackDTO;
import com.kjs.common.utils.MakeOrderNum;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.common.utils.StringUtil;
import com.kjs.common.utils.WebUtil;
import com.kjs.orm.mapper.*;
import com.kjs.orm.model.*;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.pay.spi.IPayOrderService;
import com.kjs.web.serach.kjs.order.PayOrderSearchBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.net.URL;
import java.util.*;
import java.util.regex.Pattern;

import static com.sun.tools.doclets.formats.html.markup.HtmlStyle.title;
import static sun.net.www.protocol.http.HttpURLConnection.userAgent;

/**
 * @author 李恒名
 * @date 2016-6-12
 */
@Service
public class PayOrderService extends BaseService<PayOrder, Long> implements IPayOrderService {

    private static Logger LOGGER = LoggerFactory.getLogger(PayOrderService.class);
    @Resource
    private PayOrderMapper payOrderMapper;
    @Resource
    private UserVipMapper userVipMapper;
    @Resource
    private VipInfoMapper vipInfoMapper;
    @Resource
    private UserVoucherMapper userVoucherMapper;
    @Resource
    private UserStuMapper userStuMapper;
    @Resource
    private PayDetailMapper payDetailMapper;
    @Resource
    private RefundDetailMapper refundDetailMapper;

    @Override
    public PayOrder findRefundInfoById(Long id) {
        return payOrderMapper.findRefundInfoById(id);
    }

    @Override
    public void refund(RefundDetail refundDetail) {
        PayOrder order = payOrderMapper.findById(refundDetail.getOrderId().longValue());
        order.setAuditStatus(PayOrder.REFUND_STATUS_REFUNDING);
        order.setBackPrice(refundDetail.getRefundMoney());
        payOrderMapper.update(order);
        refundDetail.setCtime(new Date());
        refundDetail.setOrderNum(order.getOrderNum());
        refundDetail.setProposerName(ShiroUtils.getSessionUser().getUsername());
        refundDetail.setOrderUsername(userStuMapper.findById(order.getUserId()).getUserid());
        refundDetail.setRefundStatus(1);
        refundDetail.setIsDelete(0);
        refundDetailMapper.save(refundDetail);

    }

    @Override
    public void create(Long vipId, String uid, Long userVoucherId, HttpServletRequest request) {
        VipInfo vipInfo = vipInfoMapper.findById(vipId);

        UserStu stu = userStuMapper.findByUserid(uid);
        String orderNum = buildOrderNum(String.valueOf(vipId), String.valueOf(stu.getId()));
        Date now = new Date();
        //生成订单
        PayOrder order = new PayOrder();
        order.setOrderNum(orderNum);
        order.setProgramId(vipId.intValue());
        order.setProgramName(vipInfo.getDescrible());
        order.setCostPrice((double) vipInfo.getPrice());
        order.setRealpayPrice(0.00);
        order.setIp(WebUtil.getIpAddress(request));
        order.setUserId(stu.getId());
        order.setOrderTime(now);
        order.setCreateTime(now);
        order.setRemark("网站后台");
        order.setDeleted(0);

        //使用优惠券
        UserVoucher userVoucher = userVoucherMapper.findById(userVoucherId);
        userVoucher.setUsed(1);
        userVoucherMapper.update(userVoucher);

        //模拟支付订单
        order.setPayStatus(PayOrder.PAY_STATUS_PAID);
        order.setPayTime(now);
        order.setPayType("5");//优惠券支付
        order.setPayNum(userVoucher.getVoucherNum());
        order.setVoucherNum(userVoucher.getVoucherNum());
        order.setReduceType("1");
        //保存订单
        payOrderMapper.save(order);

        //成为VIP
        UserVip userVip = new UserVip();
        userVip.setUserId(stu.getId().intValue());
        userVip.setAddTime(now);
        userVip.setVipId(vipId.intValue());
        userVip.setOrderId(order.getId().intValue());
        userVip.setVipName(order.getProgramName());
        userVip.setVipName(userVip.getDescrible());

        List<UserVip> vips = userVipMapper.findByUserId(stu.getId());

        //判断是否已存在未过期的VIP,如果有取未到期的VIP截至日期作本次VIP起始时间
        if (!vips.isEmpty() && vips.get(0).getEndDate().after(now)) {
            userVip.setStartDate(vips.get(0).getEndDate());
        } else {
            userVip.setStartDate(now);
        }
        final int months = vipInfo.getDays() / 30;
        userVip.setEndDate(DateUtils.addMonths(userVip.getStartDate(), months));
        userVipMapper.save(userVip);

        //添加支付详情
        PayDetail detail = new PayDetail();
        detail.setUserId(order.getUserId().intValue());
        detail.setOrderId(order.getId().intValue());
        detail.setPayNum(order.getPayNum());
        detail.setMoney(order.getRealpayPrice());
        detail.setCtime(now);
        detail.setPayType("5");
        detail.setPayBank(userVoucher.getVoucherNum());
        payDetailMapper.save(detail);

        LOGGER.info("###订单支付成功###[订单编号：{}  交易流水号：{}]", order.getOrderNum(), order.getPayNum());

    }

    private synchronized String buildOrderNum(String commodityId, String userId) {
        commodityId = commodityId.length() < 4 ? String.format("%04d", Integer.valueOf(commodityId)) : commodityId.substring(commodityId.length() - 4, commodityId.length());
        userId = userId.length() < 4 ? String.format("%04d", Integer.valueOf(userId)) : userId.substring(userId.length() - 4, userId.length());
        return new MakeOrderNum().getOrderNum(commodityId + userId);
    }

    @Override
    public DataTablePageModel buildModelBySearch4Bill(DataTablePageModel search) {
        List<PayOrder> data = payOrderMapper.page4Bill(search);
        if (!data.isEmpty()) {
            long count = payOrderMapper.count4Bill(search);
            search.setRecordsTotal(count);
            search.setRecordsFiltered(count);
            search.setData(data);
        }
        return search;
    }

    @Override
    public DataTablePageModel buildModelBySearch4financeStatistics(PayOrderSearchBean search) {
        List<FinanceStatisticsDTO> data = payOrderMapper.financeStatistics(search);
        search.setData(data);
        return search;
    }

    @Resource
    private UserVisitMapper visitMapper;

    @Override
    public List<TrackDTO> findTrackById(Long id,int type) {
        PayOrder order = payOrderMapper.findById(id);
        List<TrackDTO> trackList = Lists.newArrayList();
        List<UserVisit> visitList = visitMapper.findByGid(order.getSourceGid());

        //去除重复URL
        Map<String, List<UserVisit>> visitMap = Maps.newLinkedHashMap();
        String firstEntryUrl = null;
        if (!CollectionUtils.isEmpty(visitList)) {
            firstEntryUrl = visitList.get(0).getCurrentUrl();
        }
        String domainName = StringUtil.equals(ParamUtil.PRODUCT_ID, "kjs") ? "kuaijishizi" : "shejiniu";
        for (UserVisit visit : visitList) {
            String url = visit.getRefererUrl();
            Date visitTime = visit.getVisitTime();
            Date startDate;
            if(type == 1){
                startDate = order.getPayTime();
            }else if(type == 2){
                startDate = order.getCreateTime();
            }else{
                throw new IllegalArgumentException("参数错误，不支持该type。");
            }

            if (StringUtil.contains(url, domainName) && visitTime.before(startDate) && startDate.getTime() - visitTime.getTime() < 86400000) {//只取本站，支付时间往前推24小时内的轨迹
                if (visitMap.containsKey(url)) {
                    visitMap.get(url).add(visit);
                } else {
                    List<UserVisit> list = Lists.newArrayList();
                    list.add(visit);
                    visitMap.put(visit.getRefererUrl(), list);
                }
            }
        }

        for (String url : visitMap.keySet()) {
            List<UserVisit> userVisits = visitMap.get(url);

            TrackDTO track = new TrackDTO();
            track.setUrl(url);
            track.setTitle(analyzeTitle(url));
            UserVisit firstVisit = userVisits.get(0);
            track.setVisit(firstVisit.getVisitTime());
            track.setFirstEntryUrl(firstEntryUrl);
            long remain = 0;
            if (userVisits.size() > 1) {
                for (UserVisit visit : userVisits) {
                    remain += visit.getStayTime().getTime() - visit.getVisitTime().getTime();
                }
            } else {
                remain = firstVisit.getStayTime().getTime() - firstVisit.getVisitTime().getTime();
            }
            track.setRemain(remain);
            trackList.add(track);
        }

        return trackList;
    }

    @Resource
    private CourseMapper courseMapper;
    @Resource
    private CategoryPositionMapper positionMapper;
    @Resource
    private CourseLiveMapper liveMapper;

    //通过URL分析页面的标题
    private String analyzeTitle(String url) {
        String title = "";
        try {
            if (StringUtils.contains(url, "/course")) {
                if (StringUtils.contains(url, "/detail")) {
                    Course course = courseMapper.findById(getIdByUrl(url));
                    title = "课程详情-" + course.getTitle();
                } else if (StringUtils.contains(url, "/play")) {
                    Course course = courseMapper.findById(getIdByUrl(url));
                    title = "视频播放-" + course.getTitle();
                } else {
                    title = "课程列表";
                }
            } else if (StringUtils.contains(url, "/plan")) {
                if (StringUtils.contains(url, "positionId=")) {
                    CategoryPosition position = positionMapper.findById(getIdByUrl(url));
                    title = "计划确认-" + position.getCategoryDesc();
                } else {
                    title = "定制计划";
                }
            } else if (StringUtils.contains(url, "/order/buy")) {
                title = "收银台";
            } else if (StringUtils.contains(url, "/userCenter")) {
                title = "用户中心";
            } else if (StringUtils.contains(url, "/vip")) {
                title = "开通会员";
            } else if (StringUtils.contains(url, "/live")) {
                if (StringUtils.contains(url, "play")) {
                    CourseLive live = liveMapper.findById(getIdByUrl(url));
                    title = "直播间-" + live.getLiveTitle();
                } else {
                    title = "直播列表";
                }
            } else if (StringUtils.contains(url, "/search")) {
                title = "课程搜索";
            } else if (StringUtils.contains(url, "/help")) {
                title = "帮助中心";
            } else {
                url = StringUtils.contains(url, ".") ? url.substring(url.indexOf(".") + 1) : url;//去除http://www.
                if (!StringUtils.contains(url, "/") || url.indexOf("/") == url.length() - 1) {//eg: abc.com  or abc.com/ is index page.
                    title = "首页";
                } else {
                    title = "其他页面";
                }
            }

        } catch (Exception e) {
            LOGGER.warn("订单来源页面名称解析出现错误", e);
        }

        return title;
    }

    private Long getIdByUrl(String url) {
        String id;
        if (StringUtils.contains(url, "/plan") && StringUtils.contains(url, "positionId=")) {
            id = url.substring(url.lastIndexOf("=") + 1);
        } else {
            url = StringUtils.contains(url, "?") ? url.substring(0, url.indexOf("?")) : url;
            if (url.endsWith("/")) {
                url = url.substring(0, url.length() - 1);
            }
            id = url.substring(url.lastIndexOf("/") + 1);
        }
        return Long.valueOf(id);
    }

    private String getHtmlTitle(String url) {
        String userAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36";
        String accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
        String body = HttpRequest.get(url).userAgent(userAgent).accept(accept).body();
        return Jsoup.parse(body).head().select("title").html();
    }

    private String getHtmlBody(String url) {
        String userAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36";
        String accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
        String body = HttpRequest.get(url).userAgent(userAgent).accept(accept).body();
        return body;
    }

}
