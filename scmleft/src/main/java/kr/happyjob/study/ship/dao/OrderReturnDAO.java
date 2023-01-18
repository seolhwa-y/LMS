package kr.happyjob.study.ship.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.ship.model.OrderReturnModel;

public interface OrderReturnDAO {
	// 발주지시
	public List<OrderReturnModel> getOrderReturnList(HashMap<String, Object> map) throws Exception;
	public int getOrderReturnCount(HashMap<String, Object> map) throws Exception;
	// 발주지시서 상세보
	public List<OrderReturnModel> getOrderReturnDetailList(HashMap<String, Object> map) throws Exception;
	int getOrderReturnDetailCount(HashMap<String, Object> map) throws Exception;
	// 반품신청
	public int insertReturnInfo(HashMap<String, Object> map) throws Exception;
	// 재고처리 (입고, 출고)
	public int updateBorderInfo(HashMap<String, Object> map) throws Exception;
	public int insertWhouseHousing(HashMap<String, Object> map) throws Exception;
	public int updateWhouseStock(HashMap<String, Object> map) throws Exception;
	public int updateReturnInfo(HashMap<String, Object> map) throws Exception;
}
