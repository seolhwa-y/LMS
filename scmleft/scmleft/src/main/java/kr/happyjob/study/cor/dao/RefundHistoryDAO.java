package kr.happyjob.study.cor.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.RefundHistoryModel;

public interface RefundHistoryDAO {
	public List<RefundHistoryModel> getReturnList(HashMap<String, Object> map) throws Exception;
	public int getReturnCount(HashMap<String, Object> map) throws Exception;
}
	