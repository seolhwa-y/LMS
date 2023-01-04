package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoService {

	// 제품정보관리 리스트 가져오기		
	List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception;

	int productInfoListCnt(Map<String, Object> paramMap) throws Exception;

	ProductInfoModel productOne(Map<String, Object> paramMap)throws Exception;
	
	//클릭한 배송지시서 단건 조회
	//ShippingDirectionModel shippingDirectionListOne(Map<String, Object> paramMap) throws Exception;
}
