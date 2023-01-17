package kr.happyjob.study.ship.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.ship.model.OrderReturnModel;

public interface OrderReturnDAO {
	public List<OrderReturnModel> getOrderReturnList(HashMap<String, Object> map) throws Exception;
	public int getOrderReturnCount(HashMap<String, Object> map) throws Exception;
	public List<OrderReturnModel> getOrderReturnDetailList(HashMap<String, Object> map) throws Exception;
	int getOrderReturnDetailCount(HashMap<String, Object> map) throws Exception;
	public int insertReturnDirection(HashMap<String, Object> map) throws Exception;
	public int insertReturnInfo(HashMap<String, Object> map) throws Exception;
	public int insertWhouseHousing(HashMap<String, Object> map) throws Exception;
	public int updateWhouseStock(HashMap<String, Object> map) throws Exception;
	public int updateReturnInfo(HashMap<String, Object> map) throws Exception;
}
