package kr.happyjob.study.pur.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pur.model.OrdDtManagementVO;


public interface OrdDtManagementDao {

	public List<OrdDtManagementVO> ordDtManagementList(Map<String, Object> paramMap) throws Exception;
	
	public int ordDtManagementTotalCnt(Map<String, Object> paramMap) throws Exception;
	
	//단건조회
	public OrdDtManagementVO ordDtManagementSelect(Map<String, Object>paramMap)throws Exception;
	
	//상세조회
	public List<OrdDtManagementVO> ordDtlList(Map<String, Object> paramMap) throws Exception;
	public int countOrdDtlList(Map<String, Object> paramMap) throws Exception;
	
}
