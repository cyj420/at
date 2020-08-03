package com.sbs.cyj.at.controller;

import java.util.List;

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
	
	@RequestMapping("/article/list")
	public String showList(Model model) {
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("articles", articles);
		
		return "article/list";
	}
	
	@RequestMapping("/article/detail")
	public String showDetail(Model model) {
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("articles", articles);
		
		return "article/detail";
	}
	
//	@RequestMapping("/article/delete")
//	public String articleDelete(Model model,
//		@RequestParam(value = "id")int id)
//	{
//		articleService.articleDelete(id);
//		return "article/list";
//	}
	@RequestMapping("/article/doDelete")
	@ResponseBody
	public String doDelete(long id) {
		articleService.delete(id);

		String msg = id + "번 게시물이 삭제되었습니다.";

		StringBuilder sb = new StringBuilder();

		sb.append("alert('" + msg + "');");
		sb.append("location.replace('./list');");

		sb.insert(0, "<script>");
		sb.append("</script>");

		return sb.toString();
	}
}