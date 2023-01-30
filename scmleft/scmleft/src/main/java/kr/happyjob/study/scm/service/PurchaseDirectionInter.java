package kr.happyjob.study.scm.service;

import java.util.HashMap;

public interface PurchaseDirectionInter {
	// 발주리스트 가져오기 가져오기
	public HashMap<String, Object> getPurDirectionList(HashMap<String, Object> map) throws Exception;
}
