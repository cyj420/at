package com.sbs.cyj.at.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleReply {
	private int id;
	private String regDate;
	private int articleId;
	private int memberId;
	private String body;
	private Map<String, Object> extra;
}