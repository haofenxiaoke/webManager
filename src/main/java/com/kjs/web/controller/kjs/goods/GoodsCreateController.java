package com.kjs.web.controller.kjs.goods;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.taglibs.standard.tag.el.fmt.FormatDateTag;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kjs.common.bean.DataTablePageModel;
import com.kjs.common.bean.PicUploadResult;
import com.kjs.common.bean.ResponseJsonModel;
import com.kjs.common.bean.annotation.AdminLogAnn;
import com.kjs.common.bean.annotation.PermissionAnn;
import com.kjs.common.bean.enums.OperLevel;
import com.kjs.common.bean.enums.OperType;
import com.kjs.common.dto.course.ArticleBaseDto;
import com.kjs.common.dto.goods.GoodsSonDto;
import com.kjs.common.dto.goods.GoodsTest;
import com.kjs.common.dto.goods.RemainDto;
import com.kjs.common.utils.DateUtils;
import com.kjs.orm.model.Goods;
import com.kjs.service.kjs.goods.spi.IGoodsService;

import com.kjs.web.serach.kjs.article.ArticleConditionBean;
import com.kjs.web.serach.kjs.article.ArticleSearchBean;
import com.kjs.web.serach.kjs.goods.GoodsConditionBean;




/**
 * 
 * @author 嵇俊达
 * @date 2020.5.6
 * @Description 商品管理controller
 *
 */
@Controller
@RequestMapping("/goods")
public class GoodsCreateController {
	@Resource
    private IGoodsService goodsService;
	
	
	/**
	 * 跳转到创建商品页面
	 * @author 嵇俊达
	 * @date 2020.5.6
	 * @param model
	 * @param Goods
	 * 
	 */
	@PermissionAnn(menuCode = "addGoods", msg = "你没有进入创建商品页面的权限!")
    @RequestMapping(value = "/create")
    public String createArticle(Model model, Goods goods) {
        return "Goods/Goods_create";
    }
	

	/**
	 * 点击提交数据
	 * @author 嵇俊达
	 * @date 2020.5.6
	 * @param request
	 * @param articleBase
	 * 
	 */
	@Transactional
    @ResponseBody
    @RequestMapping(value = "/submitGoods")
    public ResponseJsonModel submitGoods(HttpServletRequest request,/*List<Integer> idList,*/ String goodsBase) {
	
		Gson gson = new GsonBuilder().create();
        Goods goods = gson.fromJson(goodsBase, Goods.class);   

      //创建商品日期
        if (goods.getCreateTime() == null || goods.getCreateTime().equals("")) {
        	goods.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        }
        goods.setDeleted(0);
        
        //子商品
//        GoodsSonDto goodsSonDto=new GoodsSonDto();
//        goodsService.saveGoodsSon(idList);
//        for(Integer id :idList){
      
//			goods.setSon(goods.getSon());
//		}
		System.out.println("~~~~~~~~"+goods);
        goodsService.savegoodsBase(goods);
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        return responseJsonModel;
	}
	
	
	/**
	 * 跳转到商品管理页面
	 * @author 嵇俊达
	 * @date 2020.5.12
	 * @param model
	 * @param Goods
	 * 
	 */
	@PermissionAnn(menuCode = "GoodsManage", msg = "你没有进入商品管理页面的权限!")
    @RequestMapping(value = "/manage")
    public String articleManage(Model model, Goods goods) {
        return "Goods/Goods_manage";
    }
	
	
	/**
     * 获取商品列表
     * @author 嵇俊达
	 * @date 2020.5.12
     * @return
     */
//    @PermissionAnn(menuCode = "goods",msg = "你没有进入获取商品列表的权限!")
//    @RequestMapping(value = "/list")
//    @ResponseBody
//    public DataTablePageModel searchGoodsList(GoodsConditionBean goodsConditionBean){
//      
//        goodsService.findGoodsList(goodsConditionBean);
//        return goodsConditionBean;
//    } 
//    @PermissionAnn(menuCode = "GoodsManage",operCode="list",msg = "你没有进入获取商品列表的权限!")
    @RequestMapping(value = "/List")
    @ResponseBody
    public ResponseJsonModel testGoods(GoodsTest goodsTest){
    	List<GoodsConditionBean> goodsmanage=goodsService.findGoodsList(goodsTest);
    	
    	ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        responseJsonModel.setResult(goodsmanage);
        return responseJsonModel;
    }
	
    /**
     * 上架下架商品
     * @author 嵇俊达
	 * @date 2020.5.12
     * @param model
     * @param id
     * @return
     */
    @Transactional
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "上架下架")
    @PermissionAnn(menuCode = "GoodsManage",operCode = "deleted",msg = "你没有上下架商品的权限!")
    @RequestMapping(value = "/deleteGoods")
    @ResponseBody
    public ResponseJsonModel deleteGoods(Model model,Integer id,Integer deleted,HttpServletRequest request){
    	goodsService.deleteGoods(id,deleted);
    	ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setMsg("下架成功");
        return responseJsonModel;
    }
    
    
    /**
     * 商品编辑按钮返回商品内容
     * 
	 * @author 嵇俊达
	 * @date 2020..5.12
     * @param model
     * @param courseSearchBean
     * @return
     */
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "编辑商品")
   @PermissionAnn(menuCode = "GoodsManage",operCode = "write",msg = "你没有编辑商品的权限!")
   @RequestMapping(value = "/scanGoods")
   @ResponseBody
   public ResponseJsonModel scanGoods(ModelAndView model, Integer id,HttpServletRequest request){
       ResponseJsonModel responseJsonModel = new ResponseJsonModel();
//       responseJsonModel.setResult( goodsService.scanGoods(id));
       Goods goods =goodsService.scanGoods(id);
//       responseJsonModel.setCode("200");
       responseJsonModel.setResult(goods);
       return responseJsonModel;
   }
   
   
   
   /**
    * 编辑商品，点击提交，保存编辑后的数据
    * @author 嵇俊达
    * @param request
    * @param response
    * @return
    */
    
   @Transactional
   @RequestMapping(value = "/ReSubmit")
   @ResponseBody
   public ResponseJsonModel updateGoods(HttpServletRequest request, String goodsBase/*, String articleText*/, Integer Id) {
		
		Gson gson = new GsonBuilder().create();
		Goods goods = gson.fromJson(goodsBase, Goods.class);   
        goods.setDeleted(0);
        goodsService.updateGoodsBase(goods);
	    ResponseJsonModel responseJsonModel = new ResponseJsonModel();
	    responseJsonModel.setCode("200");
	    return responseJsonModel;
	}
   
   /**
    * 点击添加按钮，添加库存
    */
   @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "添加商品库存")
   @PermissionAnn(menuCode = "GoodsManage",operCode = "addAdmin",msg = "你没有添加库存的权限!")
   @Transactional
   @RequestMapping(value = "/addRemain")
   @ResponseBody
   public ResponseJsonModel addRemain(HttpServletRequest request,Integer id,Integer newRemain) {
		
        RemainDto remain=new RemainDto();
        goodsService.addRemain(id,newRemain);
        remain.setRemain(newRemain);
        
        System.out.println(remain.getRemain());
	    ResponseJsonModel responseJsonModel = new ResponseJsonModel();
	    responseJsonModel.setResult(remain.getRemain());
	    return responseJsonModel;
	}

}
