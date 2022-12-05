package dao;

import vo.*;
import util.DBUtil;
import java.util.*;
import java.sql.*;

public class CashDao {
	//회원의 해당 년월 총 지출
	public int selectExpenditureByMonth(String memberId, int year, int month) {
		int totalExpenditure = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT SUM(c.cash_price) totalExpenditure, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND ct.category_kind = '지출'";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				totalExpenditure = rs.getInt("totalExpenditure");
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
		
		return totalExpenditure;
	}
	//회원의 해당 년월 총 수입
	public int selectIncomeByMonth(String memberId, int year, int month) {
		int totalIncome = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT SUM(c.cash_price) totalIncome,  ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND ct.category_kind = '수입'";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				totalIncome = rs.getInt("totalIncome");
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
		
		return totalIncome;
	}
	
	//cashDateList.jsp, 해당 일자 가계부정보 출력
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String , Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_no, ct.category_kind";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
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
	
	//해당 월의 cashList(가계부정보) 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String , Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY  c.cash_date, ct.category_kind";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
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
	
	//cash 입력
	public int insertCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
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
	
	//cash 삭제
	public int deleteCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM cash WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCashNo());
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
	
	//해당 cash yyyy-mm-dd
	public String selectCashDate(Cash cash) {
		String cashDate = "";
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT cash_date cashDate FROM cash WHERE member_id = ? AND cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cash.getMemberId());
			stmt.setInt(2, cash.getCashNo());
			rs = stmt.executeQuery();
			if(rs.next()) {
				cashDate = rs.getString("cashDate");
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
		
		return cashDate;
	}
	
	//cash_no에 해당하는 cash(가계부)정보 출력
	public HashMap<String, Object> selectCashListByCashNo(int cashNo) {
		HashMap<String, Object> m = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, cash_price cashPrice, cash_date cashDate, cash_memo cashMemo FROM cash WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				m = new HashMap<>();
				m.put("categoryNo", rs.getInt("categoryNo"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashMemo", rs.getString("cashMemo"));
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
		
		return m;
	}
	
	//cash(가계부) 수정
	public int updateCashList(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql ="UPDATE cash SET category_no = ?, cash_date = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ? AND member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getCashDate());
			stmt.setLong(3, cash.getCashPrice());
			stmt.setString(4, cash.getCashMemo());
			stmt.setInt(5, cash.getCashNo());
			stmt.setString(6, cash.getMemberId());
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
