package kr.happyjob.study.pur.model;

public class PurPurchaseDirectionModel {
	private int bordCode;
	private String pdName;
	private String companyName;
	private String name;
	private String bordAmt;
	private String pdPrice;
	private String total;
	private String whName;
	private String dirDate;
	private int bordType;
	private String typeName;
               
	private String type;
	private String keyword;
	private String startData;
	private String endData;
	private int startPage;
	private int endPage;
	
	
	
	public int getBordCode() {
		return bordCode;
	}
	public void setBordCode(int bordCode) {
		this.bordCode = bordCode;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getDirDate() {
		return dirDate;
	}
	public void setDirDate(String dirDate) {
		this.dirDate = dirDate;
	}
	public int getBordType() {
		return bordType;
	}
	public void setBordType(int bordType) {
		this.bordType = bordType;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
	public String getStartData() {
		return startData;
	}
	public void setStartData(String startData) {
		this.startData = startData;
	}
	public String getEndData() {
		return endData;
	}
	public void setEndData(String endData) {
		this.endData = endData;
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
		return "PurPurchaseDirectionModel [bordCode=" + bordCode + ", pdName=" + pdName + ", companyName=" + companyName
				+ ", name=" + name + ", bordAmt=" + bordAmt + ", pdPrice=" + pdPrice + ", total=" + total + ", whName="
				+ whName + ", dirDate=" + dirDate + ", bordType=" + bordType + ", typeName=" + typeName + ", type="
				+ type + ", keyword=" + keyword + ", startData=" + startData + ", endData=" + endData + ", startPage="
				+ startPage + ", endPage=" + endPage + "]";
	}
	
	
}
