package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.NoticeMgrDAO;

@Service
public class NoticeMgrService implements NoticeMgrInter {
	
	@Autowired
	NoticeMgrDAO nd;
	
	public NoticeMgrService() {}
	
	@Override
	public HashMap<String, Object> getNoticeList (HashMap<String, Object> map) {
		this.paging(map);
		
	    map.put("noticeList", nd.getNoticeList(map));
	    map.put("noticeCount", nd.getNoticeCnt(map));
	    
		return map;
	}
	
	@Override
	public HashMap<String, Object> insertNotice (HashMap<String, Object> map) {
		if(nd.insertNotice(map) > 0) map.put("message", "게시글 등록 완료");
		else map.put("message", "게시글 등록 실패"); 
		
		this.getNoticeList(map);
		
		return map;
	}
	
	@Override
	public HashMap<String, Object> updateNotice (HashMap<String, Object> map) {
		if(nd.updateNotice(map) > 0) {
			if(map.get("view") != null) {
				map.put("message", "게시글 조회 완료"); 
				map.put("noticeList", nd.getNoticeList(map));
			}
			else {
				map.put("message", "게시글 수정 완료");
				this.getNoticeList(map);
			}
		} else map.put("message", "게시글 수정 실패");  
		
		return map;
	}
	
	@Override
	public HashMap<String, Object> deleteNotice (HashMap<String, Object> map) {
		if(nd.deleteNotice(map) > 0) map.put("message", "게시글 삭제 완료");
		else map.put("message", "게시글 삭제 실패");  

		this.getNoticeList(map);
		
		return map;
	}

	private HashMap<String, Object> paging (HashMap<String, Object> map) {
		int pageNum = Integer.parseInt((String) map.get("pageNum")),
				end = Integer.parseInt((String) map.get("listCount")),
				start = (pageNum - 1) * end;

		map.put("startPage", start);
		map.put("endPage", end);
		
		return map;
	}
}
