package kr.happyjob.study.pur.service;

import java.util.HashMap;

public interface ReturnPurchaseInter {
	public HashMap<String, Object> getPurReturnDirectionList(HashMap<String, Object> map) throws Exception;
	public HashMap<String, Object> updatePurReturnDirection(HashMap<String, Object> map) throws Exception;
}
