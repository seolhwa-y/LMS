package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.ApprovalDao;
import kr.happyjob.study.adm.model.ApprovalModel;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   ApprovalDao approvalDao;
	 
   // 신고서 목록 리스트 조회
   @Override
   public List<ApprovalModel> listApproval(Map<String,Object> paramMap) throws Exception {
	   
	   List<ApprovalModel> approvalList = approvalDao.listApproval(paramMap);
	 
	   return approvalList;
   }

   // 신고서 목록 카운트 조회
   @Override
   public int approvalCnt(Map<String, Object> paramMap)throws Exception {
	   
	   int approvalCnt = approvalDao.approvalCnt(paramMap);
	   
	   return approvalCnt;
   }
   
   // 신고서 상세 리스트 조회
   @Override
   public ApprovalModel listApprovalDtl(Map<String,Object> paramMap) throws Exception {
	   
	   ApprovalModel approvalListDtl = approvalDao.listApprovalDtl(paramMap);
	 
	   return approvalListDtl;
   }
   
   // 신고서 단건 조회
   @Override
   public ApprovalModel selectApprovalCod(Map<String,Object> paramMap) throws Exception {
	   
	   ApprovalModel ApprovalModel = approvalDao.selectApprovalCod(paramMap);
	 
	   return ApprovalModel;
   }
   
   // 신고서 신규 등록
   public void insertapprovalcode(Map<String, Object> paramMap) throws Exception {
	   
	   approvalDao.insertapprovalcode(paramMap);
   
   }
   
   // 신고서 승인 및 반려
   public int updateApprovalCod(Map<String, Object> paramMap) throws Exception {
	   
	   int approvaldisoragree = approvalDao.updateApprovalCod(paramMap);
	   
	   return approvaldisoragree;
   }
   
   // 신고서 수정
	public void updateApprovalMedicalCod(Map<String, Object> paramMap) throws Exception {
		
		approvalDao.updateApprovalMedicalCod(paramMap);
		
	}
	
   // 수리업 신고서 조회
   @Override
   public ApprovalModel medicalRepairDtl(Map<String,Object> paramMap) throws Exception {
	   
	   ApprovalModel medicalRepairDtl = approvalDao.medicalRepairDtl(paramMap);
	 
	   return medicalRepairDtl;
   }
   
   // 수리업 신고서 신규 등록
   public void insertmedicalcode(Map<String, Object> paramMap) throws Exception {
	   
	   approvalDao.insertmedicalcode(paramMap);
   
   }
   
   // 판매업 신고서 신규 등록
   public void insertSaleRentcode(Map<String, Object> paramMap) throws Exception {
	   
	   approvalDao.insertSaleRentcode(paramMap);
   
   }
}
