package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.NoticeMgrModel;

public interface NoticeMgrInter {
	public List<NoticeMgrModel> getNoticeList(Map<String, Object> map) throws Exception;
	public int insertNotice(Map<String, Object> map) throws Exception;
	public int updateNotice(Map<String, Object> map) throws Exception;
	public int deleteNotice(Map<String, Object> map) throws Exception;
}
