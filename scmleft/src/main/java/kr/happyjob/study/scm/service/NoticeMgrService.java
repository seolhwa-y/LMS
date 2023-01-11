package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.NoticeMgrDAO;
import kr.happyjob.study.scm.model.NoticeMgrModel;

@Service
public class NoticeMgrService implements NoticeMgrInter {
	
	@Autowired
	NoticeMgrDAO nd;
	
	public NoticeMgrService() {}
	
	@Override
	public List<NoticeMgrModel> getNoticeList(Map<String, Object> map) {
		return nd.getNoticeList(map);
	}
	
	@Override
	public int insertNotice(Map<String, Object> map) {
		return nd.insertNotice(map);
	}
	
	@Override
	public int updateNotice(Map<String, Object> map) {
		return nd.updateNotice(map);
	}
	
	@Override
	public int deleteNotice(Map<String, Object> map) {
		return nd.deleteNotice(map);
	}

}
