package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ReturnDirVO;

public interface ReturnDirService {

	public List<ReturnDirVO> returnDirList(Map<String, Object> paramMap) throws Exception;
	
	public int returnDirTotalCnt(Map<String, Object> paramMap) throws Exception;

}