package kr.happyjob.study.ship.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ship.model.RefundBuyerModel;



public interface RefundBuyerDao {

	// 반품지시서 목록 조회
	public List<RefundBuyerModel> refundList(Map<String, Object> paramMap)throws Exception ;
	
	// 반품지시서 목록 총개
	public int refundListCnt(Map<String, Object> paramMap) throws Exception;
	// 상세내역 조회
	public List<RefundBuyerModel> refundDtlList(Map<String, Object> paramMap)throws Exception ;
		
	// 상세내역 조회 총개수
	public int refundDtlListCnt(Map<String, Object> paramMap) throws Exception;
	
	// 재고처리(반품처리일자 등록 - UPDATE)
	public void refundUpdateR(Map<String, Object> paramMap);	
	// 재고처리(창고재고량 추가 - UPDATE)
	public void refundUpdateW(Map<String, Object> paramMap);	
	// 재고처리(창고입고 등록 - INSERT)
	public void refundInsertW(Map<String, Object> paramMap);	
		
	
}
