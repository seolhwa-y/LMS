package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.comcombo;

public interface ComnComboDao {


	/** 제품  목록 조회 */
	public List<comcombo> selectproductlist(Map<String, Object> paramMap);
		
	/** 창고 담당자  목록 조회 */
	public List<comcombo> selectwhpersonlist(Map<String, Object> paramMap);
			
	/** 창고 목록 조회 */
	public List<comcombo> selectwhlist(Map<String, Object> paramMap);
	
	/** 창고 담당자 이름, LoginID 조회 */
	public List<comcombo> selectwhMnglist(Map<String, Object> paramMap);
	
	/** 공급처명 조회*/
	public List<comcombo> selectSPlist(Map<String, Object> paramMap);
	
    /** 제품 분류별  목록 조회 */
    public List<comcombo> selectdivproductlist(Map<String, Object> paramMap);
  

}
