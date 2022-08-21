<%@ include file="include/header.jsp" %>
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
			String createUserName = "select * from posts where id="+request.getParameter("id");
			stmt = con.createStatement();
			rs = stmt.executeQuery(createUserName);
			if(rs.next()){
				title = rs.getString(2);
				description = rs.getString(4);
			}
	%>
	<section class="container mt-5">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card shadow">
						<div class="card-body ">
							<h3 class="text-center pb-3">Update Post</h3>
							<form    action="EditPostServlet" method="post" enctype="multipart/form-data">
								<input type="hidden" value=<%= request.getParameter("id") %> name="id"/>
								<div class="form-group">
									<input type="text" name="title"  placeholder="Title" class="form-control" value="<%= title%>"/>
								</div>
								<div class="form-group">
									<input type="file" name="file" class="form-control"/>
								</div>
								<div class="form-group">
									<textarea col='12' row="12" class="form-control" name="description" placeholder="Description" ><%= description %></textarea>
								</div>
								<button type="submit" class="btn btn-primary btn-block">Update Posts</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			
	</section>
<%@ include file="include/footer.jsp" %>