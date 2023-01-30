package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.NoticeMgrModel;

public interface NoticeMgrService {
	
	// 공지사항 리스트 조회
	public List<NoticeMgrModel> noticeMgrList(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 목록 수 구하기
	public int noticeMgrCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 상세 조회
	public NoticeMgrModel noticeMgrDetail(Map<String, Object> paramMap)throws Exception;
	
	// 공지사항 조회수 증가
	public int noticeMgrViewcont(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 저장
	public int insertNoticeMgr(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 수정
	public int updateNoticeMgr(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 삭제
	public int deleteNoticeMgr(Map<String, Object> paramMap) throws Exception;
}
