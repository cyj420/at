package com.sbs.cyj.at.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.cyj.at.dto.Article;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles();
	
}