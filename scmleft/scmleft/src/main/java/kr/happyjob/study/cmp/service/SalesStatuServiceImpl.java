package kr.happyjob.study.cmp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmp.dao.SalesStatusDao;
import kr.happyjob.study.cmp.model.SalesStatusModel;
import kr.happyjob.study.supportD.model.NoticeDModel;

@Service
public class SalesStatuServiceImpl implements SalesStatusService {
	
	@Autowired
	SalesStatusDao SalesStatusDao;

	@Override
	public List<SalesStatusModel> transactionHistory(Map<String, Object> paramMap) throws Exception {
		return SalesStatusDao.transactionHistory(paramMap);
		
	}

	@Override
	public int transactionHistoryCnt(Map<String, Object> paramMap) throws Exception {
		
		return SalesStatusDao.transactionHistoryCnt(paramMap);
	}
	@Override
	public List<SalesStatusModel> dtlList(Map<String, Object> paramMap) throws Exception {
		return SalesStatusDao.dtlList(paramMap);
		
	}
	@Override
	public int dtlLisCnt(Map<String, Object> paramMap) throws Exception {
		
		return SalesStatusDao.dtlLisCnt(paramMap);
	}

	
	
}