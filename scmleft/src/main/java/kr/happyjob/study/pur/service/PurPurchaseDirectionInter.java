package kr.happyjob.study.pur.service;

import java.util.HashMap;

public interface PurPurchaseDirectionInter {
	// 발주지시서 리스트 + 카운트(상세보기 포함)
	public HashMap<String, Object> getPurDirectionList(HashMap<String, Object> map) throws Exception;
	// 발주지시서 타입 업데이트
	public int updatePurDirectionType(HashMap<String, Object> map) throws Exception;
}
