package kr.happyjob.study.cor.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.happyjob.study.cor.model.ShoppingCartModel;

@Service
public class ShoppingCartService implements ShoppingCartInter {

	private static final String String = null;
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired
	ShoppingCartModel scm;
	
	public ShoppingCartService() {}

	public void backController (HttpSession session, ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		if(session.getAttribute("loginId") != null) {
			switch (serviceCode) {
			case 1 : this.showSoppingCartCtl(session, mav); break; // 일별 수주 내역 불러오기
	
			default : break;
			}
		}
	}

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.deleteShoppingCartCtl(map); break; // 일별 수주 내역 불러오기
		case 2 : this.insertJorderInfoCtl(map); break;

		default : break;
		}
	}

	
	// 장바구니 목록 불러오기
	@SuppressWarnings("unchecked")
	private void showSoppingCartCtl(HttpSession session, ModelAndView mav) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 : DB에 param으로 보낼 session에 저장된 userId를 가져와야 한다.
		  		  DB에서 내역을 가져와서 List에 담아 JSON으로 바꿔 화면단에 넘겨준다. */
		Gson gson = new Gson();
		System.out.println(session.getAttribute("loginId"));
		mav.addObject("shoppingCartList", gson.toJson(this.sql.selectList("getBasketList", session.getAttribute("loginId"))));
		mav.addObject("basketTotal", (int)this.sql.selectOne("getBasketTotal", session.getAttribute("loginId")));
		mav.setViewName("cor/shoppingCart");
		
	}
	
	// 장바구니 목록 일부 삭제하기
	@Transactional
	private void deleteShoppingCartCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		List<ShoppingCartModel> scList = new ArrayList<ShoppingCartModel>();
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
		map.put("delBaList", this.sql.selectList("getBasketList", scm.getLoginId()));
		map.put("message", message);
	}

	// 주문정보 Insert
	@Transactional
	private void insertJorderInfoCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		String[] mCode = ((String)map.get("modelCode")).split("&"),
				 wish = ((String)map.get("jordWishdate")).split("&"),
				 amt = ((String)map.get("jordAmt")).split("&"),
				 type = ((String)map.get("jordIn")).split("&");
		String message = "주문을 실패했습니다.";

		scm.setJordNo((int)this.sql.selectOne("getJordNoMax"));
		for(int i = 0; i < mCode.length; i++) {
			scm.setJordCode((int)this.sql.selectOne("getJordCodeMax"));
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
		 
		map.put("insBaList", this.sql.selectList("getBasketList", scm.getLoginId()));
		map.put("message", message);
	}
	
	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}
}
