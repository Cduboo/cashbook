package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;
import vo.Comment;

public class CommentDao {
	//답변 추가
	public int insertComment(HashMap<String, Object> map) throws Exception {
		int row = 0;
		String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (int)map.get("helpNo"));
		stmt.setString(2, (String)map.get("commentMemo"));
		stmt.setString(3, (String)map.get("memberId"));
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//답변 수정
	public HashMap<String, Object> selectCommentOne(int commentNo) throws Exception {
		HashMap<String,	Object> map = new HashMap<>();
		String sql = "SELECT comment_no commentNo FROM comment WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			map.put("commentNo", rs.getInt("commentNo"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return map;
	}
	//답변 수정
	public int updateComment(HashMap<String, Object> map) throws Exception {
		int row = 0;
		String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)map.get("commentMemo"));
		stmt.setInt(2, (int)map.get("commentNo"));
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//답변 삭제
	public int deleteComment(int commentNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//해당 문의글의 답변 리스트 출력
	public ArrayList<HashMap<String, Object>> selectCommentList(int helpNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		String sql = "SELECT comment_memo commentMemo, c.member_id memberId, c.createdate createdate, comment_no commentNo FROM comment c INNER JOIN help h ON c.help_no = h.help_no WHERE c.help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("createdate", rs.getString("createdate"));
			m.put("commentNo", rs.getString("commentNo"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}
