package kr.happyjob.study.cor.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cor.model.ProductInfoModel;

public interface ProductListInterService {

	// 장바구니 담기
	public int insertBasket (Map<String, Object> map) throws Exception;
	
	// 주문하기
	public int insertJorderInfo (Map<String, Object> map) throws Exception;

	//제품목록 조회
	public List<ProductInfoModel> productList(Map<String, Object> paramMap) throws Exception;
	
	//제품목록 카운트
	public int productTotalCnt(Map<String, Object> paramMap) throws Exception;

	
	//제품상세정보
	public ProductInfoModel selecProductDetail(Map<String, Object> paramMap)  throws Exception;
	
}
