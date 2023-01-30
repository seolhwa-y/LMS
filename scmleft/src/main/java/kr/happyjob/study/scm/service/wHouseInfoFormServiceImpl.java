package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.wHouseInfoFormDao;
import kr.happyjob.study.scm.model.WarehouseVO;

@Service
public class wHouseInfoFormServiceImpl implements wHouseInfoFormService {

	@Autowired wHouseInfoFormDao wHouseInfoFormDao;
	
	@Override
	public List<WarehouseVO> WhList(Map<String, Object> paramMap) throws Exception {
		
		List <WarehouseVO> WhList = wHouseInfoFormDao.WhList(paramMap);
		return WhList;
	}
	@Override
	public int WhCnt(Map<String, Object> paramMap) throws Exception {
		int WhCnt = wHouseInfoFormDao.WhCnt(paramMap);
		return WhCnt;
	}
	@Override
	public WarehouseVO WhDetail(Map<String, Object> paramMap) throws Exception {
	
		WarehouseVO WarehouseVO = wHouseInfoFormDao.WhDetail(paramMap);
		return WarehouseVO;
	}
	@Override
	public int insertWh(Map<String, Object> paramMap) throws Exception {
		int statusChange = wHouseInfoFormDao.insertWh(paramMap);
		return statusChange;
	}
	@Override
	public int updateWh(Map<String, Object> paramMap) throws Exception {
		 int statusChange = wHouseInfoFormDao.updateWh(paramMap);
		return statusChange;
	}
	@Override
	public int deleteWh(Map<String, Object> paramMap) throws Exception {
		int statusChange = wHouseInfoFormDao.deleteWh(paramMap);
		return statusChange;
	}

}
