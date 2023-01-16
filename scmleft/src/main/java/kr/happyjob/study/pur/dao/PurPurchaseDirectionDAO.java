package kr.happyjob.study.pur.dao;

import java.util.HashMap;
import java.util.List;

import kr.happyjob.study.pur.model.PurPurchaseDirectionModel;

public interface PurPurchaseDirectionDAO {
	public List<PurPurchaseDirectionModel> getPurDirectionList(HashMap<String, Object> map) throws Exception;
	public int getPurDirectionCount(HashMap<String, Object> map) throws Exception;
	public int updatePurDirectionType(HashMap<String, Object> map) throws Exception;
}
