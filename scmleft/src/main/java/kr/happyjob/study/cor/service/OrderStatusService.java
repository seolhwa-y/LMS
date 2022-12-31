package kr.happyjob.study.cor.service;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.google.gson.Gson;

import kr.happyjob.study.cor.model.OrderStatusModel;

@Service
public class OrderStatusService implements OrderStatusInter {

	@Autowired
	private SqlSessionTemplate sql;
	@Autowired(required = true)
	OrderStatusModel osm;
	
	public OrderStatusService() {}

	public void backController (HttpSession session, Model model, int serviceCode) {
		switch (serviceCode) {
		case 1 : this.showOrderStatusCtl(session, model); break;
	
		default : break;
		}
	}

	public void backController (HttpSession session, HashMap<String, Object> map, int serviceCode) {	
		switch (serviceCode) {
		case 1 : this.getDetailOrderCtl(map); break;
		case 2 : this.updateJorderStatusCtl(map); break;
		case 3 : this.insertReturnInfoCtl(map); break;
		case 4 : this.getNewOrderListCtl(map); break;
		
		default : break;
		}
	}
	
	

	// 주문내역 불러오기
	private void showOrderStatusCtl(HttpSession session, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Gson gson = new Gson();
		
		map.put("startPage", 0);
		map.put("endPage", 5);
		map.put("loginId", session.getAttribute("loginId"));
		System.out.println(map);
		model.addAttribute("orderCount", this.sql.selectOne("getOrderCount", map));
		model.addAttribute("orderStatusList", gson.toJson(this.sql.selectList("getOrderStatusList", map)));
	}

	// 상세주문내역 불러오기
	private void getDetailOrderCtl(HashMap<String, Object> map) {
		map.put("detailCount", this.sql.selectOne("getDetailCount", map));
		map.put("osdList", this.sql.selectList("getOrderDetails", map));
	}
	
	// 입금하기
	private void updateJorderStatusCtl(HashMap<String, Object> map) {
		String massage = "입금을 실패하셨습니다.";
		
		if(this.convertToBoolean(this.sql.update("updateJorderInStatus", map))) {
			massage = "입금이 성공적으로 완료되었습니다."; 
		} else System.err.println("업데이트 실패");		
		
		map.put("orderCount", this.sql.selectOne("getOrderCount", map));
		map.put("newOsList", this.sql.selectList("getOrderStatusList", map));
		map.put("message", massage);
	}

	// 반품신청
	@Transactional
	private void insertReturnInfoCtl(HashMap<String, Object> map) {
		String  message = "반품신청이 실패하셨습니다. \n 나중에 다시 시도해주세요.",
				j = (String)map.get("jordCode"), m = (String)map.get("modelCode"), w = (String)map.get("whCode"), b = (String)map.get("bordCode"),
				r = (String)map.get("reAmt");
		String jCode[] = j.split("&"), mCode[] = m.split("&"), wCode[] = w.split("&"), bCode[] = b.split("&"), rAmt[] = r.split("&");  

		for(int i = 0; i < jCode.length; i++) {
			osm.setJordCode(Integer.parseInt((String)jCode[i]));
			osm.setModelCode(Integer.parseInt((String)mCode[i]));
			osm.setWhCode(Integer.parseInt((String)wCode[i]));
			osm.setBordCode(Integer.parseInt((String)bCode[i]));
			osm.setReAmt(Integer.parseInt((String)rAmt[i]));
			osm.setBordCode(Integer.parseInt((String)bCode[i]));

			if(this.convertToBoolean(this.sql.insert("insertReturnInfo", osm))) {
				if(this.convertToBoolean(this.sql.update("updateShipInfo", osm))) {
					System.out.println("ship update & return insert 완료");
					message = "반품신청이 완료 되었습니다.";
				}
			} else  System.out.println("ship update & return insert 실패");
		}
		
		map.put("detailCount", this.sql.selectOne("getDetailCount", map));
		map.put("osdList", this.sql.selectList("getOrderDetails", osm));
		map.put("message", message);
	}
	
	// 기간 + 제품명 검색
	private void getNewOrderListCtl(HashMap<String, Object> map) {
		int pageNum = Integer.parseInt((String) map.get("pageNum")),
			end = Integer.parseInt((String) map.get("listCount")), // 1 = 5, 2 = 10, 3 = 15 
			start = (pageNum - 1) * end; // 1 = 0, 2 = 5, 3 = 10
		
		map.put("startPage", start);
		map.put("endPage", end);
		System.out.println(map);
		map.put("orderCount", (int)this.sql.selectOne("getOrderCount", map));
		map.put("newOrder", this.sql.selectList("getOrderStatusList", map));
	}
	
	// Insert / Update / Delete
	private Boolean convertToBoolean(int booleanCheck){
		return booleanCheck == 0 ? false : true;
	}
}
