package kr.happyjob.study.pur.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.pur.dao.OrdDtManagementDao;
import kr.happyjob.study.pur.model.OrdDtManagementVO;

@Transactional
@Service
public class OrdDtManagementServiceImpl implements OrdDtManagementService{

	@Autowired
	OrdDtManagementDao ordDtManagementDao;
	
	@Override
	public List<OrdDtManagementVO> ordDtManagementList(Map<String, Object> paramMap) throws Exception{
		List<OrdDtManagementVO> ordDtManagementList = ordDtManagementDao.ordDtManagementList(paramMap);
		return ordDtManagementList;
	}
	
	@Override
	public int ordDtManagementTotalCnt(Map<String, Object> paramMap) throws Exception{
		// TODO Auto-generated method stub
		int totalCnt = ordDtManagementDao.ordDtManagementTotalCnt(paramMap);
		return totalCnt;
	}

	@Override
	public OrdDtManagementVO ordDtManagementSelect(Map<String, Object> paramMap) throws Exception{
		// TODO Auto-generated method stub
		return ordDtManagementDao.ordDtManagementSelect(paramMap);
	}

	@Override
	public List<OrdDtManagementVO> ordDtlList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return ordDtManagementDao.ordDtlList(paramMap);
	}

	@Override
	public int countOrdDtlList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return ordDtManagementDao.countOrdDtlList(paramMap);
	}

}
