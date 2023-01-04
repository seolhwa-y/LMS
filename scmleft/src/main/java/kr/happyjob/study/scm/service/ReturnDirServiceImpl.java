package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.scm.dao.ReturnDirDao;
import kr.happyjob.study.scm.model.ReturnDirVO;

@Transactional
@Service
public class ReturnDirServiceImpl implements ReturnDirService{

	@Autowired
	ReturnDirDao returnDirDao;
	
	@Override
	public List<ReturnDirVO> returnDirList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<ReturnDirVO> returnDirList = returnDirDao.returnDirList(paramMap);
		return returnDirList;
	}

	@Override
	public int returnDirTotalCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		int totalCnt = returnDirDao.returnDirTotalCnt(paramMap);
		return totalCnt;
	}

}
