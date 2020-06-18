package com.kjs.web.controller.kjs.wechat;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.dto.wechat.WechatDataDto;
import com.kjs.common.dto.wechat.WechatDto;
import com.kjs.service.kjs.wechat.spi.IWechatService;

/**
 * 
 * @author 嵇俊达
 * @date 2020.6.17
 * @Description 微信数据controller
 *
 */
@Controller
@RequestMapping("/wechatData")
public class WechatDataController {
	
	@Resource
    private IWechatService wechatService;
	
	/**
	 * 跳转到微信数据页面
	 * @author 嵇俊达
	 * @date 2020.6.17
	 * @param model
	 * @param articleSearchBean
	 * 
	 */
	@PermissionAnn(menuCode = "wechatData", msg = "你没有进入微信数据页面的权限!")
    @RequestMapping(value = "/wechat_data")
    public String createWechat(Model model) {
        return "wechat/wechat_data";
    }
	
	/**
	 * 返回微信数据列表
	 * @author 嵇俊达
	 * @date 2020.6.17
	 * @param request
	 * @param articleBase
	 * 
	 */
	
    @ResponseBody
    @RequestMapping(value = "/list")
    public ResponseJsonModel submitWechat(HttpServletRequest request, String startTime,String endTime ,String dimesion,Integer type) {
        List<WechatDataDto> wechatDataList=wechatService.findList(startTime,endTime ,dimesion,type);
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        responseJsonModel.setResult(wechatDataList);
        return responseJsonModel;
	}

}
