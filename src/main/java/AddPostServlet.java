

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	 Statement stmt;
	 ResultSet rs;
	 boolean result = false; 
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
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
		request.getRequestDispatcher("addPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(); 
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		InputStream inputStream = null;
		Part filePart = request.getPart("file");
		if (filePart != null) {
            // debug messages
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
		try {
			Class.forName("com.mysql.jdbc.Driver");
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blog","root","mynewpassword");
				System.out.print("Connection is success");
	
				String addPost = "insert into posts (title,image,description,userId) values (?,?,?,?)";
				PreparedStatement statement = con.prepareStatement(addPost);
				System.out.print(inputStream);
				statement.setString(1, title);
				statement.setBlob(2, inputStream);
				statement.setString(3, description);
				statement.setInt(4,Integer.parseInt((String) session.getAttribute("id")));
				int row = statement.executeUpdate();
			
				con.close();
				stmt.close();
				if(row>0) {
					response.sendRedirect("WelcomeServlet");
				}
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}


}
