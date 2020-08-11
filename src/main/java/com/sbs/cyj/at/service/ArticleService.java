package com.sbs.cyj.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.cyj.at.dao.ArticleDao;
import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.ArticleReply;
import com.sbs.cyj.at.dto.Member;
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

	public int add(Map<String, Object> param) {
		articleDao.add(param);

		return Util.getAsInt(param.get("id"));
	}

	public Article getArticleById(long id) {
		return articleDao.getArticleById(id);
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}

	public void modifyArticleReplyById(String id, String body) {
		articleDao.modifyArticleReplyById(id, body);
	}

	public void deleteArticleReplyById(int id) {
		articleDao.deleteArticleReplyById(id);
	}

	public int writeArticleReply(Map<String, Object> param) {
		articleDao.writeArticleReply(param);
		return Util.getAsInt(param.get("id"));
	}

	public List<ArticleReply> getForPrintArticleReplies(@RequestParam Map<String, Object> param) {
		List<ArticleReply> articleReplies = articleDao.getForPrintArticleReplies(param);

		Member actor = (Member)param.get("actor");

		for ( ArticleReply articleReply : articleReplies ) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, articleReply);
		}

		return articleReplies;
	}

	private void updateForPrintInfo(Member actor, ArticleReply articleReply) {
		articleReply.getExtra().put("actorCanDelete", actorCanDelete(actor, articleReply));
		articleReply.getExtra().put("actorCanUpdate", actorCanUpdate(actor, articleReply));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	private Object actorCanUpdate(Member actor, ArticleReply articleReply) {
		return actor != null && actor.getId() == articleReply.getMemberId() ? true : false;
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	private Object actorCanDelete(Member actor, ArticleReply articleReply) {
		return actorCanUpdate(actor, articleReply);
	}

}

