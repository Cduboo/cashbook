package dao;

import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import vo.Notice;

public class NoticeDao {
	//공지 수정
	public int updateNotice(Notice notice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_title = ?, notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeMemo());
		stmt.setInt(3, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		
		return row;
	}
	
	//공지 삭제
	public int deleteNotice(Notice notice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//공지 추가
	public int insertNotice(Notice notice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_title, notice_memo, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeMemo());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//마지막 페이지 -> 전체 공지 수 구하기
	public int selectNoticeCount() throws Exception { 
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		return count;
	}
	
	//공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice ORDER BY createdate desc LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	//공지 1개 
	public Notice selectNoticeOne(Notice notice) throws Exception {
		Notice noticeOne = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			noticeOne = new Notice();
			noticeOne.setNoticeNo(rs.getInt("noticeNo"));
			noticeOne.setNoticeTitle(rs.getString("noticeTitle"));
			noticeOne.setNoticeMemo(rs.getString("noticeMemo"));
			noticeOne.setUpdatedate(rs.getString("updatedate"));
			noticeOne.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return noticeOne;
	}
}
