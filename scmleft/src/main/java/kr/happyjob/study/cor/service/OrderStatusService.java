package kr.happyjob.study.cor.service;

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

import kr.happyjob.study.cor.model.OrderStatusModel;

@Service
public class OrderStatusService implements OrderStatusInter {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	OrderStatusModel osm;
	
	public OrderStatusService() {}

	public void backController (HttpSession session, ModelAndView mav, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		if(session.getAttribute("loginId") != null) {
			switch (serviceCode) {
			case 1 : this.showOrderStatusCtl(session, mav); break; // 주문내역 불러오기
	
			default : break;
			}
		} else {
			mav.setViewName("/login/login");
		}
	}

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {
		System.err.println("현재 실행되고 있는 클래스 이름 : " + className + " : " + serviceCode);
		
		switch (serviceCode) {
		case 1 : this.getDetailOrderCtl(map); break; // 상세 주문내역 불러오기
		case 2 : this.insertReturnInfoCtl(map); break; // 반품신청
		case 3 : this.getNewOrderListCtl(map); break;
		default : break;
		}
	}
	
	

	// 주문내역 불러오기
	@SuppressWarnings("unchecked")
	private void showOrderStatusCtl(HttpSession session, ModelAndView mav) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-21 ~ 2022-12-21
		 * 비고 : DB에 param으로 보낼 session에 저장된 userId를 가져와야 한다.
		  		  DB에서 내역을 가져와서 List에 담아 JSON으로 바꿔 화면단에 넘겨준다. */
		HashMap<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		map.put("loginId", session.getAttribute("loginId"));

		List<OrderStatusModel> osList = (List<OrderStatusModel>) this.sql.selectList("getOrderStatusList", map);
		mav.addObject("orderStatusList", gson.toJson(osList));
		mav.setViewName("cor/orderStatus");

	}

	// 상세주문내역 불러오기
	@SuppressWarnings("unchecked")
	private void getDetailOrderCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 2022-12-22 ~ 2022-12-22
		 * 비고 :  DB에 접근해서 주문한 제품들을 List에 담아서 보내준다. */
		
		List<OrderStatusModel> osdList = (List<OrderStatusModel>) this.sql.selectList("getOrderDetails", map.get("jordNo"));
		map.remove("jordNo");
		map.put("osdList", osdList);
	}

	// 반품신청
	@Transactional
	private void insertReturnInfoCtl(HashMap<String, Object> map) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}
	
	// 기간 + 제품명 검색
	private void getNewOrderListCtl(HashMap<String, Object> map) {
		System.out.println(map);
		List<OrderStatusModel> osList = (List<OrderStatusModel>) this.sql.selectList("getOrderStatusList", map);
		System.err.println(osList);
		map.put("newOrder", osList);
	}
	
	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}
}
