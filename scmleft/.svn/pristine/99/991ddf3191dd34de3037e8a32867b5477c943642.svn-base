package kr.happyjob.study.ship.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ship.dao.DeliveryBuyerDao;
import kr.happyjob.study.ship.model.DeliveryBuyerModel;

@Service
public class DeliveryBuyerServiceImpl implements DeliveryBuyerService {
	
	//private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	DeliveryBuyerDao deliveryBuyerDao;


	//배송지시서 리스트 조회
	@Override
	public List<DeliveryBuyerModel> deliveryBuyerList(Map<String, Object> paramMap) throws Exception {
		return deliveryBuyerDao.deliveryBuyerList(paramMap);
		
	}

	//목록 수 추출
	@Override
	public int deliveryBuyerListCnt(Map<String, Object> paramMap) throws Exception {
		return deliveryBuyerDao.deliveryBuyerListCnt(paramMap);
	}
		
	//클릭한 배송지시서 단건 조회
	@Override
	public DeliveryBuyerModel deliveryListOne(Map<String, Object> paramMap) throws Exception {
		return deliveryBuyerDao.deliveryListOne(paramMap);			
		}
	 
	//출고 insert		
	 @Override
	 public int insertDelHousing(Map<String, Object> paramMap)throws Exception{
		 return deliveryBuyerDao.insertDelHousing(paramMap);		
	 }
	 
	 //재고 update
	 @Override
		public int updateDelStock(Map<String, Object> paramMap) throws Exception {
			return deliveryBuyerDao.updateDelStock(paramMap);			
			}
	 
	 //배송여부 update
	 @Override
		public int updateDel(Map<String, Object> paramMap) throws Exception {
			return deliveryBuyerDao.updateDel(paramMap);			
			}		
}
