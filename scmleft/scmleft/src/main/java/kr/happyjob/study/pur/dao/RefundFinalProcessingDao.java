
package kr.happyjob.study.pur.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pur.model.RefundFinalProcessingModel;


public interface RefundFinalProcessingDao {

	public List<RefundFinalProcessingModel> refundFinalProcessingList(Map<String, Object> paramMap) throws Exception;

	public int returnOrderCnt(Map<String, Object> paramMap) throws Exception;

	public List<RefundFinalProcessingModel> returnOrderDetail(Map<String, Object> paramMap) throws Exception;

	public int orderCount(Map<String, Object> paramMap) throws Exception;

	public RefundFinalProcessingModel refundFinalProcessOne(Map<String, Object> paramMap) throws Exception;


}
