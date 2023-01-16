package kr.happyjob.study.cmp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmp.dao.OrderConfirmDao;
import kr.happyjob.study.cmp.model.OrderConfirmModel;

@Service
public class OrderConfirmServiceImpl implements OrderConfirmService {
	
	@Autowired
	OrderConfirmDao ocd;
	
	@Override
	public HashMap<String, Object> orderConfirmList(HashMap<String, Object> map) throws Exception {
		this.paging(map);
		map.put("orderConfirmList", ocd.orderConfirmList(map));
		map.put("orderConfirmCount", ocd.orderConfirmCount(map));
		return map;		
	}

	@Override
	public int updateBorderType(HashMap<String, Object> map) throws Exception {		
		return ocd.updateBorderType(map);
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