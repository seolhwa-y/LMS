package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ProductInfoDao;
import kr.happyjob.study.scm.model.ProductInfoModel;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {
	
	//private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	ProductInfoDao productInfoDao;
	

	@Override
	public List<ProductInfoModel> productInfoList(Map<String, Object> paramMap) throws Exception {
		return productInfoDao.productInfoList(paramMap);
		
	}


	@Override
	public int productInfoListCnt(Map<String, Object> paramMap) throws Exception {
		
		return productInfoDao.productInfoListCnt(paramMap);
	}
	
	//클릭한 배송지시서 단건 조회
	@Override
	public ProductInfoModel productOne(Map<String, Object> paramMap) throws Exception {
		return productInfoDao.productOne(paramMap);
				
		}
			
}
