package com.sbs.cyj.at.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.cyj.at.dto.Member;
import com.sbs.cyj.at.dto.Reply;
import com.sbs.cyj.at.dto.ResultData;
import com.sbs.cyj.at.service.ReplyService;
import com.sbs.cyj.at.util.Util;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/usr/reply/getForPrintReplies")
	@ResponseBody
	public ResultData getForPrintReplies(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();
		
		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");
		
		param.put("actor", loginedMember);
		
		List<Reply> replies = replyService.getForPrintReplies(param);
		rsDataBody.put("replies", replies);
		
		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", replies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/reply/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", request.getAttribute("loginedMemberId"));
		
//		Util.changeMapKey(param, "relId", "relId");
		
		int newReplyId = replyService.writeReply(param);
		rsDataBody.put("replyId", newReplyId);

		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newReplyId), rsDataBody);
	}
	
	@RequestMapping("/usr/reply/doModifyReplyAjax")
	@ResponseBody
	public ResultData doReplyModify(@RequestParam int id, String body) {
		replyService.modifyReplyById(""+id, body);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", id));
	}
	
	@RequestMapping("/usr/reply/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply ar = replyService.getReplyById(id);
		
		if(replyService.actorCanDelete(loginedMember, ar) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 삭제할 권한이 없습니다.", id));
		}
		replyService.deleteReplyById(id);
		
		return new ResultData("S-1", String.format("%d번 댓글을 삭제하였습니다.", id));
	}
}