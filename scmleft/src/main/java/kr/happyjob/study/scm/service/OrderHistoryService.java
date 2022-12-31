package kr.happyjob.study.scm.service;

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
		Gson gson = new Gson();
	
		model.addAttribute("orderHistoryList", gson.toJson(this.sql.selectList("getOrderHistoryList")));
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
			map.put("shipInfo", this.sql.selectOne("getShipInfo", map));
			map.put("deliInfo", this.sql.selectList("getDeliInfo", map));
			break;
			
		default:
			break;
		}
		
	}

	// 발주정보 + 발주지시서 Insert
	@Transactional
	private void insertBorderDirectionCtl(HashMap<String, Object> map) {
		
	}

	// 배송정보 + 배송지시서 Insert
	@Transactional
	private void insertShipDirectionCtl(HashMap<String, Object> map) {
		
	}
	
	// 검색 Select

	private void getSearchHistoryCtl(HashMap<String, Object> map) {
		map.put("newOrderSearchList", this.sql.selectList("getOrderHistoryList", map));
	}

	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}

}
