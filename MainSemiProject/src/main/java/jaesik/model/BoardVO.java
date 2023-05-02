package jaesik.model;

public class BoardVO {

	private int board_no;
	private String board_title;    
	private String board_content;
	private String board_registerdate;
	private String fk_userid;
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_registerdate() {
		return board_registerdate;
	}
	public void setBoard_registerdate(String board_registerdate) {
		this.board_registerdate = board_registerdate;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	
	
}