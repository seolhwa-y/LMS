package kr.happyjob.study.scm.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.scm.model.OrderHistoryModel;

public interface OrderHistoryDAO {
	// 일별 수주 내역 불러오기
	public List<OrderHistoryModel> getOrderHistoryList (HashMap<String, Object> paramMap);
	
	// 지시서
	public OrderHistoryModel insertDirection (OrderHistoryModel ohm);
	
	// 발주지시서
	public OrderHistoryModel insertBorderInfo (OrderHistoryModel ohm);
	
	// 배송지시서
	public OrderHistoryModel insertShipInfo (OrderHistoryModel ohm);
}
