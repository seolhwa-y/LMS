package kr.happyjob.study.ship.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ship.model.DeliveryBuyerModel;

public interface DeliveryBuyerService {

	// 배송 관련 상태인 주문 리스트 가져오기
	List<DeliveryBuyerModel> deliveryBuyerList(Map<String, Object> paramMap) throws Exception;

	//목록 수 추출
	int deliveryBuyerListCnt(Map<String, Object> paramMap)throws Exception;

	//상세 단건조회
	DeliveryBuyerModel deliveryListOne(Map<String, Object> paramMap)throws Exception;
	
	//출고 insert
	int insertDelHousing(Map<String, Object> paramMap)throws Exception;

	//재고 update
	int updateDelStock(Map<String, Object> paramMap)throws Exception;
	
	//배송여부 update
	int updateDel(Map<String, Object> paramMap)throws Exception;
}
