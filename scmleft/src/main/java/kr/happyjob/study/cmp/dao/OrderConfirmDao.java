package kr.happyjob.study.cmp.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.OrderConfirmModel;

public interface OrderConfirmDao {
	// 주문 목록 리스트
	public List<OrderConfirmModel> orderConfirmMgt(Map<String, Object> paramMap)throws Exception ;
	
	// 주문 목록 승인 리스트 카운트
	public int orderConfirmMgtcnt(Map<String, Object> paramMap) throws Exception;
}
