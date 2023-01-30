package kr.happyjob.study.cor.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cor.dao.MyPageDAO;
import kr.happyjob.study.cor.model.MyPageModel;

@Service
public class MypageServiceImpl implements MyPageService{
	
	@Autowired 
	MyPageDAO myPageDao;
	
	//상세
	@Override
	public MyPageModel detailUser(Map<String, Object>paramMap) throws Exception{
		MyPageModel detailUser = myPageDao.detailUser(paramMap);
		
		return detailUser;
	}
	
	//업데이트
	@Override
	public int updateUser(Map<String, Object>paramMap) throws Exception{
		
		int resultCnt = myPageDao.updateUser(paramMap);
		
		return resultCnt;
		
	}
	
	

}
