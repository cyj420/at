package com.sbs.cyj.at.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.cyj.at.dao.ArticleDao;
import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.File;
import com.sbs.cyj.at.util.Util;

//@Component
@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	
	@Autowired
	private FileService fileService;
	
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
	}

	public List<Article> getForPrintArticlesBySearchKeyword(String searchKeyword) {
		return articleDao.getForPrintArticlesBySearchKeyword(searchKeyword);
	}

	public void delete(int id) {
		articleDao.delete(id);
		fileService.deleteFiles("article", id);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);

		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String)param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());
	
			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고쳐야 한다.
			for ( int fileId : fileIds ) {
				fileService.changeRelId(fileId, id);			
			}
		}
		return id;
	}
	
	public Article getArticleById(int id) {
		Article article = articleDao.getArticleById(id);
		
		List<File> files = fileService.getFilesMapKeyFileNo("article", article.getId(), "common", "attachment");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		
		return article;
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String)param.get("fileIdsStr");

		if(fileIdsStr != null) {
			System.out.println("===fileIdsStr != null===");
		}
		System.out.println("=======1차=======");
		if(fileIdsStr.length() > 0) {
			// 이게 실행이 안 됨.
			
			System.out.println("===fileIdsStr.length() > 0===");
		}
		System.out.println("=======2차=======");
		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());
	
			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고쳐야 한다.
			for ( int fileId : fileIds ) {
				fileService.changeRelId(fileId, id);			
			}
		}
	}
}

