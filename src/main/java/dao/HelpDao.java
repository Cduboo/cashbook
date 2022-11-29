package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Comment;
import vo.Help;

public class HelpDao {
	//문의 수정
	public int updateHelp(Help help) throws Exception {
		int row = 0;
		String sql = "UPDATE help SET help_title = ?, help_memo = ?, updatedate = NOW() WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpTitle());
		stmt.setString(2, help.getHelpMemo());
		stmt.setInt(3, help.getHelpNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//문의 삭제 (답변이 달리면 삭제 불가)
	public int deleteHelp(int helpNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM help WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//문의하기
	public int insertHelp(Help help) throws Exception {
		int row = 0;
		String sql = "INSERT INTO help(help_title, help_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpTitle());
		stmt.setString(2, help.getHelpMemo());
		stmt.setString(3, help.getMemberId());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//나의 문의 리스트
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		/*String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.help_memo helpMemo, h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ? ORDER BY h.createdate DESC";*/
		String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.createdate helpCreatedate,  c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ? GROUP BY h.help_title ORDER BY h.createdate DESC";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
				
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpTitle", rs.getString("helpTitle"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	//문의 상세 페이지
	public Help selectHelpOne(int helpNo) throws Exception {
		Help help = null;
		String sql = "SELECT help_title helpTitle, help_memo helpMemo, member_id memberId, createdate FROM help WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			help = new Help();
			help.setHelpTitle(rs.getString("helpTitle"));
			help.setHelpMemo(rs.getString("helpMemo"));
			help.setMemberId(rs.getString("memberId"));
			help.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return help;
	}
	
	//전체 문의 리스트(관리자)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		String sql = "SELECT help_no helpNo, help_title helpTitle, member_id memberId, createdate FROM help ORDER BY createdate DESC LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("helpNo", rs.getString("helpNo"));
			m.put("helpTitle", rs.getString("helpTitle"));
			m.put("memberId", rs.getString("memberId"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}
