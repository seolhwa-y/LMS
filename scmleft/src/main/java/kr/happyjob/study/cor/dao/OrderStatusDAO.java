package kr.happyjob.study.cor.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.OrderStatusModel;

public interface OrderStatusDAO {
	// 기업회원별 주문이력 조회
	public List<OrderStatusModel> getOrderStatusList (HashMap<String, Object> paramMap);
	
	// 주문별 항목 조회
	public List<OrderStatusModel> getOrderDetails (OrderStatusModel osm);
	
	// 반품신청
	public OrderStatusModel insertReturnInfo (OrderStatusModel osm);
}
