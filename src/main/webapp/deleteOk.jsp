<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 성공</title>
</head>
<body>
	<%
		String mid = request.getParameter("id");

		String driverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jsp_testdb";
		String username = "root";
		String password = "1234";
		String sql = "DELETE FROM members WHERE id = ?";
		
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
	
		try {
			Class.forName(driverName); // 드라이버 로딩
			conn = DriverManager.getConnection(url, username, password); // 연결 생성
			// stmt = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid); // sql문의 첫번째 ?에 mid값을 대입
			
			int dbFlag = pstmt.executeUpdate(); // sql문 실행
			// sql문이 성공적으로 실행되면 db에서 1이 반환되고, 아니면 다른 값
			if(dbFlag == 1) {
				out.println("회원 탈퇴 성공");
			} else {
				out.println("회원 탈퇴 실패");
			}
			
		} catch(ClassNotFoundException e) {
			out.println("DB 드라이버 로딩 실패");
		} catch(SQLException e) {
			out.println("DB 연결 실패");
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) { 	 // Exception = 모든 에러를 다 잡는 클래스 
				e.printStackTrace(); // 에러 발생시 에러의 내용을 출력
			}
		}
	%>
</body>
</html>