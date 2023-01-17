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
		return map;
	}
	
	@Override
	public HashMap<String, Object> getOrderReturnDetailList(HashMap<String, Object> map) throws Exception{
		return map;
	}
	
	@Override
	public HashMap<String, Object> insertBorderReturn(HashMap<String, Object> map) throws Exception{
		return map;
	}
	
	@Override
	public HashMap<String, Object> updateBorderStock(HashMap<String, Object> map) throws Exception{
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
