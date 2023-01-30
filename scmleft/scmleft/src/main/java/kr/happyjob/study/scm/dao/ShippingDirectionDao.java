package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ShippingDirectionModel;

public interface ShippingDirectionDao {

	//배송지시서 리스트 조회
	List<ShippingDirectionModel> shippingDirectionList(Map<String, Object> paramMap) throws Exception;

	int shippingDirectionListCnt(Map<String, Object> paramMap) throws Exception;
	
	ShippingDirectionModel shippingDirectionListOne(Map<String, Object> paramMap) throws Exception;	
		
}