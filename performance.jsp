<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Performance Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <section class="max-w-4xl p-6 mx-auto bg-gray-100 rounded-md shadow-md dark:bg-gray-800 mt-20">
        <h1 class="text-xl font-bold text-black capitalize dark:text-black">Manage Performance</h1>
        <form action="performance.jsp" method="POST">
            <div class="grid grid-cols-1 gap-6 mt-4 sm:grid-cols-2">
                <div>
                    <label class="text-black dark:text-gray-200" for="student_id">Student ID</label>
                    <input id="student_id" type="number" name="student_id" required class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>

                <div>
                    <label class="text-black dark:text-gray-200" for="student_id">Subject</label>
                    <input id="subject" type="text" name="subject" required class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>

                <div>
                    <label class="text-black dark:text-gray-200" for="student_id">Point</label>
                    <input id="point" type="number" name="point" required class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>
            </div>

            <div class="flex justify-end mt-6">
                <button type="submit" class="px-6 py-3 leading-5 text-white transition-colors duration-200 transform bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-gray-600">Save Performance</button>
            </div>
        </form>
    </section>

    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        String subject = request.getParameter("subject");
        String point = request.getParameter("point");

        try (Connection conn = DBConnection.getConnection()) {
            // Insert into performance table
            String queryPerformance = "INSERT INTO performance (student_id, subject, point) VALUES (?, ?, ?)";
            PreparedStatement psPerformance = conn.prepareStatement(queryPerformance);
            psPerformance.setInt(1, studentId);
            psPerformance.setString(2, subject);
            psPerformance.setString(3, point);
            psPerformance.executeUpdate();

            // Update student's record with new subject and point
            String updateStudentQuery = "UPDATE students SET subject = ?, point = ? WHERE student_id = ?";
            PreparedStatement updateStudentPS = conn.prepareStatement(updateStudentQuery);
            updateStudentPS.setString(1, subject);
            updateStudentPS.setString(2, point);
            updateStudentPS.setInt(3, studentId);
            updateStudentPS.executeUpdate();

            out.println("<p class='text-green-500 ml-6 mt-4'>Performance record and student information saved/updated successfully!</p>");
        } catch (SQLException e) {
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>

