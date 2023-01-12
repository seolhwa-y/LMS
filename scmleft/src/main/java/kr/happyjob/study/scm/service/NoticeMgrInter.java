package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.Map;

public interface NoticeMgrInter {
	// 리스트 및 페이지카운트
	public HashMap<String, Object> getNoticeList(HashMap<String, Object> map) throws Exception;
	// 게시글 등록
	public HashMap<String, Object> insertNotice(HashMap<String, Object> map) throws Exception;
	// 게시글 수정
	public HashMap<String, Object> updateNotice(HashMap<String, Object> map) throws Exception;
	// 게시글 삭제
	public HashMap<String, Object> deleteNotice(HashMap<String, Object> map) throws Exception;
}
