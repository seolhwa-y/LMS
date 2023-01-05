package kr.happyjob.study.cmp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmp.dao.OrderConfirmDao;
import kr.happyjob.study.cmp.model.OrderConfirmModel;

@Service
public class OrderConfirmServiceImpl implements OrderConfirmService {
	
	@Autowired
	OrderConfirmDao orderconfirmdao;
	
	public List<OrderConfirmModel> orderConfirmMgt(Map<String, Object> paramMap) throws Exception {
		return orderconfirmdao.orderConfirmMgt(paramMap);		
	}

	public int orderConfirmMgtcnt(Map<String, Object> paramMap) throws Exception {		
		return orderconfirmdao.orderConfirmMgtcnt(paramMap);
	}
		
}