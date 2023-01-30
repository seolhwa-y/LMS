package kr.happyjob.study.cor.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
  
import kr.happyjob.study.cor.dao.ProductListDAO;
import kr.happyjob.study.cor.model.ProductInfoModel;

@Service
public class ProductListServiceImpl implements ProductListInterService  {
	
	@Autowired
	ProductListDAO pld;
	
	
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

	//제품리스트
	@Override
	public List<ProductInfoModel> productList(Map<String, Object> paramMap) throws Exception {
		
			List<ProductInfoModel> productList = pld.productList(paramMap);
		return productList;
	}

	//제품카운트
	@Override
	public int productTotalCnt(Map<String, Object> paramMap) throws Exception {
		
		int productTotalCnt = pld.productTotalCnt(paramMap);
		return productTotalCnt;
	}
	//제품상세정보
	@Override
	public ProductInfoModel selecProductDetail(Map<String, Object> paramMap) throws Exception {
		
		ProductInfoModel selecProductDetai = pld.selecProductDetail(paramMap);
		return selecProductDetai;
	}

}
