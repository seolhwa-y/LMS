package kr.happyjob.study.cor.service;

import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.google.gson.Gson;

import kr.happyjob.study.cor.model.ShoppingCartModel;

@Service
public class ShoppingCartService implements ShoppingCartInter {

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired
	ShoppingCartModel scm;
	
	public ShoppingCartService() {}

	public void backController (HttpSession session, Model model, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.showSoppingCartCtl(session, model); break;
	
		default : break;
		}
	}

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.deleteShoppingCartCtl(map); break;
		case 2 : this.insertJorderInfoCtl(map); break;

		default : break;
		}
	}

	
	// 장바구니 목록 불러오기
	private void showSoppingCartCtl(HttpSession session, Model model) {
		Gson gson = new Gson();

		model.addAttribute("basketTotal", this.sql.selectOne("getBasketTotal", session.getAttribute("loginId")));
		model.addAttribute("shoppingCartList", gson.toJson(this.sql.selectList("getBasketList", session.getAttribute("loginId"))));	
	}
	
	// 장바구니 목록 일부 삭제하기
	@Transactional(rollbackFor = SQLException.class)
	private void deleteShoppingCartCtl(HashMap<String, Object> map) {
		String[] mCode = ((String)map.get("modelCode")).split("&");
		String message = "장바구니 삭제를 실패하셨습니다.";

		for(int i = 0; i < mCode.length; i++) {
			scm.setLoginId((String)map.get("loginId"));
			scm.setModelCode(Integer.parseInt(mCode[i]));
			
			if(this.convertToBoolean(this.sql.delete("deleteBasketList", scm))) {
				System.out.println(scm.getModelCode() + " basket delete 성공");
				message = "장바구니 삭제가 성공적으로 완료되었습니다.";	
			}
		}
		map.put("basketTotal", this.sql.selectOne("getBasketTotal", (String)map.get("loginId")));
		map.put("delBaList", this.sql.selectList("getBasketList", scm.getLoginId()));
		map.put("message", message);
	}

	// 주문정보 Insert
	@Transactional(rollbackFor = SQLException.class)
	private void insertJorderInfoCtl(HashMap<String, Object> map) {
		String[] mCode = ((String)map.get("modelCode")).split("&"),
				 wish = ((String)map.get("jordWishdate")).split("&"),
				 amt = ((String)map.get("jordAmt")).split("&"),
				 type = ((String)map.get("jordIn")).split("&");
		String message = "주문을 실패했습니다.";

		scm.setJordNo((int)this.sql.selectOne("getJordNoMax"));
		for(int i = 0; i < mCode.length; i++) {
			scm.setLoginId((String)map.get("loginId"));
			scm.setModelCode(Integer.parseInt(mCode[i]));
			scm.setJordWishdate(wish[i]);
			scm.setJordAmt(Integer.parseInt(amt[i]));
			scm.setJordIn(type[i]);
	
			if(this.convertToBoolean(this.sql.insert("insertJorderInfo", scm))) {
				if(this.convertToBoolean(this.sql.delete("deleteBasketList", scm))) {
					message = "주문이 성공적으로 완료되었습니다.";
					System.out.println("basket delete & jorder insert 완료");
				} else System.out.println("basket delete 실패");
			} else System.out.println("jorder insert 실패");
		}
		map.put("basketTotal", this.sql.selectOne("getBasketTotal", (String)map.get("loginId")));
		map.put("insBaList", this.sql.selectList("getBasketList", scm.getLoginId()));
		map.put("message", message);
	}
	
	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}
}
