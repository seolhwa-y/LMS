package kr.happyjob.study.cor.service;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

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

	public void backController (ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.showSoppingCartCtl(mav); break; // 일별 수주 내역 불러오기

		default : break;
		}
	}

	public void backController (Model model, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.deleteShoppingCartCtl(model); break; // 일별 수주 내역 불러오기
		case 2 : this.insertJorderInfoCtl(model); break;

		default : break;
		}
	}

	
	// 장바구니 목록 불러오기
	private void showSoppingCartCtl(ModelAndView mav) {

		
	}
	// 장바구니 목록 일부 삭제하기
	@Transactional
	private void deleteShoppingCartCtl(Model model) {

		
	}

	// 주문정보 Insert
	@Transactional
	private void insertJorderInfoCtl(Model model) {

		
	}
}
