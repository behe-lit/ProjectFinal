package sec01;

import java.awt.Toolkit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static MemberDAO memberdao = new MemberDAO();
	Toolkit toolkit = Toolkit.getDefaultToolkit();
	private MemberDAO() {
		try {

			String dbURL = "jdbc:mysql://localhost:3306/nba?serverTimezone=Asia/Seoul&useSSL=false"; //DB��ġ
			String dbID = "root"; //mysql ����
			String dbPassword = "1234"; //mysql ��й�ȣ
			String driver = "com.mysql.cj.jdbc.Driver"; //

			Class.forName(driver);
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

		} catch (Exception e) {
			System.out.println("������ ���������ϴ�.");
			e.printStackTrace();
		}
	}

	public static MemberDAO getInstance() {
		return memberdao;
	}

	public int memberJoin(Member member) {
		String SQL = "INSERT INTO user VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getUserID());	
			pstmt.setString(2, member.getUserPassword());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getUserGender());
			pstmt.setString(5, member.getUserEmail());
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB����
	}


}
