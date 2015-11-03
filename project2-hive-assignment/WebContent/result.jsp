<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Kalyan Hadoop Training @ ORIENIT</title>
</head>
<body>
    
	<%
		String context = config.getServletContext().getContextPath();
		String contextPath = config.getServletContext().getRealPath(File.separator);
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream(contextPath + "/kalyan.properties"));
		} catch (Exception e) {
		}
		String url = (String) properties.get("url");
		String driverclass = (String) properties.get("driverclass");
		String username = (String) properties.get("username");
		String password = (String) properties.get("password");
		
		try {
			Class.forName(driverclass);
		} catch (ClassNotFoundException e) {
			out.print(e.fillInStackTrace());
		}
		
		try {
		Connection con = DriverManager.getConnection(url, username, password);
		Statement stmt = con.createStatement();

		String query = request.getParameter("path");
		
		ResultSet res = stmt.executeQuery(query);
		ResultSetMetaData metaData = res.getMetaData();
		int size = metaData.getColumnCount();
	%>
			<table cellspacing="1" cellpadding="1" border="1" width="100%">             
		    <thead>
				<%
					out.print("<tr>");
					for (int i = 1; i <= size; i++) {
						out.print("<th>"+metaData.getColumnName(i)+"</th>");
		        	}
					out.print("</tr>");
				%>
		    </thead> 
		    <tbody>
		    <%
				while (res.next()) {
					out.print("<tr>");
					for (int i = 1; i <= size; i++) {
						out.print("<td>"+res.getString(i)+"</td>");
	      			}
					out.print("</tr>");
	        	}
	        %>
			</tbody> 
			</table>
		    <%
				}catch (Exception e) {
					out.print(e.fillInStackTrace());
				}
		    %>
</body>
</html>