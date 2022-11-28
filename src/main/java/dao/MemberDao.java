package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.Member;
import util.DBUtil;

public class MemberDao {
	//관리자 : 레벨수정
	public int updateMemberLevel(Member member) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_level = ?, updatedate = NOW() WHERE member_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return  row;
	}
	
	//관리자 : 멤버수 
	public int selectMemberCount() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int memberCount = 0;
		if(rs.next()) {
			memberCount = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		return memberCount;
	}
	
	//관리자 회원리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setUpdatedate(rs.getString("updatedate"));
			m.setCreatedate(rs.getString("createdate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	//관리자 멤버 강퇴 
	public int deleteMemberByAdmin(Member member) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberNo());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
		
	//로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_name memberName, member_id memberId, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
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
	public int deleteMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		row = stmt.executeUpdate();
		
		return row;
	}
}
