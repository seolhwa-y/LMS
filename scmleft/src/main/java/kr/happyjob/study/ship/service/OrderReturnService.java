package kr.happyjob.study.ship.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ship.dao.OrderReturnDAO;

@Service
public class OrderReturnService implements OrderReturnInter{

	@Autowired
	OrderReturnDAO ord;
	
	public OrderReturnService() {}

	@Override
	public HashMap<String, Object> getOrderReturnList(HashMap<String, Object> map) throws Exception{
		this.paging(map);
		map.put("orderReturnList", ord.getOrderReturnList(map));
		map.put("orderReturnCount", ord.getOrderReturnCount(map));
		
		return map;
	}
	
	@Override
	public HashMap<String, Object> getOrderReturnDetailList(HashMap<String, Object> map) throws Exception{
		this.paging(map);
		map.put("orderReturnDetailList", ord.getOrderReturnDetailList(map));
		map.put("orderReturnDetailCount", ord.getOrderReturnDetailCount(map));
		
		return map;
	}
	
	@Override
	public HashMap<String, Object> insertBorderReturn(HashMap<String, Object> map) throws Exception{
		// 반품신청
		if(ord.insertReturnInfo(map) > 0) map.put("message", "반품신청이 완료되었습니다.");
		else map.put("message", "반품신청이 실패하였습니다.");
		
		this.getOrderReturnList(map);
		this.getOrderReturnDetailList(map);
		
		return map;
	}
	
	@Override
	public HashMap<String, Object> updateBorderStock(HashMap<String, Object> map) throws Exception{
		// 재고처리(입고, 출고)
		switch ((String) map.get("type")) {
		case "in" : 
			if(ord.updateReturnInfo(map) > 0) map.put("message", "입고처리가 완료되었습니다.");
			else map.put("message", "입고처리가 실패하였습니다.");
			break;
		case "out" :
			if(ord.updateBorderInfo(map) > 0) map.put("message", "출고처리가 완료되었습니다."); 
			else map.put("message", "출고처리가 실패하였습니다.");
			break;
		default:
			if(ord.insertWhouseHousing(map) > 0)
				if(ord.updateWhouseStock(map) > 0)
					System.err.println("message ======== 실패");
					this.getOrderReturnList(map);
					this.getOrderReturnDetailList(map);
			break;
		}

		return map;
	}
	
	private HashMap<String, Object> paging (HashMap<String, Object> map) {
		int pageNum = Integer.parseInt((String) map.get("pageNum")),
				end = Integer.parseInt((String) map.get("listCount")),
				start = (pageNum - 1) * end;

		map.put("startPage", start);
		map.put("endPage", end);
		
		return map;
	}
}
