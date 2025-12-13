package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.org.dao.ContactDAO;
import com.org.model.ContactInquiry;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Create ContactInquiry object
        ContactInquiry inquiry = new ContactInquiry(name, email, phone, subject, message);
        
        // Save to database
        ContactDAO contactDAO = new ContactDAO();
        boolean success = contactDAO.saveInquiry(inquiry);
        
        // Redirect with success/error message
        if (success) {
            response.sendRedirect("Contact.jsp?status=success");
        } else {
            response.sendRedirect("Contact.jsp?status=error");
        }
    }
}