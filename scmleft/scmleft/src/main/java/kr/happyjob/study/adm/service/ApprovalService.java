package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ApprovalModel;

public interface ApprovalService {
	
	// 신고서 목록 리스트 조회
	public List<ApprovalModel> listApproval(Map<String,Object> paramMap) throws Exception;
	
	// 신고서 목록 카운트 조회
	public int approvalCnt(Map<String, Object> paramMap)throws Exception;
	
	// 신고서 상세 리스트 조회
	public ApprovalModel listApprovalDtl(Map<String,Object> paramMap) throws Exception;
	
	// 신고서 단건 조회
	public ApprovalModel selectApprovalCod(Map<String, Object> paramMap) throws Exception;
	
	// 신고서 신규 등록
	public void insertapprovalcode(Map<String, Object> paramMap) throws Exception; 
	
	// 신고서 승인 및 반려
	public int updateApprovalCod(Map<String, Object> paramMap) throws Exception;
	
	// 신고서 수정
	public void updateApprovalMedicalCod(Map<String, Object> paramMap) throws Exception;

	// 수리업 신고서 조회
	public ApprovalModel medicalRepairDtl(Map<String,Object> paramMap) throws Exception;

	// 수리업 신고서 신규 등록
	public void insertmedicalcode(Map<String, Object> paramMap) throws Exception; 
	
	// 수리업 신고서 신규 등록
	public void insertSaleRentcode(Map<String, Object> paramMap) throws Exception;
}
