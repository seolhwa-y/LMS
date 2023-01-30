package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.WHInventoryFormModel;

public interface WHInventoryFormDao {

	List<WHInventoryFormModel> getList(Map<String, Object> paramMap);

	int countList(Map<String, Object> paramMap);

	List<WHInventoryFormModel> SgetList(Map<String, Object> paramMap);

	int ScountList(Map<String, Object> paramMap);

	
}
