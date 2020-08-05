package com.sbs.cyj.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.cyj.at.dao.ArticleDao;
import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.ArticleReply;
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

	public long add(Map<String, Object> param) {
		articleDao.add(param);

		return Util.getAsLong(param.get("id"));
	}

	public Article getArticleById(long id) {
		return articleDao.getArticleById(id);
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}

	public List<ArticleReply> getArticleRepliesByArticleId(int id) {
		return articleDao.getArticleRepliesByArticleId(id);
	}

	public void modifyArticleReplyById(String id, String body) {
		articleDao.modifyArticleReplyById(id, body);
	}

	public void deleteArticleReplyById(int id) {
		articleDao.deleteArticleReplyById(id);
	}
}

