package kr.happyjob.study.ship.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ship.model.RefundBuyerModel;


public interface RefundBuyerService {

	// 반품지시서 내역검색
	List<RefundBuyerModel> refundList(Map<String, Object> paramMap) throws Exception;
	// 반품지시서내역 카운트
	int refundListCnt(Map<String, Object> paramMap) throws Exception;
	// 상세내역 내역검색
	List<RefundBuyerModel> refundDtlList(Map<String, Object> paramMap) throws Exception;
	// 상세내역 카운트
	int refundDtlListCnt(Map<String, Object> paramMap) throws Exception;
	// 재고처리(반품처리일자 등록 - UPDATE)
	public void refundUpdateR(Map<String, Object> paramMap);	
	// 재고처리(창고재고량 추가 - UPDATE)
	public void refundUpdateW(Map<String, Object> paramMap);	
	// 재고처리(창고입고 등록 - INSERT)
	public void refundInsertW(Map<String, Object> paramMap);	
			




}