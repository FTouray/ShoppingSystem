import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		 // Get the user's input from the login HTML Page
		 String username = request.getParameter("username");
		 String password = request.getParameter("password");
 
		 // Check if username and password are not empty
		 if (username != null && password != null && !username.isEmpty() && !password.isEmpty()) {
				
			 // Set a session attribute to mark the user as logged in
			 HttpSession session = request.getSession();
			 session.setAttribute("loggedInUser", username);
 
			 // Redirect to the admin main page
			 response.sendRedirect("adminMainPage.jsp");
		 } else {
			 // Username or password is empty, redirect back to the login page with a message - not really need since
			 // html has required field
			 response.sendRedirect("AdminLogin.html?message=emptyCredentials");
		 }
	

}
}
