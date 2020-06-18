package com.kjs.web.controller.kjs.article;

import java.util.ArrayList;
import java.util.Date;
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
import com.kjs.common.constant.SessionConstant;
import com.kjs.common.dto.course.ArticleBaseDto;
import com.kjs.common.utils.DateUtils;
import com.kjs.common.utils.ShiroUtils;
import com.kjs.orm.model.ArticleText;
import com.kjs.orm.model.AuthorityUsers;
import com.kjs.orm.model.Course;
import com.kjs.service.kjs.article.articleService;
import com.kjs.service.kjs.article.spi.IArticleService;
import com.kjs.service.kjs.course.spi.ICourseService;
import com.kjs.web.serach.kjs.article.ArticleConditionBean;
import com.kjs.web.serach.kjs.article.ArticleSearchBean;
import com.kjs.web.serach.kjs.course.CourseConditionBean;
import com.kjs.web.serach.kjs.course.CourseSearchBean;
import com.kjs.orm.model.Article;

/**
 * 
 * @author 嵇俊达
 * @date 2020.4.15
 * @Description 文章管理controller
 *
 */
@Controller
@RequestMapping("/article")
public class ArticleCreateController {
	private final static Logger logger = LoggerFactory.getLogger(ArticleCreateController.class);
	
	@Resource
    private IArticleService articleService;
	@Resource
    private ICourseService courseService;
	
	/**
	 * 跳转到创建文章页面
	 * @author 嵇俊达
	 * @date 2020.4.15
	 * @param model
	 * @param articleSearchBean
	 * 
	 */
	@PermissionAnn(menuCode = "addArticle", msg = "你没有进入创建文章页面的权限!")
    @RequestMapping(value = "/create")
    public String createArticle(Model model, ArticleSearchBean articleSearchBean) {
        return "Article/Article_create";
    }
	
	
	/**
	 * 点击提交数据
	 * @author 嵇俊达
	 * @date 2020.4.15
	 * @param request
	 * @param articleBase
	 * 
	 */
	@Transactional
    @ResponseBody
    @RequestMapping(value = "/submitArticle")
    public ResponseJsonModel submitArticle(HttpServletRequest request, String articleBase) {
		System.out.println(articleBase);
		System.out.println("---------------------------------------------------------------------------------------");
		Gson gson = new GsonBuilder().create();
        ArticleBaseDto articleBaseDto = gson.fromJson(articleBase, ArticleBaseDto.class);    
      //创建文章日期
        if (articleBaseDto.getCreateTime() == null || articleBaseDto.getCreateTime().equals("")) {
        	articleBaseDto.setCreateTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        }
        articleBaseDto.setSaveTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
        articleBaseDto.setDeleted(0);
        articleBaseDto.setBody(articleBaseDto.getBody());
//        articleBaseDto.setAuthorName(articleBaseDto.getAuthorName());
        articleBaseDto.setViewsNumber(articleBaseDto.getViewsNumber());
//        articleBaseDto.setTitle(title);       
        articleService.saveArticleBase(articleBaseDto);
        ResponseJsonModel responseJsonModel = new ResponseJsonModel();
        responseJsonModel.setCode("200");
        return responseJsonModel;
	}
	
	
	 /**
     * 文章编辑按钮返回文章内容
     * 
	 * @author 嵇俊达
	 * @date 2020.4.15
     * @param model
     * @param courseSearchBean
     * @return
     */
   @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "编辑文章")
   @PermissionAnn(menuCode = "article",operCode = "write",msg = "你没有编辑文章的权限!")
   @RequestMapping(value = "/scanArticle/{id}")
   @ResponseBody
   public ResponseJsonModel scanArticle(ModelAndView model,ArticleSearchBean articleSearchBean,@PathVariable Integer id,HttpServletRequest request){
       ResponseJsonModel responseJsonModel = new ResponseJsonModel();
       responseJsonModel.setResult( articleService.scanArticle(id));
//       responseJsonModel.setCode("200");
       return responseJsonModel;
   }
   
  
   /**
    * 编辑文章，点击提交，保存编辑后的数据
    * @author 嵇俊达
    * @param request
    * @param response
    * @return
    */
   @Transactional
   @RequestMapping(value = "/ReSubmit")
   @ResponseBody
   public ResponseJsonModel updateArticle(HttpServletRequest request, String articleBase/*, String articleText*/, Integer Id) {
		System.out.println(articleBase);
		System.out.println("---------------------------------------------------------------------------------------");
		Gson gson = new GsonBuilder().create();

       ArticleBaseDto articleBaseDto = gson.fromJson(articleBase, ArticleBaseDto.class);
    
       articleBaseDto.setSaveTime(DateUtils.stringtoDate(DateUtils.getCurrDate("yyyy-MM-dd HH:mm:ss")));
       articleBaseDto.setDeleted(0);
       articleBaseDto.setBody(articleBaseDto.getBody());
//       articleBaseDto.setAuthorName(articleBaseDto.getAuthorName());
       articleBaseDto.setViewsNumber(articleBaseDto.getViewsNumber());
//       articleBaseDto.setTitle(title);    
       articleService.updateArticle(articleBaseDto);
       ResponseJsonModel responseJsonModel = new ResponseJsonModel();
       responseJsonModel.setCode("200");
       return responseJsonModel;
	}

    
    /**
     * 跳转到文章列表页面
     * @author 嵇俊达
	 * @date 2020.4.15
     * @param request
     * @param response
     * @return
     */
    @PermissionAnn(menuCode = "article",msg = "你没有进入管理文章页面的权限!")
    @RequestMapping(value="/manager")
    public String managerArticle(HttpServletRequest request, HttpServletResponse response){
      return "/Article/article_exam";
    }


    /**
     * 删除文章
     * @author 嵇俊达
	 * @date 2020.4.15
     * @param model
     * @param articleSearchBean
     * @return
     */
    @Transactional
    @AdminLogAnn(operType = OperType.SYSTEM,operLevel = OperLevel.NORM,operDescribe = "删除文章")
    @PermissionAnn(menuCode = "article",operCode = "deleted",msg = "你没有删除文章的权限!")
    @RequestMapping(value = "/deleteArticle")
    @ResponseBody
    public ArticleSearchBean deleteArticle(Model model,ArticleSearchBean articleSearchBean,HttpServletRequest request){
        articleService.deleteArticle(articleSearchBean);
        return articleSearchBean;
    }
    
	
    /**
     * 获取文章列表
     * @author 嵇俊达
	 * @date 2020.4.15
     * @return
     */
//    @PermissionAnn(menuCode = "article",msg = "你没有进入获取文章列表的权限!")
    @RequestMapping(value = "/list")
    @ResponseBody
    public DataTablePageModel searchArticleList(ArticleConditionBean articleConditionBean){
      
        articleService.findArticleList(articleConditionBean);
        return articleConditionBean;
    }
}
