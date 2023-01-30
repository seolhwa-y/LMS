package kr.happyjob.study.cmp.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.RefundConfirmModel;


public interface RefundConfirmService {

	// 거래내역 검색
	public List<RefundConfirmModel> refundConfirmMgt(Map<String, Object> paramMap) throws Exception;
	// 거래내역 카운트
	public int refundConfirmMgtcnt(Map<String, Object> paramMap) throws Exception;
	
	public void SclickRefundConfirm(Map<String, Object> paramMap);

}