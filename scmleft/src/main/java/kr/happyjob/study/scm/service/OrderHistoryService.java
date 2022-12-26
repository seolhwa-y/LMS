package kr.happyjob.study.scm.service;

import java.text.DecimalFormat;
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

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.getDirectionInfoCtl(map); break; // 지시서 보기
		case 2 : this.insertBorderDirectionCtl(map); break; // 발주지시서 작성완료
		case 3 : this.getShipWarehouseCtl(map); break; // 배송지시서 보기
		case 4 : this.insertShipDirectionCtl(map); break; // 배송지시서 작성완료
		case 5 : this.getSearchHistoryCtl(map); break;
		default : break;
		}
	}
	



	// 주문내역 Select
	@SuppressWarnings("unchecked")
	private void showOrderHistoryCtl(ModelAndView mav) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 2022-12-21
		 * 비고 : DB에서 내역을 가져와서 List에 담아 JSON으로 바꿔 화면단에 넘겨준다. */
		Gson gson = new Gson();
		
		List<OrderHistoryModel> ohList = (List<OrderHistoryModel>) this.sql.selectList("getOrderHistoryList");
		mav.addObject("orderHistoryList", gson.toJson(ohList));
		// mav.addObject("orderHistoryList", makeSelectBoxHtml(ohList));
		mav.setViewName("scm/orderHistory");
		
		System.err.println(mav.getModel().get("orderHistoryList"));
	} 
	
	// 발주 창고정보 Select
	private void getDirectionInfoCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		System.out.println(map);
		String type = (String)map.get("type");
		// 창고정보는 발주 배송 모두 필요
		map.put("whInfo", this.sql.selectList("getWHInfo", map));
		
		switch (type) {
		case "b":	
			map.put("bordInfo", this.sql.selectOne("getBorderInfo", map));
			break;
			
		case "s": /* 배송 : 창고 + 주문정보 + 배달요원 */
			map.put("shipInfo", this.sql.selectList("getShipInfo", map));
			map.put("deliInfo", this.sql.selectList("getDeliInfo", map));
			break;
			
		default:
			break;
		}
		
	}
	
	

	// 발주정보 + 발주지시서 Insert
	@Transactional
	private void insertBorderDirectionCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 배송 창고정보 Select
	private void getShipWarehouseCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 배송정보 + 배송지시서 Insert
	@Transactional
	private void insertShipDirectionCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}
	@SuppressWarnings("unchecked")
	private void getSearchHistoryCtl(HashMap<String, Object> map) {
		List<OrderHistoryModel> ohList = (List<OrderHistoryModel>) this.sql.selectList("getOrderHistoryList", map);
		map.put("newOrderSearchList", ohList);
		System.err.println(map);
	}

	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}

}
