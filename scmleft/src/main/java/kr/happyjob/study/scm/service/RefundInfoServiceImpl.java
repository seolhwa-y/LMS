package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.scm.dao.RefundInfoDao;
import kr.happyjob.study.scm.model.RefundInfoVO;
import kr.happyjob.study.scm.model.WarehouseVO;

@Service
public class RefundInfoServiceImpl implements RefundInfoService{

	@Autowired
	RefundInfoDao refundInfoDao;
	
	@Override	
	public List<RefundInfoVO> refundInfoList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<RefundInfoVO> listRefundInfo = refundInfoDao.refundInfoList(paramMap);
		return listRefundInfo;
	}

	@Override
	public int countRefundInfoList(Map<String, Object> paramMap)  throws Exception{
		// TODO Auto-generated method stub
		int totalCnt = refundInfoDao.countRefundInfoList(paramMap);
		return totalCnt;
	}

	@Override
	public RefundInfoVO refundDtModalList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		RefundInfoVO rDtModal = refundInfoDao.refundDtModalList(paramMap);
		return rDtModal;
	}

	@Override
	public List<WarehouseVO> selectWareInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		 List<WarehouseVO> wareInfo = refundInfoDao.selectWareInfo(paramMap);
		return wareInfo;
	}


	@Transactional
	@Override
	public void updateRefund(Map<String, Object> paramMap) throws Exception {
		refundInfoDao.insertDir(paramMap);
		refundInfoDao.updateRefund(paramMap);
		
		//refundInfoDao.updateDirRefund(paramMap);
		
		
		
	}

		

}
