package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ShippingDirectionModel;

public interface ShippingDirectionService {

	// 배송 관련 상태인 주문 리스트 가져오기
	List<ShippingDirectionModel> shippingDirectionList(Map<String, Object> paramMap) throws Exception;

	int shippingDirectionListCnt(Map<String, Object> paramMap) throws Exception;
	
	//클릭한 배송지시서 단건 조회
	ShippingDirectionModel shippingDirectionListOne(Map<String, Object> paramMap) throws Exception;
}
