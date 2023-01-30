package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.NoticeMgrDao;
import kr.happyjob.study.scm.model.NoticeMgrModel;

@Service
public class NoticeMgrServiceImpl implements NoticeMgrService {
	
	@Autowired
	NoticeMgrDao noticeMgrDao;
	
	// 공지사항 리스트 출력
	@Override
	public List<NoticeMgrModel> noticeMgrList(Map<String, Object> paramMap) throws Exception {
		
		List<NoticeMgrModel> noticeMgrList = noticeMgrDao.noticeMgrList(paramMap);
		return noticeMgrList;
	}
	
	// 공지사항 목록 개수 구하기
	@Override
	public int noticeMgrCnt(Map<String, Object> paramMap) throws Exception {
		int noticeMgrCnt = noticeMgrDao.noticeMgrCnt(paramMap);
		return noticeMgrCnt;
	}

	// 공지사함 상세 조회
	@Override
	public NoticeMgrModel noticeMgrDetail(Map<String, Object> paramMap) throws Exception {
		NoticeMgrModel noticeMgrModel = noticeMgrDao.noticeMgrDetail(paramMap);
		return noticeMgrModel;
	}

	// 공지사항 조회수 증가
	@Override
	public int noticeMgrViewcont(Map<String, Object> paramMap) throws Exception {
		int noticeMgrViewcont = noticeMgrDao.noticeMgrViewcont(paramMap);
		return noticeMgrViewcont;
	}
	
	// 공지사항 저장
	@Override
	public int insertNoticeMgr(Map<String, Object> paramMap) throws Exception {
		int insertNoticeMgr = noticeMgrDao.insertNoticeMgr(paramMap);
		return insertNoticeMgr;
	}
	
	// 공지사항 수정
	@Override
	public int updateNoticeMgr(Map<String, Object> paramMap) throws Exception {
		int updateNoticeMgr = noticeMgrDao.updateNoticeMgr(paramMap);
		return updateNoticeMgr;
	}
	
	// 공지사항 삭제
	@Override
	public int deleteNoticeMgr(Map<String, Object> paramMap) throws Exception {
		int deleteNoticeMgr = noticeMgrDao.deleteNoticeMgr(paramMap);
		return 0;
	}

	
	
	
	
	

}
