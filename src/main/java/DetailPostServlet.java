


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class DetailPostServlet
 */
@WebServlet("/DetailPostServlet")
public class DetailPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	 Statement stmt;
	 ResultSet rs;
	 boolean result = false;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();  
	     String name=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
				String user = "select * from users where id='"+session.getAttribute("id")+"'";
				stmt = con.createStatement();
				rs = stmt.executeQuery(user);
				while(rs.next()) {
					name= rs.getString(2);
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
	
		request.setAttribute("name", name);
		request.setAttribute("id", request.getParameter("id"));
		request.getRequestDispatcher("detailPost.jsp").forward(request, response);
	}

	

}
