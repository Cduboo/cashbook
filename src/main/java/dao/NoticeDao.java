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
	public int deleteNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
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
	public int selectNoticeCount() { 
		int count = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT COUNT(*) FROM notice";
			stmt = conn.prepareStatement(sql);
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
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_memo noticeMemo, updatedate, createdate FROM notice ORDER BY createdate desc LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
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
