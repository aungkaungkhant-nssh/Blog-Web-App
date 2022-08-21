<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UCSL BLOG</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<%@ page import = "java.util.*"%>
	 <%@ page import="javax.servlet.http.HttpSession.*"%>
	
	  <%
	  	String id = (String)session.getAttribute("id");
	  	if(id !=null){
			response.sendRedirect("/BlogWebApp/WelcomeServlet");
		}
	  %>
	<section class="container">
		<div class="row mt-5">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body">
						<h3 class="text-center pb-3">Login</h3>
						<form action="LoginServlet" method="post">
							<div class="form-group">
								<input type="email" name="email" required placeholder="Enter your email" class="form-control" />
							</div>
							<div class="form-group">
								<input type="password" name="password" required placeholder="Enter password" class="form-control"/>
							</div>
							<button type="submit" class="btn btn-block btn-primary">Login</button>
							<p class="text-center mt-2">Don't have an account? <a href="./register.jsp">Please Register</a></p>
						</form>
					</div>
				</div>
				
			</div>
		</div>
		
	</section>
</body>
</html>