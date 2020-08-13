package com.sbs.cyj.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.cyj.at.dto.Article;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles();

	List<Article> getForPrintArticlesBySearchKeyword(String searchKeyword);

	public void delete(long id);

	public void write(Map<String, Object> param);

	Article getArticleById(int id);

	void modify(Map<String, Object> param);
}