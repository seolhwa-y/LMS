package kr.happyjob.study.cor.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cor.model.ProductListModel;

public interface ProductListDAO {
	
	// 제품 리스트 가져오기 + 검색
	public List<ProductListModel> getProductList (Map<String, Object> map);
	
	// 모델 리스트 가져오기
	public List<ProductListModel> getModelList (Map<String, Object> map);
	
	// 제조사 리스트 가져오기
	public List<ProductListModel> getManufacturerList (Map<String, Object> map);
	
	// 장바구니 담기
	public int insertBasket (Map<String, Object> map);
	
	// 주문하기
	public int insertJorderInfo (Map<String, Object> map);
	
}
