package com.kjs.service.kjs.article.spi;

import com.kjs.common.dto.course.ArticleBaseDto;
import com.kjs.common.dto.course.CourseBaseDto;
import com.kjs.orm.model.Article;
import com.kjs.orm.model.Course;
import com.kjs.service.core.spi.IBaseService;
import com.kjs.web.serach.kjs.article.ArticleConditionBean;
import com.kjs.web.serach.kjs.article.ArticleSearchBean;
/**
 * 
 * @author 嵇俊达
 * @date 2020.4.15
 * @Description 文章管理service接口
 *
 */
public interface IArticleService extends IBaseService<Article,Long>{
	
	/**
     * 点击提交保存文章信息
     * @param articleBaseDto
     * @return
     */
    public int saveArticleBase(ArticleBaseDto articleBaseDto) ;
    
    /**
     * 文章编辑按钮返回文章内容
     * @param id
     * @return
     */
	public Object scanArticle(Integer id);
	
	
	/**
	 * 删除文章
	 * @param articleSearchBean
	 */
	public void deleteArticle(ArticleSearchBean articleSearchBean);
	
	/**
	 * 获取文章列表
	 * @param articleConditionBean
	 */
	public void findArticleList(ArticleConditionBean articleConditionBean);
	
	
	/**
	 * 编辑之后，点击提交，更新文章内容
	 * @param articleBaseDto
	 * @return
	 */
	public int updateArticle(ArticleBaseDto articleBaseDto);

}
