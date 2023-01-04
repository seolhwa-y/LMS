package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.RefundInfoVO;
import kr.happyjob.study.scm.model.WarehouseVO;

public interface RefundInfoService {

	public List<RefundInfoVO> refundInfoList(Map<String, Object> paramMap) throws Exception;
	public int countRefundInfoList(Map<String, Object> paramMap) throws Exception;
	
	public RefundInfoVO refundDtModalList(Map<String, Object> paramMap) throws Exception;
	//모달 창고 옵션
	public List<WarehouseVO> selectWareInfo(Map<String, Object> paramMap) throws Exception;

	//반품 승인 요청 업데이트
	public void updateRefund(Map<String, Object> paramMap) throws Exception;
	
}
