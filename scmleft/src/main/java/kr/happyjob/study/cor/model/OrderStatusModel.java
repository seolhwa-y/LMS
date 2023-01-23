package kr.happyjob.study.cor.model;

import org.springframework.stereotype.Repository;

@Repository
public class OrderStatusModel {
	private String startDate;
	private String endDate;
	private int startPage;
	private int endPage;
	private int jordNo;
	private int count;
	private int cnt;
	private long total;
	private String jordDate;
	private String jordWishdate;
	private String jordIn;
	private String shDate;
	private String shType;
	private String modelName;
	private String pdName;
	private String pdCode;
	private String pdCorp;
	private int pdPrice;
	private String jordAmt;
	private String loginId;
	private int bankCode;
	private String bankName;
	private String account;
	private int shCode;
	private int reCode;
	private int dirCode;
	private int jordCode; 
	private int whCode; 
	private int modelCode;
	private int bordCode;
	private int reAmt; 
	private String reDate;
	private String reType;
	private String reOut;
	
	
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
	public int getJordNo() {
		return jordNo;
	}
	public void setJordNo(int jordNo) {
		this.jordNo = jordNo;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public String getJordDate() {
		return jordDate;
	}
	public void setJordDate(String jordDate) {
		this.jordDate = jordDate;
	}
	public String getJordWishdate() {
		return jordWishdate;
	}
	public void setJordWishdate(String jordWishdate) {
		this.jordWishdate = jordWishdate;
	}
	public String getJordIn() {
		return jordIn;
	}
	public void setJordIn(String jordIn) {
		this.jordIn = jordIn;
	}
	public String getShDate() {
		return shDate;
	}
	public void setShDate(String shDate) {
		this.shDate = shDate;
	}
	public String getShType() {
		return shType;
	}
	public void setShType(String shType) {
		this.shType = shType;
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
	public int getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}
	public String getJordAmt() {
		return jordAmt;
	}
	public void setJordAmt(String jordAmt) {
		this.jordAmt = jordAmt;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public int getBankCode() {
		return bankCode;
	}
	public void setBankCode(int bankCode) {
		this.bankCode = bankCode;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getShCode() {
		return shCode;
	}
	public void setShCode(int shCode) {
		this.shCode = shCode;
	}
	public int getReCode() {
		return reCode;
	}
	public void setReCode(int reCode) {
		this.reCode = reCode;
	}
	public int getDirCode() {
		return dirCode;
	}
	public void setDirCode(int dirCode) {
		this.dirCode = dirCode;
	}
	public int getJordCode() {
		return jordCode;
	}
	public void setJordCode(int jordCode) {
		this.jordCode = jordCode;
	}
	public int getWhCode() {
		return whCode;
	}
	public void setWhCode(int whCode) {
		this.whCode = whCode;
	}
	public int getModelCode() {
		return modelCode;
	}
	public void setModelCode(int modelCode) {
		this.modelCode = modelCode;
	}
	public int getBordCode() {
		return bordCode;
	}
	public void setBordCode(int bordCode) {
		this.bordCode = bordCode;
	}
	public int getReAmt() {
		return reAmt;
	}
	public void setReAmt(int reAmt) {
		this.reAmt = reAmt;
	}
	public String getReDate() {
		return reDate;
	}
	public void setReDate(String reDate) {
		this.reDate = reDate;
	}
	public String getReType() {
		return reType;
	}
	public void setReType(String reType) {
		this.reType = reType;
	}
	public String getReOut() {
		return reOut;
	}
	public void setReOut(String reOut) {
		this.reOut = reOut;
	}
	
	
	@Override
	public String toString() {
		return "OrderStatusModel [startDate=" + startDate + ", endDate=" + endDate + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", jordNo=" + jordNo + ", count=" + count + ", cnt=" + cnt + ", total="
				+ total + ", jordDate=" + jordDate + ", jordWishdate=" + jordWishdate + ", jordIn=" + jordIn
				+ ", shDate=" + shDate + ", shType=" + shType + ", modelName=" + modelName + ", pdName=" + pdName
				+ ", pdCode=" + pdCode + ", pdCorp=" + pdCorp + ", pdPrice=" + pdPrice + ", jordAmt=" + jordAmt
				+ ", loginId=" + loginId + ", bankCode=" + bankCode + ", bankName=" + bankName + ", account=" + account
				+ ", shCode=" + shCode + ", reCode=" + reCode + ", dirCode=" + dirCode + ", jordCode=" + jordCode
				+ ", whCode=" + whCode + ", modelCode=" + modelCode + ", bordCode=" + bordCode + ", reAmt=" + reAmt
				+ ", reDate=" + reDate + ", reType=" + reType + ", reOut=" + reOut + "]";
	} 
	
	
	
	
}
