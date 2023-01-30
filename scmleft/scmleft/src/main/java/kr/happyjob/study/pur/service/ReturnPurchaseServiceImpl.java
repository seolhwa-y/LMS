package kr.happyjob.study.pur.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pur.dao.ReturnPurchaseDao;
import kr.happyjob.study.pur.model.ReturnPurchaseModel;



@Service
public class ReturnPurchaseServiceImpl implements ReturnPurchaseService {

	@Autowired
	ReturnPurchaseDao returnpurchaseDao;
	
	@Override
	public List<ReturnPurchaseModel> returnPurchaseList(Map<String, Object> paramMap) throws Exception{
		List<ReturnPurchaseModel> returnPurchaseList = returnpurchaseDao.returnPurchaseList(paramMap);
		return returnPurchaseList;
	}

	@Override
	public int returnOrderCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = returnpurchaseDao.returnOrderCnt(paramMap);
		
		return totalCnt;
	}

	@Override
	public ReturnPurchaseModel returnPurchaseOne(Map<String, Object> paramMap) throws Exception {
		
		return returnpurchaseDao.returnPurchaseOne(paramMap);
	}

	@Override
	public List<ReturnPurchaseModel> returnOrderDetail(Map<String, Object> paramMap) throws Exception {
		
		
		return returnpurchaseDao.returnOrderDetail(paramMap);
	}

	@Override
	public int orderCount(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return returnpurchaseDao.orderCount(paramMap);
	}
	
}
