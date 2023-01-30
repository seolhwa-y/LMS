package kr.happyjob.study.cmp.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.RefundConfirmModel;

public interface RefundConfirmDao {

	// 기업리스트 조회
	public List<RefundConfirmModel> refundConfirmMgt(Map<String, Object> paramMap)throws Exception ;
	
	// 기업리스트 카운트 조회
	public int refundConfirmMgtcnt(Map<String, Object> paramMap) throws Exception;

	public void SclickRefundConfirm(Map<String, Object> paramMap);		
}
