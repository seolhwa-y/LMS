package kr.happyjob.study.ship.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ship.dao.RefundBuyerDao;
import kr.happyjob.study.ship.model.RefundBuyerModel;

@Service
public class RefundBuyerServiceImpl implements RefundBuyerService {
	
	@Autowired
	RefundBuyerDao RefundBuyerDao;

	@Override
	public List<RefundBuyerModel> refundList(Map<String, Object> paramMap) throws Exception {
		return  RefundBuyerDao.refundList(paramMap);
		
	}

	@Override
	public int refundListCnt(Map<String, Object> paramMap) throws Exception {
		
		return RefundBuyerDao.refundListCnt(paramMap);
	}

	@Override
	public List<RefundBuyerModel> refundDtlList(Map<String, Object> paramMap) throws Exception {
	
		return RefundBuyerDao.refundDtlList(paramMap);
	}

	@Override
	public int refundDtlListCnt(Map<String, Object> paramMap) throws Exception {
	
		return RefundBuyerDao.refundDtlListCnt(paramMap);
	}
/**
 * 
 * 재고처리 시작
 * 
 * */
	@Override
	public void refundUpdateR(Map<String, Object> paramMap) {
		RefundBuyerDao.refundUpdateR(paramMap);
		
	}

	@Override
	public void refundUpdateW(Map<String, Object> paramMap) {
		RefundBuyerDao.refundUpdateW(paramMap);
		
	}

	@Override
	public void refundInsertW(Map<String, Object> paramMap) {
		RefundBuyerDao.refundInsertW(paramMap);
		
	}
/**
 * 
 * 재고처리 끝
 * 
 * */
	
	
}