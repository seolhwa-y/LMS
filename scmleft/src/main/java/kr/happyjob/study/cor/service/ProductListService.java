package kr.happyjob.study.cor.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cor.dao.ProductListDAO;
import kr.happyjob.study.cor.model.ProductListModel;

@Service
public class ProductListService implements ProductListInter {
	
	@Autowired
	ProductListDAO pld;
	public ProductListService() {}
	
	
	// 제품 리스트 가져오기 + 검색
	@Override
	public List<ProductListModel> getProductList (Map<String, Object> map) {
		return pld.getProductList(map);
	}
	
	// 모델 리스트 가져오기
	@Override
	public List<ProductListModel> getModelList (Map<String, Object> map) {
		return pld.getModelList(map);
	}
	
	// 제조사 리스트 가져오기
	@Override
	public List<ProductListModel> getManufacturerList (Map<String, Object> map) {
		return pld.getManufacturerList(map);
	}
	
	// 장바구니 담기
	@Override
	public int insertBasket (Map<String, Object> map) {
		return pld.insertBasket(map);
	}
	
	// 주문하기
	@Override
	public int insertJorderInfo (Map<String, Object> map) {
		return pld.insertJorderInfo(map);
	}

}
