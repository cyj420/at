package com.sbs.cyj.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.cyj.at.dao.ArticleDao;
import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.util.Util;

//@Component
@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
	}

	public List<Article> getForPrintArticlesBySearchKeyword(String searchKeyword) {
		return articleDao.getForPrintArticlesBySearchKeyword(searchKeyword);
	}

	public void delete(long id) {
		articleDao.delete(id);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);

		return Util.getAsInt(param.get("id"));
	}

	public Article getArticleById(long id) {
		return articleDao.getArticleById(id);
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}
}

