package dao;

import vo.*;
import util.DBUtil;
import java.sql.*;
import java.util.*;

public class CategoryDao {
	//수정
	public int updateCategoryName(Category category) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "UPDATE category SET category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
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
	
	//하나의 카테고리 정보
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
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
		
		return category;
	}
	
	//admin -> deleteCategoryAction.jsp
	public int deleteCategory(int categoryNo) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql ="DELETE FROM category WHERE category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
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
	
	//admin -> insertCategoryAction.jsp 
	public int insertCategory(Category category) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?, ?, CURDATE(), CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
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
	
	//<select>목록 출력
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> categoryList = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category ORDER BY categoryKind";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			categoryList = new ArrayList<>();
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setUpdatedate(rs.getString("updatedate"));
				category.setCreatedate(rs.getString("createdate"));
				categoryList.add(category);
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
		
		return categoryList;
	}
}
