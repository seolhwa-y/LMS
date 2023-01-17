package kr.happyjob.study.pur.model;

public class ReturnPurchaseModel {
	private int reCode;
	private int bordCode;
	private String companyName;
	private String dirDate;
	private String name;
	private String pdName;
	private String reAmt;
	private String total;
	private String whName;
	private String reType;
	private String typeName;
	private String reOut;
	private String outName;
	
	private String type;
	private String keyword;
	private String startDate;
	private String endDate;
	private String startPage;
	private String endPage;
	
	

	public int getReCode() {
		return reCode;
	}
	public void setReCode(int reCode) {
		this.reCode = reCode;
	}
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
	public String getDirDate() {
		return dirDate;
	}
	public void setDirDate(String dirDate) {
		this.dirDate = dirDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public String getReAmt() {
		return reAmt;
	}
	public void setReAmt(String reAmt) {
		this.reAmt = reAmt;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getWhName() {
		return whName;
	}
	public void setWhName(String whName) {
		this.whName = whName;
	}
	public String getReType() {
		return reType;
	}
	public void setReType(String reType) {
		this.reType = reType;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getReOut() {
		return reOut;
	}
	public void setReOut(String reOut) {
		this.reOut = reOut;
	}
	public String getOutName() {
		return outName;
	}
	public void setOutName(String outName) {
		this.outName = outName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getStartPage() {
		return startPage;
	}
	public void setStartPage(String startPage) {
		this.startPage = startPage;
	}
	public String getEndPage() {
		return endPage;
	}
	public void setEndPage(String endPage) {
		this.endPage = endPage;
	}
	
	
	@Override
	public String toString() {
		return "ReturnPurchaseModel [reCode=" + reCode + ", bordCode=" + bordCode + ", companyName=" + companyName
				+ ", dirDate=" + dirDate + ", name=" + name + ", pdName=" + pdName + ", reAmt=" + reAmt + ", total="
				+ total + ", whName=" + whName + ", reType=" + reType + ", typeName=" + typeName + ", reOut=" + reOut
				+ ", outName=" + outName + ", type=" + type + ", keyword=" + keyword + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
}
