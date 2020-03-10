package sec01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO { //Data Access Object
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static UserDAO userdao = new UserDAO();
	
	private UserDAO() { //������ ���� ��ü ������
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
	
	public static UserDAO getInstance() {
		return userdao;
	}
	
	public int login (String userID, String userPassword) {
		String SQL = "SELECT userPassword from user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��� ����
				}	
				else
					return 0; //��й�ȣ�� Ʋ��
			}
			return -1; //���̵� ����
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //�����ͺ��̽� ����
	
	}
	
	public int playerJoin(Player player) {
		String SQL = "INSERT INTO player VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, player.getNum());	
			pstmt.setString(2, player.getName());
			pstmt.setString(3, player.getAge());
			pstmt.setString(4, player.getPos());
			pstmt.setString(5, player.getAvg());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB����
	}
	
	public int getNext() {
		String SQL = "SELECT num FROM player ORDER BY num DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
			return -1;
	}
	
	public ArrayList<Player> getList(int pageNumber) {
		String SQL = "SELECT * FROM player WHERE num < ? ORDER BY num DESC";
		ArrayList<Player> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Player player = new Player();
				player.setNum(rs.getString(1));
				player.setName(rs.getString(2));
				player.setAge(rs.getString(3));
				player.setPos(rs.getString(4));
				player.setAvg(rs.getString(5));
				list.add(player);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM player WHERE num<?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
