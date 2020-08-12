package com.sbs.cyj.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.cyj.at.dto.Reply;

@Mapper
public interface ReplyDao {
	void modifyReplyById(String id, String body);

	void deleteReplyById(int id);

	void writeReply(Map<String, Object> param);

	List<Reply> getForPrintReplies(Map<String, Object> param);

	Reply getReplyById(int id);
}