package com.kjs.orm.mapper;



import com.kjs.common.bean.annotation.CleanCache;
import com.kjs.common.dto.course.ArticleBaseDto;

import com.kjs.orm.core.BaseMapper;
import com.kjs.orm.model.Article;
import com.kjs.orm.model.Course;
/**
 * 
 * @author 嵇俊达
 * @date 2020.4.17
 * @Description 文章管理service接口
 *
 */
@CleanCache(key="com.kjs.orm.mapper.ArticleMapper")
public interface ArticleMapper extends BaseMapper<Article,Long>{
	
	/**
     * 点击提交保存文章信息
     * @param articleBaseDto
     * @return
     */
    public int saveArticleBase(ArticleBaseDto articleBaseDto) ;
    
    
    /**
	 * 删除文章
	 * @param articleSearchBean
	 */
	public void deleteArticle(int id);
	
	
	/**
	 * 编辑之后，点击提交，更新文章内容
	 * @param articleBaseDto
	 * @return
	 */
	public int updateArticle(ArticleBaseDto articleBaseDto);

}
