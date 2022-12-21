package kr.happyjob.study.cor.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.ShoppingCartModel;

public interface ShoppingCartDAO {
	// 장바구니 목록
	public List<ShoppingCartModel> getBasketList (HashMap<String, Object> paramMap);
	
	// 주문하기
	public List<ShoppingCartModel> insertJorderInfo (List<ShoppingCartModel> scmList);
}
