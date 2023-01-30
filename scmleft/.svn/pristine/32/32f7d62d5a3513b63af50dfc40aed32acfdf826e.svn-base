package kr.happyjob.study.cor.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cor.dao.RefundHistoryDAO;

@Service
public class RefundHistoryService implements RefundHistoryInter {
	@Autowired
	RefundHistoryDAO rhd;
	
	public RefundHistoryService() {}
	
	// 반품현황 가져오기
	@Override
	public HashMap<String, Object> getReturnList(HashMap<String, Object> map) throws Exception {
		this.paging(map);
		map.put("returnList", rhd.getReturnList(map));
		map.put("returnCount", rhd.getReturnCount(map));
		
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
