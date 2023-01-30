package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ShippingDirectionDao;
import kr.happyjob.study.scm.model.ShippingDirectionModel;

@Service
public class ShippingDirectionServiceImpl implements ShippingDirectionService {
	
	//private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	ShippingDirectionDao shippingDirectionDao;
	

	@Override
	public List<ShippingDirectionModel> shippingDirectionList(Map<String, Object> paramMap) throws Exception {
		return shippingDirectionDao.shippingDirectionList(paramMap);
		
	}


	@Override
	public int shippingDirectionListCnt(Map<String, Object> paramMap) throws Exception {
		
		return shippingDirectionDao.shippingDirectionListCnt(paramMap);
	}
	
	
	//클릭한 배송지시서 단건 조회
	 @Override
	 public ShippingDirectionModel shippingDirectionListOne(Map<String, Object> paramMap) throws Exception {
		return shippingDirectionDao.shippingDirectionListOne(paramMap);
			
		}
}
