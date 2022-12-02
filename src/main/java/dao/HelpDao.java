package dao;

import vo.*;
import util.DBUtil;
import java.util.*;
import java.sql.*;

public class HelpDao {
	//문의 수정
	public int updateHelp(Help help) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
				
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE help SET help_title = ?, help_memo = ?, updatedate = NOW() WHERE help_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpTitle());
			stmt.setString(2, help.getHelpMemo());
			stmt.setInt(3, help.getHelpNo());
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
	
	//문의 삭제 (답변이 달리면 삭제 불가)
	public int deleteHelp(int helpNo) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM help WHERE help_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
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
	
	//문의하기
	public int insertHelp(Help help) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO help(help_title, help_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";		
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpTitle());
			stmt.setString(2, help.getHelpMemo());
			stmt.setString(3, help.getMemberId());
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		
		return row;
	}
	
	//나의 문의 리스트
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.createdate helpCreatedate,  c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ? GROUP BY h.help_title ORDER BY h.createdate DESC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpTitle", rs.getString("helpTitle"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	
	//문의 상세 페이지
	public Help selectHelpOne(int helpNo) {
		Help help = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT help_title helpTitle, help_memo helpMemo, member_id memberId, createdate FROM help WHERE help_no = ?";
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		
		return help;
	}
	
	//전체 문의 리스트(관리자)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT help_no helpNo, help_title helpTitle, member_id memberId, createdate FROM help ORDER BY createdate DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
						
			list = new ArrayList<>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				m.put("helpNo", rs.getString("helpNo"));
				m.put("helpTitle", rs.getString("helpTitle"));
				m.put("memberId", rs.getString("memberId"));
				m.put("createdate", rs.getString("createdate"));
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
