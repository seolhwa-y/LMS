package kr.happyjob.study.system.model;

public class NoticeModel {
	
	// 게시판 글 번호
	private int row_num;
	private int notcode;
	private String loginid;
	private String nottitle;
	private String noticeContent;
	private String noticeRegdate;
	private String notdate;
	private String name;
	
	
	

	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getNotcode() {
		return notcode;
	}
	public void setNotcode(int notcode) {
		this.notcode = notcode;
	}
	public String getLoginid() {
		return loginid;
	}
	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}
	public String getNottitle() {
		return nottitle;
	}
	public void setNottitle(String nottitle) {
		this.nottitle = nottitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeRegdate() {
		return noticeRegdate;
	}
	public void setNoticeRegdate(String noticeRegdate) {
		this.noticeRegdate = noticeRegdate;
	}
	public String getNotdate() {
		return notdate;
	}
	public void setNotdate(String notdate) {
		this.notdate = notdate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "NoticeModel [row_num=" + row_num + ", notcode=" + notcode + ", loginid=" + loginid + ", nottitle="
				+ nottitle + ", noticeContent=" + noticeContent + ", noticeRegdate=" + noticeRegdate + ", notdate="
				+ notdate + ", name=" + name + "]";
	}
}
