package kr.happyjob.study.cor.service;

import java.util.HashMap;

public interface RefundHistoryInter {
	// 반품현황 가져오기
	public HashMap<String, Object> getReturnList(HashMap<String, Object> map) throws Exception;

}
