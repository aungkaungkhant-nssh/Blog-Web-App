

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 Connection con;
	 Statement stmt;
	 ResultSet rs;
	 boolean result = false;
    
    public LoginServlet() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		PrintWriter out = response.getWriter();
		String  id=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
				System.out.print("Connection is success");
	
				String loginUser = "select * from users where email='"+email+"' and password='"+password+"'";
				stmt = con.createStatement();
				rs = stmt.executeQuery(loginUser);
				while(rs.next()) {
					id = rs.getString(1);
					result  = true;
				}
				stmt.close();
				con.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		if(result) {
			 HttpSession session=request.getSession();  
		     session.setAttribute("id",id);  
			 response.sendRedirect("WelcomeServlet");
		}else {
			out.println("<p style='color:red'>Your email or password invalid</p");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request,response);
		}
	
	}

}
