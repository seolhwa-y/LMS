package kr.happyjob.study.cmp.model;

import org.springframework.stereotype.Component;

//lombok 사용 X
@Component
public class SalesRankingModel {
	private String loginId; // 기업코드
	private String companyName; // 기업이름
	private String total; // 매출합계
	
	// 파라미터 값 나중에 추가하기
	
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	
	
}
