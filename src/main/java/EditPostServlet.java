

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class EditPostServlet
 */
@WebServlet("/EditPostServlet")
@MultipartConfig
public class EditPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement stmt;
	ResultSet rs;
	boolean result = false; 
    
    public EditPostServlet() {
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
		request.getRequestDispatcher("editPost.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(); 
		String title = request.getParameter("title");
		String id= request.getParameter("id");
		String description = request.getParameter("description");
		InputStream inputStream = null;
		Part filePart = request.getPart("file");
		String fname=null;
		if (filePart != null) {
			
            inputStream = filePart.getInputStream();
        }
		System.out.print(filePart.getSubmittedFileName());
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
				if(filePart.getSubmittedFileName().isBlank()) {
					String updatePost = "update  posts set title=?,description=? where id=?";
					PreparedStatement statement = con.prepareStatement(updatePost);
					statement.setString(1, title);
					statement.setString(2, description);
					statement.setString(3, id);
					int row = statement.executeUpdate();
					con.close();
					stmt.close();
					if(row>0) {
						response.sendRedirect("WelcomeServlet");
					}
				}else {
					String updatePost = "update  posts set title=?,description=?,image=? where id=?";
					PreparedStatement statement = con.prepareStatement(updatePost);
					statement.setString(1, title);
					statement.setString(2, description);
					statement.setBlob(3, inputStream);
					statement.setString(4, id);
					int row = statement.executeUpdate();
					con.close();
					stmt.close();
					if(row>0) {
						response.sendRedirect("WelcomeServlet");
					}
				}
				
				
			} catch (SQLException e) {
				System.out.print(e);
				e.printStackTrace();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
