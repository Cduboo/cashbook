package dao;

import java.sql.*;
import vo.Member;
import util.DBUtil;

public class MemberDao {
	//로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_name memberName, member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();		
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			return resultMember; 
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	//회원가입
	public int insertMember(Member paramMember) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		Member member = selectOne(paramMember.getMemberId());
		if(member != null) {
			return 0;
		}
		
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	//selectOne
	public Member selectOne(String memberId) throws Exception {
		Member member = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			member = new Member();
			member.setMemberId(rs.getString("memberId"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return member;
	}
}
