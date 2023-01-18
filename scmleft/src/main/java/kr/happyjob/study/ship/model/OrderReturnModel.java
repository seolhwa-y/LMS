package kr.happyjob.study.ship.model;

public class OrderReturnModel {
	private String loginId;
	private String companyName;
	private String total;
	private int bordCode;
	private int modelCode;
	private String modelName;
	private String pdName;
	private String pdCode;
	private String pdCorp;
	private String dirDate;
	private String bordAmt;
	private String pdPrice;
	private int whCode;
	private String whName;
	private int reCode;
	private String reOut;
	
	private String type;
	private String keyword;
	private String startDate;
	private String endDate;
	private int startPage;
	private int endPage;
	
	
	
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
	public int getBordCode() {
		return bordCode;
	}
	public void setBordCode(int bordCode) {
		this.bordCode = bordCode;
	}
	public int getModelCode() {
		return modelCode;
	}
	public void setModelCode(int modelCode) {
		this.modelCode = modelCode;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public String getPdCode() {
		return pdCode;
	}
	public void setPdCode(String pdCode) {
		this.pdCode = pdCode;
	}
	public String getPdCorp() {
		return pdCorp;
	}
	public void setPdCorp(String pdCorp) {
		this.pdCorp = pdCorp;
	}
	public String getDirDate() {
		return dirDate;
	}
	public void setDirDate(String dirDate) {
		this.dirDate = dirDate;
	}
	public String getBordAmt() {
		return bordAmt;
	}
	public void setBordAmt(String bordAmt) {
		this.bordAmt = bordAmt;
	}
	public String getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(String pdPrice) {
		this.pdPrice = pdPrice;
	}
	public int getWhCode() {
		return whCode;
	}
	public void setWhCode(int whCode) {
		this.whCode = whCode;
	}
	public String getWhName() {
		return whName;
	}
	public void setWhName(String whName) {
		this.whName = whName;
	}
	public int getReCode() {
		return reCode;
	}
	public void setReCode(int reCode) {
		this.reCode = reCode;
	}
	public String getReOut() {
		return reOut;
	}
	public void setReOut(String reOut) {
		this.reOut = reOut;
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
		return "OrderReturnModel [loginId=" + loginId + ", companyName=" + companyName + ", total=" + total
				+ ", bordCode=" + bordCode + ", modelCode=" + modelCode + ", modelName=" + modelName + ", pdName="
				+ pdName + ", pdCode=" + pdCode + ", pdCorp=" + pdCorp + ", dirDate=" + dirDate + ", bordAmt=" + bordAmt
				+ ", pdPrice=" + pdPrice + ", whCode=" + whCode + ", whName=" + whName + ", reCode=" + reCode
				+ ", reOut=" + reOut + ", type=" + type + ", keyword=" + keyword + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	

}
