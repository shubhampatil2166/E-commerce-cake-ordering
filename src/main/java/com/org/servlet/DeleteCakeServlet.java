package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CakeDAO;

@WebServlet("/DeleteCakeServlet")
public class DeleteCakeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp?error=Admin access required");
            return;
        }
        
        try {
            // Get cake ID from URL parameter
            String cakeIdParam = request.getParameter("id");
            
            if (cakeIdParam == null || cakeIdParam.trim().isEmpty()) {
                response.sendRedirect("ManageCakes.jsp?msg=error");
                return;
            }
            
            int cakeId = Integer.parseInt(cakeIdParam);
            
            // Delete cake from database
            CakeDAO cakeDAO = new CakeDAO();
            boolean success = cakeDAO.deleteCake(cakeId);
            
            if (success) {
                System.out.println("✅ Cake deleted successfully: ID " + cakeId);
                response.sendRedirect("ManageCakes.jsp?msg=deleted");
            } else {
                System.out.println("❌ Failed to delete cake: ID " + cakeId);
                response.sendRedirect("ManageCakes.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in DeleteCakeServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageCakes.jsp?msg=error");
        }
    }
}

