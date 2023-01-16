package kr.happyjob.study.cmp.model;


public class OrderConfirmModel {
	private int bordCode;
	private String companyName;
	private int modelCode;
	private String pdName;
	private int bordAmt;
	private String total;
	private String dirDate;
	private String bordType;
	private String typeName;
	
	private String keyword;
	private String startDate;
	private String endDate;
	private int startPage;
	private int endPage;
	
	
	
	public int getBordCode() {
		return bordCode;
	}
	public void setBordCode(int bordCode) {
		this.bordCode = bordCode;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getModelCode() {
		return modelCode;
	}
	public void setModelCode(int modelCode) {
		this.modelCode = modelCode;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public int getBordAmt() {
		return bordAmt;
	}
	public void setBordAmt(int bordAmt) {
		this.bordAmt = bordAmt;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getDirDate() {
		return dirDate;
	}
	public void setDirDate(String dirDate) {
		this.dirDate = dirDate;
	}
	public String getBordType() {
		return bordType;
	}
	public void setBordType(String bordType) {
		this.bordType = bordType;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
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
		return "OrderConfirmModel [bordCode=" + bordCode + ", companyName=" + companyName + ", modelCode=" + modelCode
				+ ", pdName=" + pdName + ", bordAmt=" + bordAmt + ", total=" + total + ", dirDate=" + dirDate
				+ ", bordType=" + bordType + ", typeName=" + typeName + ", keyword=" + keyword + ", startDate="
				+ startDate + ", endDate=" + endDate + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
	
}
