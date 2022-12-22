package kr.happyjob.study.cmp.model;

import org.springframework.stereotype.Repository;

//lombok 사용 X
@Repository
public class SalesRankingModel {
	private String startDate;
	private String endDate;
	
	private String loginId; // 기업코드
	private String companyName; // 기업이름
	private int total; // 매출합계
	
	
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
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}
