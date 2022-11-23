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
		//id중복검사
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
	
	//update member, 로그인 계정 정보(이름) 수정
	public int updateMember(String loginMemberId, Member updateMember) throws Exception {
		Member member = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//수정 전 본인 인증, 비밀번호 확인
		String pwCkSql = "SELECT member_id FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement pwCkStmt = conn.prepareStatement(pwCkSql);
		pwCkStmt.setString(1, loginMemberId);
		pwCkStmt.setString(2, updateMember.getMemberPw());
		ResultSet pwCkRs = pwCkStmt.executeQuery();
		boolean pwCk = false; //비밀번호 확인 변수
		if(pwCkRs.next()){
			pwCk = true;
		}
		
		//비밀번호가 틀리면 member는 null, 맞다면 회원 정보 수정
		if(pwCk == false) {
			return 0;
		}
		
		String updateMemberSql = "UPDATE member SET member_name=? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement updateMemberStmt = conn.prepareStatement(updateMemberSql);
		updateMemberStmt.setString(1, updateMember.getMemberName());
		updateMemberStmt.setString(2, loginMemberId);
		updateMemberStmt.setString(3, updateMember.getMemberPw());
		int row = updateMemberStmt.executeUpdate();
		
		pwCkRs.close();
		pwCkStmt.close();
		updateMemberStmt.close();
		conn.close();
		
		return row;
	}
	
	//update password 비밀번호 수정
	public int updateMemberPw(String memberId, String currentPw, String updatePw) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, updatePw);
		stmt.setString(2, memberId);
		stmt.setString(3, currentPw);
		int row =stmt.executeUpdate();
		
		
		stmt.close();
		conn.close();
		
		return row;
	}
}
