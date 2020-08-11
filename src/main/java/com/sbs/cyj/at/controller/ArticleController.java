package com.sbs.cyj.at.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.Member;
import com.sbs.cyj.at.dto.Reply;
import com.sbs.cyj.at.dto.ResultData;
import com.sbs.cyj.at.service.ArticleService;
import com.sbs.cyj.at.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/usr/article/list")
	public String showList(Model model, @RequestParam int page, String searchKeyword) {
		int itemsInAPage = 5;
		
		List<Article> articles = articleService.getForPrintArticles();
		if(searchKeyword.trim().length() != 0) {
			articles = articleService.getForPrintArticlesBySearchKeyword(searchKeyword);
		}
		
		int fullPage = (articles.size()-1)/itemsInAPage + 1;
		
		model.addAttribute("articles", articles);
		model.addAttribute("size", articles.size());
		model.addAttribute("fullPage", fullPage);
		model.addAttribute("page", page);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("articles", articles);
		model.addAttribute("size", articles.size());
		
		return "article/detail";
	}
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(long id) {
		articleService.delete(id);

		String msg = id + "번 게시물이 삭제되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./list?searchKeyword=&page=1');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/usr/article/add")
	public String showAdd() {
		return "article/add";
	}
	
	@RequestMapping("/usr/article/doAdd")
	@ResponseBody
	public String doAdd(@RequestParam Map<String, Object> param) {
		int newId = articleService.add(param);

		String msg = newId + "번 게시물이 추가되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + newId + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, long id) {
		Article article = articleService.getArticleById(id);
		model.addAttribute("article", article);
		return "article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, long id) {
		articleService.modify(param);

		String msg = id + "번 게시물이 수정되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + id + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/usr/article/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", request.getAttribute("loginedMemberId"));
		param.put("relTypeCode", "article");
		
		Util.changeMapKey(param, "relId", "relId");
		
		int newReplyId = articleService.writeReply(param);

		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newReplyId), rsDataBody);
	}
	
	@RequestMapping("/usr/article/getForPrintReplies")
	@ResponseBody
	public ResultData getForPrintReplies(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");
		
		param.put("actor", loginedMember);
		
		List<Reply> replies = articleService.getForPrintReplies(param);
		rsDataBody.put("replies", replies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", replies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/article/doModifyReplyAjax")
	@ResponseBody
	public ResultData doReplyModify(@RequestParam int id, String body) {
		articleService.modifyReplyById(""+id, body);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", id));
	}
	
	@RequestMapping("/usr/article/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply ar = articleService.getReplyById(id);
		
		if(articleService.actorCanDelete(loginedMember, ar) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 삭제할 권한이 없습니다.", id));
		}
		articleService.deleteReplyById(id);
		
		return new ResultData("S-1", String.format("%d번 댓글을 삭제하였습니다.", id));
	}
	
	
//	@RequestMapping("/usr/article/doModifyReplyAjax")
//	@ResponseBody
//	public ResultData doModifyReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req, int id) {
//		Member loginedMember = (Member) req.getAttribute("loginedMember");
//		ArticleReply articleReply = articleService.getForPrintArticleReplyById(id);
//
//		if ( articleService.actorCanModify(loginedMember, articleReply) == false ) {
//			return new ResultData("F-1", String.format("%d번 댓글을 수정할 권한이 없습니다.", id));
//		}
//
//		Map<String, Object> modfiyReplyParam = Util.getNewMapOf(param, "id", "body");
//		ResultData rd = articleService.modfiyReply(modfiyReplyParam);
//
//		return rd;
//	}
	
}