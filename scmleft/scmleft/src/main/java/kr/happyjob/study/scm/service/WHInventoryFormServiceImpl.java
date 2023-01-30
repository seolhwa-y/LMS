package kr.happyjob.study.scm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.WHInventoryFormDao;
import kr.happyjob.study.scm.model.WHInventoryFormModel;


@Service
public class WHInventoryFormServiceImpl implements WHInventoryFormService {

	@Autowired
	private WHInventoryFormDao dao;

	@Override
	public List<WHInventoryFormModel> getList(Map<String, Object> paramMap) {
		return dao.getList(paramMap);
	}

	@Override
	public int countList(Map<String, Object> paramMap) {
		return dao.countList(paramMap);
	}

	@Override
	public List<WHInventoryFormModel> SgetList(Map<String, Object> paramMap) {
		return dao.SgetList(paramMap);
	}

	@Override
	public int ScountList(Map<String, Object> paramMap) {
		return dao.ScountList(paramMap);
	}

	
}
