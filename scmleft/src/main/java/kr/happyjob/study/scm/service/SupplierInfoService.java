package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.SalesStatusModel;


public interface SupplierInfoService {

	// 거래내역 검색
	List<SalesStatusModel> transactionHistory(Map<String, Object> paramMap) throws Exception;
	// 거래내역 카운트
	int transactionHistoryCnt(Map<String, Object> paramMap) throws Exception;
	// 상세내역 검색
	List<SalesStatusModel> dtlList(Map<String, Object> paramMap) throws Exception;
	// 상세내역 검색 카운트
	int dtlLisCnt(Map<String, Object> paramMap) throws Exception;



}