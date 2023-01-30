package kr.happyjob.study.pur.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pur.dao.PurPurchaseDirectionDAO;

@Service
public class PurPurchaseDirectionService implements PurPurchaseDirectionInter{
	@Autowired
	PurPurchaseDirectionDAO pdd;
	
	public PurPurchaseDirectionService() {}
	
	// 발주지시서 리스트 + 카운트(상세보기 포함)
	public HashMap<String, Object> getPurDirectionList(HashMap<String, Object> map) throws Exception {
		this.paging(map);
		map.put("purDirectionList", pdd.getPurDirectionList(map));
		map.put("purDirectionCount", pdd.getPurDirectionCount(map));
		
		return map;
	}
	// 발주지시서 타입 업데이트
	public int updatePurDirectionType(HashMap<String, Object> map) throws Exception {
		return pdd.updatePurDirectionType(map); 
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
