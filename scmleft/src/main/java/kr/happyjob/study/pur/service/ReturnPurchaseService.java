package kr.happyjob.study.pur.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pur.dao.ReturnPurchaseDAO;

@Service
public class ReturnPurchaseService implements ReturnPurchaseInter{

	@Autowired
	ReturnPurchaseDAO prdd;
	
	public ReturnPurchaseService() {}

	public HashMap<String, Object> getPurReturnDirectionList(HashMap<String, Object> map) throws Exception{
		this.paging(map);
		map.put("purReturnDirectionList", prdd.getPurReturnDirectionList(map));
		map.put("purReturnDirectionCount", prdd.getPurReturnDirectionCount(map));
		
		return map;
	}
	
	public HashMap<String, Object> updatePurReturnDirection(HashMap<String, Object> map) throws Exception{
		if(prdd.updatePurDirectionType(map) > 0) {
			map.put("message", "입금처리가 완료되었습니다.");
		} else map.put("message", "입금처리가 실패하였습니다.");
		
		this.getPurReturnDirectionList(map);
		
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
