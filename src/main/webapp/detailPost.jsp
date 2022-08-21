<%@ include file="include/header.jsp" %>
	<%@page import="java.io.*"%>
	<%! 
			Connection con;
			Statement stmt;
			ResultSet rs;
			boolean result = false;
			String title =null;
			String image = null;
			String description = null;
			String created_at = null;
			String userId =null;
			int postId =0;
			boolean isYourPost = false;
			String imgDataBase64;
	%>
	<% 
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
					String post = "select * from posts where id="+request.getAttribute("id");
					stmt = con.createStatement();
					rs = stmt.executeQuery(post);
					while(rs.next()){
						postId = rs.getInt(1);
						title = rs.getString(2);
						image = rs.getString(3);
						description = rs.getString(4);
						userId = rs.getString(5);
						created_at = rs.getString(6);
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
					}
					stmt.close();
					con.close();
	%>
	<section class="container mt-5">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card shadow">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center mb-2">
								<h3 class='font-weight-bold mb-0'><%= title %></h3>
								<% 	
									if(id.equals(userId)){%>
										<%=
											"<div class='text-black-50 font-weight-normal d-flex' style='cursor:pointer'>"
											 +"<a class='btn btn-sm btn-warning mr-3' href='EditPostServlet?id="+postId+"'><i class='fa-solid fa-pen-to-square text-white'></i></a>"
											 +"<form action='DeletePostServlet' method='post'><input type='hidden' value="+postId+" name='postId'></input><button type='submit' class='btn btn-danger btn-sm'><i class='fa-solid fa-trash text-white'></i></button></form>"
											 +"</div>"%>
								 <%}%>
								
							</div>
							<%= "<img src='data:image/jpg;base64,"+imgDataBase64+"' style='width:100%;'/>"%>
							
							<p class='text-secondary my-3'><%= description %></p>
							<div class="">
								<% 
									Class.forName("com.mysql.jdbc.Driver");
									con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
									String createUserName = "select * from users where id="+userId;
									stmt = con.createStatement();
									rs = stmt.executeQuery(createUserName);
									while(rs.next()){
								%>
									<%="<p class='mb-0 text-success' style='font-size:.8rem'>Posted By "+rs.getString(2)+"</p>"%>
									
								<%
									}
									stmt.close();
									con.close();%>
								
							
								<p class="mb-0 text-success" style='font-size:.8rem'>Created At <%= created_at %></p>
							</div>
						</div>
					</div>
				</div>
			</div>
			
	</section>
<%@ include file="include/footer.jsp" %>
