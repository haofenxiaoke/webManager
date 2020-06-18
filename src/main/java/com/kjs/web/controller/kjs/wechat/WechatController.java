package com.kjs.web.controller.kjs.wechat;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.dto.goods.GoodsTest;
import com.kjs.common.dto.wechat.WechatDto;
import com.kjs.common.dto.wechat.WechatTypeDto;
import com.kjs.common.utils.DateUtils;
import com.kjs.orm.model.Goods;
import com.kjs.orm.model.Wechat;
import com.kjs.service.kjs.article.spi.IArticleService;
import com.kjs.service.kjs.wechat.spi.IWechatService;
import com.kjs.web.controller.kjs.article.ArticleCreateController;
import com.kjs.web.serach.kjs.goods.GoodsConditionBean;

/**
 * 
 * @author 嵇俊达
 * @date 2020.6.9
 * @Description 微信管理controller
 *
 */
@Controller
@RequestMapping("/wechat")
public class WechatController {
	private final static Logger logger = LoggerFactory.getLogger(ArticleCreateController.class);
	
	@Resource
    private IWechatService wechatService;
	
	
	/**
	 * 跳转到创建微信页面
	 * @author 嵇俊达
	 * @date 2020.6.9
	 * @param model
	 * @param articleSearchBean
	 * 
	 */
	@PermissionAnn(menuCode = "addwechat", msg = "你没有进入创建微信页面的权限!")
    @RequestMapping(value = "/wechat_create")
    public String createWechat(Model model, WechatDto wechatDto) {
        return "wechat/wechat_create";
    }
	
	
	/**
	 * 点击提交数据
	 * @author 嵇俊达
	 * @date 2020.6.9
	 * @param request
	 * @param articleBase
	 * 
	 */
	@Transactional
    @ResponseBody
    @RequestMapping(value = "/submitWechat")
    public ResponseJsonModel submitWechat(HttpServletRequest request, String wechatBase) {
        wechatService.saveWechatBase(wechatBase);
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        return responseJsonModel;
	}
	
	
	 /**
     * 文章编辑按钮返回微信内容
     * 
	 * @author 嵇俊达
	 * @date 2020.6.9
     * @param model
     * @param courseSearchBean
     * @return
     */
	   @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "编辑")
	   @PermissionAnn(menuCode = "addwechat",operCode = "write",msg = "你没有编辑微信的权限!")
	   @RequestMapping(value = "/scanWechat")
	   @ResponseBody
	   public ResponseJsonModel scanWechat(ModelAndView model, Integer id,HttpServletRequest request){
	       ResponseJsonModel responseJsonModel = new ResponseJsonModel();
	       WechatDto wechat =wechatService.scanWechat(id);
	       responseJsonModel.setResult(wechat);
	       return responseJsonModel;
	   }
   
  
   /**
    * 编辑，点击提交，保存编辑后的数据
    * @author 嵇俊达
    * @param request
    * @param response
    * @return
    * 2020.6.9
    */
   @Transactional
   @RequestMapping(value = "/ReSubmit")
   @ResponseBody
   public ResponseJsonModel updateWechat(HttpServletRequest request, String wechatBase/*, String articleText*/, Integer Id) {
       wechatService.updateWechat(wechatBase);
       ResponseJsonModel responseJsonModel = new ResponseJsonModel();
       responseJsonModel.setCode("200");
       return responseJsonModel;
	}

    
//    /**
//     * 跳转到微信列表页面
//     * @author 嵇俊达
//	 * @date 2020.6.9
//     * @param request
//     * @param response
//     * @return
//     */
//    @PermissionAnn(menuCode = "wechat",msg = "你没有进入管理微信页面的权限!")
//    @RequestMapping(value="/manager")
//    public String managerWechat(HttpServletRequest request, HttpServletResponse response){
//      return "/wechat/wechat_exam";
//    }


    /**
     * 删除微信
     * @author 嵇俊达
	 * @date 2020.6.9
     * @param model
     * @param Integer id,Integer deleted
     * @return
     */
    @Transactional
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "删除")
    @PermissionAnn(menuCode = "addwechat",operCode = "deleted",msg = "你没有删除微信的权限!")
    @RequestMapping(value = "/deleteWechat")
    @ResponseBody
    public ResponseJsonModel deleteWechat(Model model,Integer id,HttpServletRequest request){
    	wechatService.deleteWechat(id);
    	ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setMsg("删除成功");
        return responseJsonModel;
    }
    
	
    /**
     * 获取微信列表
     * @author 嵇俊达
	 * @date 2020.4.15
     * @return
     */
//    @PermissionAnn(menuCode = "wechat",msg = "你没有进入获取商品列表的权限!")
    @RequestMapping(value = "/List")
    @ResponseBody
    public ResponseJsonModel searchWechatList(){
    	List<WechatDto> wechatmanage=wechatService.findGoodsList();
    	
    	ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        responseJsonModel.setResult(wechatmanage);
        return responseJsonModel;
    }

}
