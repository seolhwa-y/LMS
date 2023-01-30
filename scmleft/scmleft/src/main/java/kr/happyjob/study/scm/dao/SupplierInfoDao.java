package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.SalesStatusModel;

public interface SupplierInfoDao {

	// 기업리스트 조회
	public List<SalesStatusModel> transactionHistory(Map<String, Object> paramMap)throws Exception ;
	
	// 기업리스트 카운트 조회
	public int transactionHistoryCnt(Map<String, Object> paramMap) throws Exception;
	
	// 상세내역 조회
	public List<SalesStatusModel> dtlList(Map<String, Object> paramMap)throws Exception ;
		
	// 기업리스트 카운트 조회
	public int dtlLisCnt(Map<String, Object> paramMap) throws Exception;
	
}
