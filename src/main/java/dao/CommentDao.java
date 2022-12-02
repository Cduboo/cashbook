package dao;

import util.DBUtil;
import java.util.*;
import java.sql.*;

public class CommentDao {
	//답변 추가
	public int insertComment(HashMap<String, Object> map) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
				
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, (int)map.get("helpNo"));
			stmt.setString(2, (String)map.get("commentMemo"));
			stmt.setString(3, (String)map.get("memberId"));
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
	
	//답변 수정
	public HashMap<String, Object> selectCommentOne(int commentNo) {
		HashMap<String,	Object> map = new HashMap<>();
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT comment_no commentNo FROM comment WHERE comment_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				map.put("commentNo", rs.getInt("commentNo"));
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
		
		return map;
	}
	
	//답변 수정
	public int updateComment(HashMap<String, Object> map) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no = ?";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String)map.get("commentMemo"));
			stmt.setInt(2, (int)map.get("commentNo"));
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
	
	//답변 삭제
	public int deleteComment(int commentNo) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM comment WHERE comment_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
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
	
	//해당 문의글의 답변 리스트 출력
	public ArrayList<HashMap<String, Object>> selectCommentList(int helpNo) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT comment_memo commentMemo, c.member_id memberId, c.createdate createdate, comment_no commentNo FROM comment c INNER JOIN help h ON c.help_no = h.help_no WHERE c.help_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			rs = stmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("memberId", rs.getString("memberId"));
				m.put("createdate", rs.getString("createdate"));
				m.put("commentNo", rs.getString("commentNo"));
				list.add(m);
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
}
