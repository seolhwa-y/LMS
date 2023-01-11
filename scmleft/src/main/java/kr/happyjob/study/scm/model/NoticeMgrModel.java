package kr.happyjob.study.scm.model;

public class NoticeMgrModel {

	private int notCode;
	private String notTitle;
	private String notCon;
	private String notDate;
	private int notView;
	private String loginId;
	private String name;
	
	private String type;
	private String startDate;
	private String endDate;
	private int startPage;
	private int endPage;
	
	
	public int getNotCode() {
		return notCode;
	}
	public void setNotCode(int notCode) {
		this.notCode = notCode;
	}
	public String getNotTitle() {
		return notTitle;
	}
	public void setNotTitle(String notTitle) {
		this.notTitle = notTitle;
	}
	public String getNotCon() {
		return notCon;
	}
	public void setNotCon(String notCon) {
		this.notCon = notCon;
	}
	public String getNotDate() {
		return notDate;
	}
	public void setNotDate(String notDate) {
		this.notDate = notDate;
	}
	public int getNotView() {
		return notView;
	}
	public void setNotView(int notView) {
		this.notView = notView;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	@Override
	public String toString() {
		return "NoticeModel [notCode=" + notCode + ", notTitle=" + notTitle + ", notCon=" + notCon + ", notDate="
				+ notDate + ", notView=" + notView + ", loginId=" + loginId + ", name=" + name + ", type=" + type
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", startPage=" + startPage + ", endPage="
				+ endPage + "]";
	}
	
}
