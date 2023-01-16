package kr.happyjob.study.cmp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.OrderConfirmModel;

public interface OrderConfirmService {
	public HashMap<String, Object> orderConfirmList(HashMap<String, Object> map) throws Exception;
	public int updateBorderType(HashMap<String, Object> map) throws Exception;
}