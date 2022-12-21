package kr.happyjob.study.system.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileModel {
	
	private int file_no;	
	private String file_server_path;	
	private String file_local_path;	
	private String file_new_name;
	private String file_ofname;
	private int file_size;	
	private String notice_no;
	private String pro_no;
	private String file_exts; //파일 확장자(DB에는 없음)
}
