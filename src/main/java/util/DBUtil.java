package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		return conn;
	}
}
