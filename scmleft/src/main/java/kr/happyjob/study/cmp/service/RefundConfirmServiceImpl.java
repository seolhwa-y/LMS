package kr.happyjob.study.cmp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmp.dao.RefundConfirmDao;
import kr.happyjob.study.cmp.model.RefundConfirmModel;

@Service
public class RefundConfirmServiceImpl implements RefundConfirmService {
	
	@Autowired
	RefundConfirmDao refundconfirmdao;
	
	public List<RefundConfirmModel> refundConfirmMgt(Map<String, Object> paramMap) throws Exception {
		return refundconfirmdao.refundConfirmMgt(paramMap);		
	}

	public int refundConfirmMgtcnt(Map<String, Object> paramMap) throws Exception {		
		return refundconfirmdao.refundConfirmMgtcnt(paramMap);
	}
	@Override
	public void SclickRefundConfirm(Map<String, Object> paramMap) {
		
		refundconfirmdao.SclickRefundConfirm(paramMap);
		
	}

	
	
	
}