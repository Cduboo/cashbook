package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	//수정
	public int updateCategoryName(Category category) throws Exception {
		int row = 0;
		String sql = "UPDATE category SET category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//하나의 카테고리 정보
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	
	//admin -> deleteCategoryAction.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		
		String sql ="DELETE FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//admin -> insertCategoryAction.jsp 
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?, ?, CURDATE(), CURDATE())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//<select>목록 출력
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			category.setUpdatedate(rs.getString("updatedate"));
			category.setCreatedate(rs.getString("createdate"));
			categoryList.add(category);
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return categoryList;
	}
}
