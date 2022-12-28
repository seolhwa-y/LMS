package kr.happyjob.study.cor.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.OrderStatusModel;

public interface OrderStatusDAO {
	// 기업회원별 주문이력 조회
	public List<OrderStatusModel> getOrderStatusList(HashMap<String, Object> map);
	
	// 주문별 항목 조회
	public List<OrderStatusModel> getOrderDetails(OrderStatusModel osm);
	
	// 입금하기
	public int updateJorderInStatus(HashMap<String, Object> map);
	
	// 반품신청
	public int insertReturnInfo (OrderStatusModel osm);
	public int updateShipInfo(OrderStatusModel osm);
}
