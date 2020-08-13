package com.sbs.cyj.at.controller;

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
import com.sbs.cyj.at.service.ArticleService;

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
		Article article = articleService.getArticleById(id);
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("article", article);
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
	
	@RequestMapping("/usr/article/write")
	public String showAdd() {
		return "article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
//		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", req.getAttribute("loginedMemberId"));
		param.put("relTypeCode", "article");
		
		
		int newArticleId = articleService.write(param);
//		rsDataBody.put("articleId", newArticleId);
		
		String msg = newArticleId + "번 게시물이 추가되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./detail?id=" + newArticleId + "');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
	
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {
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
}