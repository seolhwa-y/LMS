package kr.happyjob.study.scm.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.cor.model.RefundHistoryModel;

public interface PurchaseDirectionDAO {
	public List<RefundHistoryModel> getPurDirectionList(HashMap<String, Object> map) throws Exception;
	public int getPurDirectionCount(HashMap<String, Object> map) throws Exception;
}
