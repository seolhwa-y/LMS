package kr.happyjob.study.pur.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pur.model.ReturnPurchaseModel;


public interface ReturnPurchaseService {


	public List<ReturnPurchaseModel> returnPurchaseList(Map<String, Object> paramMap) throws Exception;

	public int returnOrderCnt(Map<String, Object> paramMap) throws Exception;

	public List<ReturnPurchaseModel> returnOrderDetail(Map<String, Object> paramMap) throws Exception;

	public int orderCount(Map<String, Object> paramMap) throws Exception;

	public ReturnPurchaseModel returnPurchaseOne(Map<String, Object> paramMap) throws Exception;



}
