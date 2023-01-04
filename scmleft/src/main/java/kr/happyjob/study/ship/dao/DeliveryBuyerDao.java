package kr.happyjob.study.ship.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ship.model.DeliveryBuyerModel;

public interface DeliveryBuyerDao {

	//배송지시서 리스트 조회
	List<DeliveryBuyerModel> deliveryBuyerList(Map<String, Object> paramMap)throws Exception;

	//목록 수 추출
	int deliveryBuyerListCnt(Map<String, Object> paramMap)throws Exception;

	//상세 단건조회
	DeliveryBuyerModel deliveryListOne(Map<String, Object> paramMap)throws Exception ;	
		
	//출고 insert
	int insertDelHousing(Map<String, Object> paramMap)throws Exception;
	
	//재고 update
	int updateDelStock(Map<String, Object> paramMap)throws Exception;

	//배송여부 update
	int updateDel(Map<String, Object> paramMap)throws Exception;
	
}