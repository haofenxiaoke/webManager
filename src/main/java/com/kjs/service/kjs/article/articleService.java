package com.kjs.service.kjs.article;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.kjs.common.dto.course.ArticleBaseDto;
import com.kjs.orm.mapper.ArticleMapper;
import com.kjs.orm.model.Article;
import com.kjs.orm.model.Course;
import com.kjs.service.core.BaseService;
import com.kjs.service.kjs.article.spi.IArticleService;
import com.kjs.web.serach.kjs.article.ArticleConditionBean;
import com.kjs.web.serach.kjs.article.ArticleSearchBean;


/**
 * 
 * @author 嵇俊达
 * @date 2020.4.15
 * @Description 文章管理service实现类
 *
 */
@Service
public class articleService extends BaseService<Article,Long> implements IArticleService{
	
	@Resource
    private ArticleMapper articleDao;
	
	
	/**
     * 点击提交保存文章信息
     * @param articleBaseDto
     * @return
     */
	@Override
	public int saveArticleBase(ArticleBaseDto articleBaseDto) {
		// TODO Auto-generated method stub
		return articleDao.saveArticleBase(articleBaseDto);
        
	}
	
	/**
     * 文章编辑按钮返回文章内容
     * @param id
     * @return
     */
	@Override
	public Object scanArticle(Integer id) {
		return articleDao.findById(Long.parseLong(id+""));
	}
	
	
	/**
	 * 删除文章
	 * @param articleSearchBean
	 */
	@Override
	public void deleteArticle(ArticleSearchBean articleSearchBean) {
		articleDao.deleteArticle(articleSearchBean.getId());
		
	}
	
	
	/**
	 * 获取文章列表
	 * @param articleConditionBean
	 */
	@Override
	public void findArticleList(ArticleConditionBean articleConditionBean) {
		List<Article> article = this.articleDao.page(articleConditionBean);        
		articleConditionBean.setData(article);		
	}
	
	
	/**
	 * 编辑之后，点击提交，更新文章内容
	 * @param articleBaseDto
	 * @return
	 */
	@Override
	public int updateArticle(ArticleBaseDto articleBaseDto) {
		// TODO Auto-generated method stub
		return articleDao.updateArticle(articleBaseDto);
	}
	
	

}
