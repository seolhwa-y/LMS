package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ProductInfoModel;

public interface ProductInfoDao {

	//제품정보 리스트 조회
	List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception;

	int productInfoListCnt(Map<String, Object> paramMap) throws Exception;

	ProductInfoModel productOne(Map<String, Object> paramMap);
	
	//ShippingDirectionModel shippingDirectionListOne(Map<String, Object> paramMap) throws Exception;	
		
}