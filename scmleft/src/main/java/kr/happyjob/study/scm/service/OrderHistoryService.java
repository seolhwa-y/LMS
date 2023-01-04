package kr.happyjob.study.scm.service;

import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.google.gson.Gson;

import kr.happyjob.study.login.controller.LoginController;
import kr.happyjob.study.scm.model.OrderHistoryModel;

@Service
public class OrderHistoryService implements OrderHistoryInter {
	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	OrderHistoryModel ohm;
	@Autowired
	LoginController lc;
	
	public OrderHistoryService() {}

	public void backController (HttpSession session, Model model, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.showOrderHistoryCtl(model); break;
	
		default : break;
		}		
	}

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.getSearchHistoryCtl(map); break;
		case 2 : this.getDirectionInfoCtl(map); break;
		case 3 : this.insertBorderDirectionCtl(map); break;
		case 4 : this.insertShipDirectionCtl(map); break;
		
		default : break;
		}
	}
	

	// 주문내역 Select
	private void showOrderHistoryCtl(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		
		map.put("startPage", 0);
		map.put("endPage", 10);
		model.addAttribute("historyCount", this.sql.selectOne("getHistoryCount", map));
		model.addAttribute("orderHistoryList", gson.toJson(this.sql.selectList("getOrderHistoryList", map)));
	} 
	
	// 발주 창고정보 Select
	private void getDirectionInfoCtl(HashMap<String, Object> map) {
		String type = (String)map.get("type");

		map.put("whInfo", this.sql.selectList("getWHInfo", map));
		
		switch (type) {
		case "b":	
			map.put("bordInfo", this.sql.selectOne("getBorderInfo", map));
			break;
			
		case "s": 
			map.put("shipInfo", this.sql.selectOne("getDirecInfo", map));
			map.put("deliInfo", this.sql.selectList("getDeliInfo", map));
			break;
			
		default: break;
		}
	}

	// 발주정보 + 발주지시서 Insert + Insert
	@Transactional(rollbackFor = SQLException.class)
	private void insertBorderDirectionCtl(HashMap<String, Object> map) {
		String message = "발주지시서 등록이 실패하셨습니다.";
		
		map.put("dirType", "1");
		if(this.convertToBoolean(this.sql.insert("insertDirection", map))) {
			if(this.convertToBoolean(this.sql.insert("insertBorderInfo", map))) {
				System.err.println("지시서 및 발주정보 모두 등록 완료");
				message = "발주지시서 등록이 완료되었습니다.";
			} else System.err.println("지시서만 등록 완료");
		} else System.err.println("지시서 및 발주정보 모두 등록 실패");
		
		map.put("message", message);
		map.put("startPage", 0);
		map.put("endPage", 10);
		map.put("historyCount", this.sql.selectOne("getHistoryCount", map));
		map.put("orderHistoryList", this.sql.selectList("getOrderHistoryList", map));
		
	}

	// 배송정보 + 배송지시서 Insert + Insert
	@Transactional(rollbackFor = SQLException.class)
	private void insertShipDirectionCtl(HashMap<String, Object> map) {
		String message = "배송지시서 등록이 실패하셨습니다.";
		
		map.put("dirType", "2");
		if(this.convertToBoolean(this.sql.insert("insertDirection", map))) {
			if(this.convertToBoolean(this.sql.insert("insertShipInfo", map))) {
				System.out.println("지시서 및 배송정보 모두 등록 완료");
				message = "배송지시서 등록이 완료되었습니다.";
			} else System.err.println("지시서만 등록 완료");
		} else System.err.println("지시서 및 발주정보 모두 등록 실패");
		
		map.put("message", message);
		map.put("startPage", 0);
		map.put("endPage", 10);
		map.put("historyCount", this.sql.selectOne("getHistoryCount", map));
		map.put("orderHistoryList", this.sql.selectList("getOrderHistoryList", map));
	}
	
	// 검색 Select
	private void getSearchHistoryCtl(HashMap<String, Object> map) {
		int pageNum = Integer.parseInt((String) map.get("pageNum")),
			end = Integer.parseInt((String) map.get("listCount")), 
			start = (pageNum - 1) * end; // 1 = 0, 2 = 5, 3 = 10
			
		map.put("startPage", start);
		map.put("endPage", end);
		map.put("historyCount", this.sql.selectOne("getHistoryCount", map));
		map.put("newOrderSearchList", this.sql.selectList("getOrderHistoryList", map));
	}

	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}

}
