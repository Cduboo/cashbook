package dao;

import java.sql.*;
import java.util.*;

import javax.websocket.Session;

import util.DBUtil;
import vo.*;

public class CashDao {
	//cashDateList.jsp, 해당 일자 가계부정보 출력
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		ArrayList<HashMap<String , Object>> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_no, ct.category_kind;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
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
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	//해당 월의 cashList(가계부정보) 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{
		ArrayList<HashMap<String , Object>> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY  c.cash_date, ct.category_kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	//cash 입력
	public int insertCash(Cash cash) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	//cash 삭제
	public String deleteCash(Cash cash) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//yyyy-mm-dd 출력을 위해
		String selectSql = "SELECT cash_date cashDate FROM cash WHERE member_id = ? AND cash_no = ?";
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		selectStmt.setString(1, cash.getMemberId());
		selectStmt.setInt(2, cash.getCashNo());
		ResultSet selectRs = selectStmt.executeQuery();
		String cashDate = ""; //yyyy-mm-dd
		if(selectRs.next()) {
			cashDate = selectRs.getString("cashDate");
		}
		
		String sql = "DELETE FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCashNo());
		stmt.executeUpdate();
		
		
		return cashDate;
	}
	
	//cash_no에 해당하는 cash(가계부)정보 출력
	public HashMap<String, Object> selectCashListByCashNo(int cashNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, cash_price cashPrice, cash_date cashDate, cash_memo cashMemo FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		
		HashMap<String, Object> m = null;
		if(rs.next()) {
			m = new HashMap<>();
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashMemo", rs.getString("cashMemo"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return m;
	}
	
	//cash(가계부) 수정
	public int updateCashList(Cash cash) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="UPDATE cash SET category_no = ?, cash_date = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getCashDate());
		stmt.setLong(3, cash.getCashPrice());
		stmt.setString(4, cash.getCashMemo());
		stmt.setInt(5, cash.getCashNo());
		stmt.setString(6, cash.getMemberId());
		int row = stmt.executeUpdate();
		if(row != 1) {
			System.out.print("update fail");
		}
		stmt.close();
		conn.close();
		
		return row;
	}
}
