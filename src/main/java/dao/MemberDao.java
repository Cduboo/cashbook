package dao;

import java.sql.*;
import vo.Member;
import util.DBUtil;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_name memberName, member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			return resultMember;
		}

		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	
	//insertMember(회원가입) -> 아이디 중복 체크 --> true : 중복 , fasle : 사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
	         result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	//회원가입
	public int insertMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		row = stmt.executeUpdate();
		
		dbUtil.close(null,stmt,conn);
		return row;
	}
	
	//update member(회원정보 수정) -> 본인인증(비밀번호) 비밀번호 확인 --> true : 본인인증 성공
	public boolean selectMemberPwCk(Member currentMember, Member updateMember) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, currentMember.getMemberId());
		stmt.setString(2, currentMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	// update member, 로그인 계정 정보(이름) 수정
	public int updateMember(Member currentMember, Member updateMember) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name= ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, updateMember.getMemberName());
		stmt.setString(2, currentMember.getMemberId());
		stmt.setString(3, currentMember.getMemberPw());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}

	//update password 비밀번호 수정
	public int updateMemberPw(String memberId, String currentPw, String updatePw) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, updatePw);
		stmt.setString(2, memberId);
		stmt.setString(3, currentPw);
		row = stmt.executeUpdate();

		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//회원탈퇴
	public void deleteMember() {
		
	}
}
