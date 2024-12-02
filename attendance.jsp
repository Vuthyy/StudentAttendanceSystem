<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Attendance Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <section class="max-w-4xl p-6 mx-auto bg-gray-100 rounded-md shadow-md dark:bg-gray-800 mt-20">
        <h1 class="text-xl font-bold text-black capitalize dark:text-black">Mark Attendance</h1>
        <form action="attendance.jsp" method="POST">
            <div class="grid grid-cols-1 gap-6 mt-4 sm:grid-cols-2">
                <div>
                    <label class="text-black dark:text-gray-200" for="first_name">First Name</label>
                    <input id="first_name" type="text" name="first_name" class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>

                <div>
                    <label class="text-black dark:text-gray-200" for="last_name">Last Name</label>
                    <input id="last_name" type="text" name="last_name" class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>

                <div>
                    <label class="text-black dark:text-gray-200" for="status">Select</label>
                    <select name="status" class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                        <option value="Present">Present</option>
                        <option value="Absent">Absent</option>
                    </select>
                </div>

                <div>
                    <label class="text-black dark:text-gray-200" for="date">Date</label>
                    <input id="date" type="date" name="date" required class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                </div>
            </div>

            <div class="flex justify-end mt-6">
                <button type="submit" class="px-6 py-3 leading-5 text-white transition-colors duration-200 transform bg-indigo-600 rounded-md hover:bg-indigo-700 focus:outline-none focus:bg-gray-600">Mark Attendance</button>
            </div>
        </form>
    </section>
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String status = request.getParameter("status");
        String date = request.getParameter("date");

        try (Connection conn = DBConnection.getConnection()) {
            // Insert into attendance table
            String queryAttendance = "INSERT INTO attendance (first_name, last_name, status, date) VALUES (?, ?, ?, ?)";
            PreparedStatement psAttendance = conn.prepareStatement(queryAttendance, Statement.RETURN_GENERATED_KEYS);
            psAttendance.setString(1, firstName);
            psAttendance.setString(2, lastName);
            psAttendance.setString(3, status);
            psAttendance.setString(4, date);
            psAttendance.executeUpdate();

            // Get the generated student_id
            ResultSet generatedKeys = psAttendance.getGeneratedKeys();
            if (generatedKeys.next()) {
                int studentId = generatedKeys.getInt(1);

                // Insert into students table
                String queryStudent = "INSERT INTO students (student_id, first_name, last_name, subject, point) VALUES (?, ?, ?, NULL, NULL)";
                PreparedStatement psStudent = conn.prepareStatement(queryStudent);
                psStudent.setInt(1, studentId);
                psStudent.setString(2, firstName);
                psStudent.setString(3, lastName);
                psStudent.executeUpdate();

                out.println("<p class='text-green-500 font-semibold ml-6 mt-4'>"
                    + "<svg xmlns='http://www.w3.org/2000/svg' height='14' width='14' viewBox='0 0 512 512' class='inline-block mr-2'>"
                    + "<path fill='#63E6BE' d='M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z'/>"
                    + "</svg>"
                    + "Attendance marked successfully for Student ID: " + studentId + "</p>");
            }
        } catch (SQLException e) {
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>