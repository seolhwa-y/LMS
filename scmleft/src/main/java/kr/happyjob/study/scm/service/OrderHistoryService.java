package kr.happyjob.study.scm.service;

import java.text.DecimalFormat;
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
	private void getBorderWarehouseCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 발주정보 + 발주지시서 Insert
	@Transactional
	private void insertBorderDirectionCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 배송 창고정보 Select
	private void getShipWarehouseCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}

	// 배송정보 + 배송지시서 Insert
	@Transactional
	private void insertShipDirectionCtl(Model model) {
		/* 담당자 : 염설화
		 * 개발기간 : 
		 * 비고 :  */
		
	}
	
	// OrderHistoryList String Table
	private String makeListHtml(List<OrderHistoryModel> ohList) {
		StringBuffer sb = new StringBuffer();
		
		
		return sb.toString();
	}
	
	// 창고정보 셀렉트 박스
	private String makeSelectBoxHtml(List<OrderHistoryModel> ohList) {
		StringBuffer sb = new StringBuffer();
		DecimalFormat numFormat = new DecimalFormat("###,###,###,###,###");
				
		for(int i = 0; i < ohList.size(); i++) {
			sb.append("<tr><td>" + ohList.get(i).getJordCode() + "</td>");
			sb.append("<td>" + ohList.get(i).getJordDate().substring(0, 4) + "-");
			sb.append(ohList.get(i).getJordDate().substring(4, 6) + "-");
			sb.append(ohList.get(i).getJordDate().substring(6, 8) + "</td>");
			sb.append("<td>" + ohList.get(i).getCompanyName() + "</td>");
			sb.append("<td>" + ohList.get(i).getPdName() + "</td>");
			sb.append("<td>" + numFormat.format(ohList.get(i).getWhStock()) + "</td>");
			sb.append("<td>" + numFormat.format(ohList.get(i).getPdPrice()) + "</td>");
			sb.append("<td>" + numFormat.format(ohList.get(i).getJordAmt()) + "</td>");
			sb.append("<td>" + numFormat.format(ohList.get(i).getTotalAmt()) + "</td>");
			
			if(ohList.get(i).getReDate() != null) sb.append("<td>Y</td><td>" + ohList.get(i).getReDate() + "</td>");
			else sb.append("<td>N</td><td></td>");
			
			if(ohList.get(i).getJordIn() == "0") sb.append("<td>미입금</td>");
			else sb.append("<td>입금</td>");
			
			if(ohList.get(i).getBordCode() != null) sb.append("<td>작성완료</td>");
			else sb.append("<td><input type = 'button' id = 'btnBordDirec' value = '작성' onClick = 'showDirection(\"Border\")' /></td>");
			
			if(ohList.get(i).getShCode() != null) sb.append("<td>작성완료</td>");
			else sb.append("<td><input type = 'button' id = 'btnShipDirec' value = '작성' onClick = 'showDirection(\"Sorder\")' /></td>");			
		}
		
		return sb.toString();
	}

	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}

}
