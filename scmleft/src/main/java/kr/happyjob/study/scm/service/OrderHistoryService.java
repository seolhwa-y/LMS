package kr.happyjob.study.scm.service;

import java.util.HashMap;
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

import kr.happyjob.study.login.controller.LoginController;
import kr.happyjob.study.scm.model.OrderHistoryModel;

@Service
public class OrderHistoryService implements OrderHistoryInter {

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	OrderHistoryModel ohm;
	@Autowired
	LoginController lc;
	
	public OrderHistoryService() {}

	public void backController (HttpSession session, ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		System.err.println("로그인 중이냐 : " + session.getAttribute("loginId"));
		
		if(session.getAttribute("loginId") != null) {
			switch (serviceCode) {
			case 1 : this.showOrderHistoryCtl(mav); break; // 일별 수주 내역 불러오기
	
			default : break;
			}
		} else { 
			mav.setViewName("/login/login");
		}
		
	}

	public void backController (HttpSession session, Model model, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.getBorderWarehouseCtl(model); break; // 발주지시서 보기
		case 2 : this.insertBorderDirectionCtl(model); break; // 발주지시서 작성완료
		case 3 : this.getShipWarehouseCtl(model); break; // 배송지시서 보기
		case 4 : this.insertShipDirectionCtl(model); break; // 배송지시서 작성완료

		default : break;
		}
	}
	

	// 주문내역 Select
	@SuppressWarnings("unchecked")
	private void showOrderHistoryCtl(ModelAndView mav) {
		Gson gson = new Gson();
		
		List<OrderHistoryModel> ohmList = (List<OrderHistoryModel>) this.sql.selectList("getOrderHistoryList");
		mav.addObject("orderHistoryList", gson.toJson(ohmList));
		mav.setViewName("scm/orderHistory");
		
		System.out.println(mav.getModel().get("orderHistoryList"));
	} 
	
	// 발주 창고정보 Select
	private void getBorderWarehouseCtl(Model model) {

		
	}

	// 발주정보 + 발주지시서 Insert
	@Transactional
	private void insertBorderDirectionCtl(Model model) {

		
	}

	// 배송 창고정보 Select
	private void getShipWarehouseCtl(Model model) {

		
	}

	// 배송정보 + 배송지시서 Insert
	@Transactional
	private void insertShipDirectionCtl(Model model) {

		
	}
	
	// 창고정보 셀렉트 박스
	private String makeSelectBoxHtml(List<OrderHistoryModel> ohmList) {
		
		return null;
	}

	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}

}
