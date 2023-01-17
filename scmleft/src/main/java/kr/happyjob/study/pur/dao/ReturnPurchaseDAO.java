package kr.happyjob.study.pur.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.RefundHistoryModel;

public interface ReturnPurchaseDAO {
	public List<RefundHistoryModel> getPurReturnDirectionList(HashMap<String, Object> map) throws Exception;
	public int getPurReturnDirectionCount(HashMap<String, Object> map) throws Exception;
	public int updatePurDirectionType(HashMap<String, Object> map) throws Exception;
}
