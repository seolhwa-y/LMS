package kr.happyjob.study.scm.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.PurchaseDirectionDAO;

@Service
public class PurchaseDirectionService implements PurchaseDirectionInter{

	@Autowired
	PurchaseDirectionDAO pdd;
	
	public PurchaseDirectionService() {}

	// 발주리스트 가져오기
	@Override
	public HashMap<String, Object> getPurDirectionList(HashMap<String, Object> map) throws Exception {
		this.paging(map);
		map.put("purDirectionList", pdd.getPurDirectionList(map));
		map.put("purDirectionCount", pdd.getPurDirectionCount(map));
		
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
