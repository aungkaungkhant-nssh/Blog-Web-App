<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UCSL BLOG</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<%@ page import = "java.util.*"%>
 <%@ page import="javax.servlet.http.HttpSession.*"%>
 <%@ page import = "java.lang.*"%>
 <%@ page import = "java.sql.*"%>
  	
 <%! String username=null; %>
  <%
  	String id = (String)session.getAttribute("id");
  	if(id==null){
		response.sendRedirect("/BlogWebApp");
	}else{
		username = (String)request.getAttribute("name");
	}
  %>

	<nav class="navbar navbar-expand-lg bg-primary" style="position:sticky;top:.01rem;z-index:999;">
	  <div class="container">
	  		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
	   			 <span class="navbar-toggler-icon"></span>
	  		</button>
  			<a class="navbar-brand text-dark" href="WelcomeServlet">UCSL BLOG</a>
		  <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
		    <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
		      <li class="nav-item">
		        <a class="nav-link text-white" href="AddPostServlet">Add Post</a>
		      </li>
		      <li class="nav-item">
		        <div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				  	<%= username %>
				  </button>
				  	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				  		<form action="LogoutServlet" method="post">
				  			<input type="submit" value="Logout" class="dropdown-item" style="cursor:pointer"/>
				  		</form>
					    
					  </div>
				</div>
		      </li>
		    </ul>
	  </div>
	  </div>
	 
	</nav>