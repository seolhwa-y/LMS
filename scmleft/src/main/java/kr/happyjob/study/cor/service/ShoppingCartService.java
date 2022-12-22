package kr.happyjob.study.cor.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
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

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
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

	public void backController (HttpSession session, Model model, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.deleteShoppingCartCtl(model); break; // 일별 수주 내역 불러오기
		case 2 : this.insertJorderInfoCtl(model); break;

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
		
		List<ShoppingCartModel> scList = (List<ShoppingCartModel>) this.sql.selectList("getBasketList", session.getAttribute("loginId"));
		mav.addObject("shoppingCartList", gson.toJson(scList));
		mav.setViewName("cor/shoppingCart");
		
		System.err.println(mav.getModel().get("shoppingCartList"));
	}
	
	// 장바구니 목록 일부 삭제하기
	@Transactional
	private void deleteShoppingCartCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 주문정보 Insert
	@Transactional
	private void insertJorderInfoCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}
}
