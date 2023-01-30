package kr.happyjob.study.cmp.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cmp.model.SalesRankingModel;

public interface SalesRankingDAO {
	// 매출 상위 10개 가져오기 + 기간 조회
	public List<SalesRankingModel> getSalesRankingList (HashMap<String, Object> map);
}
