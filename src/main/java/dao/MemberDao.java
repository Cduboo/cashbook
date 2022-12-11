package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.Member;
import util.DBUtil;

public class MemberDao {
	//관리자 : 레벨수정
	public int updateMemberLevel(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE member SET member_level = ?, updatedate = NOW() WHERE member_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
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
		
		return  row;
	}
	
	//관리자 : 멤버수 
	public int selectMemberCount(String select, String search) {
		int memberCount = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "";
			if(("").equals(select) || select.equals("memberId")) {
				sql = "SELECT COUNT(*) FROM member WHERE member_id LIKE ?";				
			} else if(select.equals("memberName")) {
				sql = "SELECT COUNT(*) FROM member WHERE member_name LIKE ?";
			}
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + search + "%");
			rs = stmt.executeQuery();

			if(rs.next()) {
				memberCount = rs.getInt("COUNT(*)");
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
		
		return memberCount;
	}
	
	//관리자 회원리스트
	public ArrayList<Member> selectMemberListByPage(String select, String search, int beginRow, int rowPerPage) {
		ArrayList<Member> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "";
			
			if(("").equals(select) || select.equals("memberId")) {
				sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member WHERE member_id LIKE ? ORDER BY createdate DESC, member_no DESC LIMIT ?, ?";
			} else if(select.equals("memberName")) {
				sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member WHERE member_name LIKE ? ORDER BY createdate DESC, member_no DESC LIMIT ?, ?";
			}
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + search + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();

			list = new ArrayList<Member>();
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
	
	//관리자 멤버 강퇴 
	public int deleteMemberByAdmin(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM member WHERE member_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
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
		
	//로그인
	public Member login(Member paramMember) {
		Member resultMember = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT member_name memberName, member_id memberId, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				return resultMember;
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

		return resultMember;
	}
	
	//insertMember(회원가입) -> 아이디 중복 체크 --> true : 중복 , fasle : 사용가능
	public boolean selectMemberIdCk(String memberId) {
		boolean result = false;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT member_id FROM member WHERE member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = true;
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
		
		return result;
	}
	
	//회원가입
	public int insertMember(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			stmt.setString(3, member.getMemberName());
			row = stmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null,stmt,conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	//update member(회원정보 수정) -> 본인인증(비밀번호) 비밀번호 확인 --> true : 본인인증 성공
	public boolean selectMemberPwCk(Member currentMember, Member updateMember) {
		boolean result = false;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT member_id FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, currentMember.getMemberId());
			stmt.setString(2, currentMember.getMemberPw());
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				result = true;
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
		
		return result;
	}
	
	// update member, 로그인 계정 정보(이름) 수정
	public int updateMember(Member currentMember, Member updateMember) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE member SET member_name = ?, updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, updateMember.getMemberName());
			stmt.setString(2, currentMember.getMemberId());
			stmt.setString(3, currentMember.getMemberPw());
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

	//update password 비밀번호 수정
	public int updateMemberPw(String memberId, String currentPw, String updatePw) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE member SET member_pw = PASSWORD(?), updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, updatePw);
			stmt.setString(2, memberId);
			stmt.setString(3, currentPw);
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
	
	//회원탈퇴
	public int deleteMember(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
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
}
