<%@ include file="include/header.jsp" %>
	<section class="container mt-5" style="width:48%;margin:0px auto;">
			<%@page import="java.io.*"%>
		

			<div class="row">
			
				<%! 
					Connection con;
					Statement stmt;
					ResultSet rs;
					boolean result = false;
					String title =null;
					String imgDataBase64;

				%>
				<% 
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
					String posts = "select * from posts";
					stmt = con.createStatement();
					rs = stmt.executeQuery(posts);
					int i=0;
					while(rs.next()) {
						Blob blob = rs.getBlob("image");
		                 
		                InputStream inputStream = blob.getBinaryStream();
		                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		                byte[] buffer = new byte[4096];
		                int bytesRead = -1;
		                 
		                while ((bytesRead = inputStream.read(buffer)) != -1) {
		                    outputStream.write(buffer, 0, bytesRead);                  
		                }
		                 
		                byte[] imageBytes = outputStream.toByteArray();
		                imgDataBase64 = Base64.getEncoder().encodeToString(imageBytes);
		                 
		                 
		                inputStream.close();
		                outputStream.close();
				%>
				
						<%= "<div class='col-12'>"
								+ "<div class='card shadow mb-3' style='width:100%'>"
								+ "<div class='card-body'>"
								+ "<div class='d-flex justify-content-between align-items-center mb-3'>"
								+ "<h3 class='font-weight-bold mb-0'>"+rs.getString("title")+"</h3>"
								+ "<div class='text-black-50 font-weight-normal'>"
								+ "<i class='fa-regular fa-calendar mr-2'></i>"
								+ "<span>"+rs.getString("created_at")+"</span>"
								+ "</div></div>"
								+"<img src='data:image/jpg;base64,"+imgDataBase64+"' style='width:100%;height:100%;'/>"
								+"<p class='text-secondary mt-3'>"+rs.getString("description")+"</p>"
								+"<a class='text-left' href='DetailPostServlet?id="+rs.getString("id")+"'>More detail>>></a>"
								+"</div>"
								+"</div>"
							   +"</div>"%>					
						
				<% result  = true;}%>
						
					
					
			</div>
	</section>
<%@ include file="include/footer.jsp" %>
