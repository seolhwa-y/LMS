package kr.happyjob.study.cmp.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmp.model.OrderConfirmModel;

public interface OrderConfirmService {

	public List<OrderConfirmModel> orderConfirmMgt(Map<String, Object> paramMap) throws Exception;

	public int orderConfirmMgtcnt(Map<String, Object> paramMap) throws Exception;
	

}