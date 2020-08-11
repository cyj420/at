package com.sbs.cyj.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.Reply;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles();

	List<Article> getForPrintArticlesBySearchKeyword(String searchKeyword);

	public void delete(long id);

	public void add(Map<String, Object> param);

	Article getArticleById(long id);

	void modify(Map<String, Object> param);

	void modifyReplyById(String id, String body);

	void deleteReplyById(int id);

	void writeReply(Map<String, Object> param);

	List<Reply> getForPrintReplies(Map<String, Object> param);

	Reply getReplyById(int id);
}