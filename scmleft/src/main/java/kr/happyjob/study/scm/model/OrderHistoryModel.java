package kr.happyjob.study.scm.model;

import org.springframework.stereotype.Repository;

// lombok 사용 X
@Repository
public class OrderHistoryModel {
	private String type;
	private String startDate;
	private String endDate;
	private String reType;
	
	private String jordCode; // 주문코드
	private String jordDate; // 주문일자
	private String loginId; // 주문한 기업회원 코드 + 배송 담당자 + 지시서 작성자
	private String companyName; // 주문한 기업회원 이름
	private String modelCode; // 제품 모델 코드
	private String pdName; // 제품 이름
	private int pdPrice; // 제품 단가
	private int jordAmt; // 제품 수량
	private long totalAmt; // 제품 주문한 토탈가격
	private String reDate; // 반품일자
	private String jordIn; // 입금여부

	private String whCode; // 창고코드
	private String whName; // 창고이름
	private int whStock; // 제품 재고
	
	private String dirCode; // 지시서 코드
	private String dirType; // 지시서 타입 (0 - 발주, 1 - 배송, 2 - 반품)
	private String dirDate; // 지시서 작성일자
	private int dirAmt; // 지시서 수량
	
	private String bordCode; // 발주코드 - 발주지시서 작성여부
	private int bordAmt; // 발주수량
	private String bordDate; // 발주 완료일자
	private String bordType; // 발주 승인여부 (0 - 미승인, 1 - 승인, 2 - 반려)
	
	private String shCode; // 배송코드 - 배송지시서 작성여부
	private String reCode; // 반품코드
	private String shDate; // 배송 완료일자
	private int shAmt; // 배송수량
	private String shType; // 배송완료여부 (0 - 배송전, 1 - 배송중, 2 - 배송완료)
	
	// 파라미터 값 나중에 추가하기
	
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
	public String getRetype() {
		return reType;
	}
	public void setReType(String reType) {
		this.reType = reType;
	}
	public String getJordCode() {
		return jordCode;
	}
	public void setJordCode(String jordCode) {
		this.jordCode = jordCode;
	}
	public String getJordDate() {
		return jordDate;
	}
	public void setJordDate(String jordDate) {
		this.jordDate = jordDate;
	}
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
	public String getModelCode() {
		return modelCode;
	}
	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}
	public String getPdName() {
		return pdName;
	}
	public void setPdName(String pdName) {
		this.pdName = pdName;
	}
	public int getPdPrice() {
		return pdPrice;
	}
	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}
	public int getJordAmt() {
		return jordAmt;
	}
	public void setJordAmt(int jordAmt) {
		this.jordAmt = jordAmt;
	}
	public long getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(long totalAmt) {
		this.totalAmt = totalAmt;
	}
	public String getReDate() {
		return reDate;
	}
	public void setReDate(String reDate) {
		this.reDate = reDate;
	}
	public String getJordIn() {
		return jordIn;
	}
	public void setJordIn(String jordIn) {
		this.jordIn = jordIn;
	}
	public String getWhCode() {
		return whCode;
	}
	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	public String getWhName() {
		return whName;
	}
	public void setWhName(String whName) {
		this.whName = whName;
	}
	public int getWhStock() {
		return whStock;
	}
	public void setWhStock(int whStock) {
		this.whStock = whStock;
	}
	public String getDirCode() {
		return dirCode;
	}
	public void setDirCode(String dirCode) {
		this.dirCode = dirCode;
	}
	public String getDirType() {
		return dirType;
	}
	public void setDirType(String dirType) {
		this.dirType = dirType;
	}
	public String getDirDate() {
		return dirDate;
	}
	public void setDirDate(String dirDate) {
		this.dirDate = dirDate;
	}
	public int getDirAmt() {
		return dirAmt;
	}
	public void setDirAmt(int dirAmt) {
		this.dirAmt = dirAmt;
	}
	public String getBordCode() {
		return bordCode;
	}
	public void setBordCode(String bordCode) {
		this.bordCode = bordCode;
	}
	public int getBordAmt() {
		return bordAmt;
	}
	public void setBordAmt(int bordAmt) {
		this.bordAmt = bordAmt;
	}
	public String getBordDate() {
		return bordDate;
	}
	public void setBordDate(String bordDate) {
		this.bordDate = bordDate;
	}
	public String getBordType() {
		return bordType;
	}
	public void setBordType(String bordType) {
		this.bordType = bordType;
	}
	public String getShCode() {
		return shCode;
	}
	public void setShCode(String shCode) {
		this.shCode = shCode;
	}
	public String getReCode() {
		return reCode;
	}
	public void setReCode(String reCode) {
		this.reCode = reCode;
	}
	public String getShDate() {
		return shDate;
	}
	public void setShDate(String shDate) {
		this.shDate = shDate;
	}
	public int getShAmt() {
		return shAmt;
	}
	public void setShAmt(int shAmt) {
		this.shAmt = shAmt;
	}
	public String getShType() {
		return shType;
	}
	public void setShType(String shType) {
		this.shType = shType;
	}
	
}
