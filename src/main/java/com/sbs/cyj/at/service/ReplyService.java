package com.sbs.cyj.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.cyj.at.dao.ReplyDao;
import com.sbs.cyj.at.dto.Member;
import com.sbs.cyj.at.dto.Reply;
import com.sbs.cyj.at.util.Util;

//@Component
@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;
	
	public void modifyReplyById(String id, String body) {
		replyDao.modifyReplyById(id, body);
	}

	public void deleteReplyById(int id) {
		replyDao.deleteReplyById(id);
	}

	public int writeReply(Map<String, Object> param) {
		replyDao.writeReply(param);
		return Util.getAsInt(param.get("id"));
	}

	public List<Reply> getForPrintReplies(@RequestParam Map<String, Object> param) {
		List<Reply> replies = replyDao.getForPrintReplies(param);

		Member actor = (Member)param.get("actor");

		for ( Reply reply : replies ) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, reply);
		}

		return replies;
	}

	private void updateForPrintInfo(Member actor, Reply reply) {
		reply.getExtra().put("actorCanDelete", actorCanDelete(actor, reply));
		reply.getExtra().put("actorCanUpdate", actorCanUpdate(actor, reply));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	private boolean actorCanUpdate(Member actor, Reply reply) {
		return actor != null && actor.getId() == reply.getMemberId() ? true : false;
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	public boolean actorCanDelete(Member actor, Reply reply) {
		return actorCanUpdate(actor, reply);
	}

	public Reply getReplyById(int id) {
		return replyDao.getReplyById(id);
	}

}
