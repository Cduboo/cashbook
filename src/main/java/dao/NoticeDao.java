package dao;

import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import vo.Notice;

public class NoticeDao {
	//공지 수정
	public int updateNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE notice SET notice_title = ?, notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeMemo());
			stmt.setInt(3, notice.getNoticeNo());
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	//공지 삭제
	public int deleteNotice(int notice_no) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice_no);
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return row;
	}
	
	//공지 추가
	public int insertNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO notice(notice_title, notice_memo, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeMemo());
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return row;
	}
	
	//마지막 페이지 -> 전체 공지 수 구하기
	public int selectNoticeCount(String select, String search) { 
		int count = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "";
			if(select.equals("title") || ("").equals(select)) {
				sql = "SELECT COUNT(*) FROM notice WHERE notice_title LIKE ?";
			} else if(select.equals("memo")) {
				sql = "SELECT COUNT(*) FROM notice WHERE notice_memo LIKE ?";
			} else if(select.equals("titleMemo")) {
				sql = "SELECT COUNT(*) FROM notice WHERE notice_title LIKE ? OR notice_memo LIKE ?";
			}
			
			stmt = conn.prepareStatement(sql);
			
			if(select.equals("title") || ("").equals(select)) {
				stmt.setString(1, "%"+ search +"%");
			} else if(select.equals("memo")) {
				stmt.setString(1, "%"+ search +"%");
			} else if(select.equals("titleMemo")) {
				stmt.setString(1, "%"+ search +"%");
				stmt.setString(2, "%"+ search +"%");
			}
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return count;
	}
	
	//공지목록
	public ArrayList<Notice> selectNoticeListByPage(String select, String search, int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "";
			
			if(("").equals(select) || select.equals("title")) { // 제목 검색 시 쿼리
				sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice WHERE notice_title LIKE ? ORDER BY createdate desc LIMIT ?, ?";
			} else if(select.equals("memo")) { // 본문 검색 시 쿼리
				sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice WHERE notice_memo LIKE ? ORDER BY createdate desc LIMIT ?, ?";
			} else if(select.equals("titleMemo")) { // 제목+본문 검색 시 쿼리
				sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice WHERE notice_title LIKE ? OR notice_memo LIKE ? ORDER BY createdate desc LIMIT ?, ?";	
			}
			
			stmt = conn.prepareStatement(sql);
			if(("").equals(select) || select.equals("title")) { // 제목 검색 시
				stmt.setString(1, "%"+search+"%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);	
			} else if(select.equals("memo")) { // 본문검색 시
				stmt.setString(1, "%"+search+"%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);					
			} else if(select.equals("titleMemo")) { // 제목+본문 검색 시
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+search+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			}
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeTitle(rs.getString("noticeTitle"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setUpdatedate(rs.getString("updatedate"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return list;
	}
	
	//공지 1개 
	public Notice selectNoticeOne(Notice notice) {
		Notice noticeOne = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				noticeOne = new Notice();
				noticeOne.setNoticeNo(rs.getInt("noticeNo"));
				noticeOne.setNoticeTitle(rs.getString("noticeTitle"));
				noticeOne.setNoticeMemo(rs.getString("noticeMemo"));
				noticeOne.setUpdatedate(rs.getString("updatedate"));
				noticeOne.setCreatedate(rs.getString("createdate"));
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return noticeOne;
	}
}
