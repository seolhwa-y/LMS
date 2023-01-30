package kr.happyjob.study.pur.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pur.dao.RefundFinalProcessingDao;
import kr.happyjob.study.pur.model.RefundFinalProcessingModel;




@Service
public class RefundFinalProcessingServiceImp implements RefundfinalProcessingService {

	@Autowired
	RefundFinalProcessingDao returnpurchaseDao;
	
	@Override
	public List<RefundFinalProcessingModel> refundFinalProcessingList(Map<String, Object> paramMap) throws Exception{
		List<RefundFinalProcessingModel> refundFinalProcessingList = returnpurchaseDao.refundFinalProcessingList(paramMap);
		return refundFinalProcessingList;
	}

	@Override
	public int returnOrderCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = returnpurchaseDao.returnOrderCnt(paramMap);
		
		return totalCnt;
	}

	@Override
	public RefundFinalProcessingModel refundFinalProcessOne(Map<String, Object> paramMap) throws Exception {
		
		return returnpurchaseDao.refundFinalProcessOne(paramMap);
	}

	@Override
	public List<RefundFinalProcessingModel> returnOrderDetail(Map<String, Object> paramMap) throws Exception {
		
		
		return returnpurchaseDao.returnOrderDetail(paramMap);
	}

	@Override
	public int orderCount(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return returnpurchaseDao.orderCount(paramMap);
	}
	
}
