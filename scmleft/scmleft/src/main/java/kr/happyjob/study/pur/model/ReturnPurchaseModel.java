package kr.happyjob.study.pur.model;

import java.sql.Date;

public class ReturnPurchaseModel {

	private String RE_CODE;	//반품코드
	private String loginID;	//반품회사
	private String PD_NAME;	//제품명
	private int RE_AMT;		//반품개수
	private String RE_DATE;	//날짜
	private int RE_TYPE;	//입금
	
	private Date sdate;
	private Date edate;
	private String cpname;
	private String pdname;
	private String approved;
	private String unapproved;
	private int currentPage;  
	private int pageSize;  
	private int pageIndex; 
	
	
	@Override
	public String toString() {
		return "returnPurchaseModel [RE_CODE=" + RE_CODE + ", loginID=" + loginID + ", PD_NAME=" + PD_NAME + ", RE_AMT="
				+ RE_AMT + ", RE_DATE=" + RE_DATE + ", RE_TYPE=" + RE_TYPE + ", sdate=" + sdate + ", edate=" + edate
				+ ", cpname=" + cpname + ", pdname=" + pdname + ", approved=" + approved + ", unapproved=" + unapproved
				+ ", currentPage=" + currentPage + ", pageSize=" + pageSize + ", pageIndex=" + pageIndex + "]";
	}
	
	
	public int getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getPageIndex() {
		return pageIndex;
	}


	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}


	public String getRE_CODE() {
		return RE_CODE;
	}
	public void setRE_CODE(String rE_CODE) {
		RE_CODE = rE_CODE;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getPD_NAME() {
		return PD_NAME;
	}
	public void setPD_NAME(String pD_NAME) {
		PD_NAME = pD_NAME;
	}
	public int getRE_AMT() {
		return RE_AMT;
	}
	public void setRE_AMT(int rE_AMT) {
		RE_AMT = rE_AMT;
	}
	public String getRE_DATE() {
		return RE_DATE;
	}
	public void setRE_DATE(String rE_DATE) {
		RE_DATE = rE_DATE;
	}
	public int getRE_TYPE() {
		return RE_TYPE;
	}
	public void setRE_TYPE(int rE_TYPE) {
		RE_TYPE = rE_TYPE;
	}
	public Date getSdate() {
		return sdate;
	}
	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
	public Date getEdate() {
		return edate;
	}
	public void setEdate(Date edate) {
		this.edate = edate;
	}
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public String getPdname() {
		return pdname;
	}
	public void setPdname(String pdname) {
		this.pdname = pdname;
	}
	public String getApproved() {
		return approved;
	}
	public void setApproved(String approved) {
		this.approved = approved;
	}
	public String getUnapproved() {
		return unapproved;
	}
	public void setUnapproved(String unapproved) {
		this.unapproved = unapproved;
	}
	
	
}
