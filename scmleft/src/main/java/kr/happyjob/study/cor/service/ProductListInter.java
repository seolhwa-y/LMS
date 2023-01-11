package kr.happyjob.study.cor.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cor.model.ProductListModel;

public interface ProductListInter {

	// 제품 리스트 가져오기 + 검색
	public List<ProductListModel> getProductList (Map<String, Object> map) throws Exception;
	
	// 모델 리스트 가져오기
	public List<ProductListModel> getModelList (Map<String, Object> map) throws Exception;
	
	// 제조사 리스트 가져오기
	public List<ProductListModel> getManufacturerList (Map<String, Object> map) throws Exception;
	
	// 장바구니 담기
	public int insertBasket (Map<String, Object> map) throws Exception;
	
	// 주문하기
	public int insertJorderInfo (Map<String, Object> map) throws Exception;
	
}
