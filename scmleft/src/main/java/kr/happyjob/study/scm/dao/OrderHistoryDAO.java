package kr.happyjob.study.scm.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.scm.model.OrderHistoryModel;

public interface OrderHistoryDAO {
	// 일별 수주 내역 불러오기
	public List<OrderHistoryModel> getOrderHistoryList (HashMap<String, Object> map);
	
	// 발주지시서 정보
	public OrderHistoryModel getBorderInfo (HashMap<String, Object> map);
	
	// 배송지시서 정보
	public OrderHistoryModel getShipInfo (HashMap<String, Object> map);
	
	// 창고정보
	public List<OrderHistoryModel> getWHInfo (HashMap<String, Object> map);
	
	// 배달요원
	public List<OrderHistoryModel> getDeliInfo (HashMap<String, Object> map);
	
	
	
	// 지시서
	public OrderHistoryModel insertDirection (OrderHistoryModel ohm);
	
	// 발주
	public OrderHistoryModel insertBorderInfo (OrderHistoryModel ohm);
	
	// 배송
	public OrderHistoryModel insertShipInfo (OrderHistoryModel ohm);
}
