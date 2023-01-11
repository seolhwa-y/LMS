package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.NoticeMgrModel;

public interface NoticeMgrDAO {
	public List<NoticeMgrModel> getNoticeList(Map<String, Object> map);
	public int getNoticeCnt(Map<String, Object> map);
	public int insertNotice(Map<String, Object> map);
	public int updateNotice(Map<String, Object> map);
	public int deleteNotice(Map<String, Object> map);
}
