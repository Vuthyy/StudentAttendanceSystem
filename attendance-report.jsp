<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Attendance Report</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function editRecord(studentId, firstName, lastName, date, status) {
            document.getElementById("studentId").value = studentId;
            document.getElementById("firstName").value = firstName;
            document.getElementById("lastName").value = lastName;
            document.getElementById("date").value = date;
            document.getElementById("status").value = status;
            document.getElementById("updateAttendanceModal").style.display = "block";
        }

        function confirmDelete(studentId) { 
            document.getElementById("deleteStudentId").value = studentId; 
            document.getElementById("deleteModal").style.display = "block"
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }
    </script>
    
    <style>
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            position: relative;
            width: 90%;
            max-width: 500px;
        }
        .close {
            position: absolute;
            top: 10px;
            right: 20px;
            color: #aaa;
            font-size: 30px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>    
</head>
<body>
    <div class="font-[sans-serif] overflow-x-auto">
        <h1 class="text-xl font-bold text-black capitalize dark:text-black mb-6">Attendance Report</h1>
        <table class="min-w-full bg-white">
          <thead class="bg-gray-800 whitespace-nowrap">
            <tr>
              <th class="p-4 text-left text-sm font-medium text-white">
                Student ID
              </th>
              <th class="p-4 text-left text-sm font-medium text-white">
                First Name
              </th>
              <th class="p-4 text-left text-sm font-medium text-white">
                Last Name
              </th>
              <th class="p-4 text-left text-sm font-medium text-white">
                Date
              </th>
              <th class="p-4 text-left text-sm font-medium text-white">
                Status
              </th>
              <th class="p-4 text-left text-sm font-medium text-white">
                Action
              </th>
            </tr>
          </thead>
  
            <tbody class="whitespace-nowrap">
                <%
                    try (Connection conn = DBConnection.getConnection()) {
                        String query = "SELECT student_id, date, status, first_name, last_name FROM attendance";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) { 
                            String status = rs.getString("status"); 
                            String rowClass = status.equalsIgnoreCase("Present") ? "bg-green-500 text-white py-1 px-2 rounded-full text-xs" : "bg-red-500 text-white py-1 px-2 rounded-full text-xs";
                %>
                <tr class="even:bg-blue-50">
                    <td class="p-4 text-sm text-black">
                        <%= rs.getInt("student_id") %>
                    </td>
                    <td class="p-4 text-sm text-black">
                        <%= rs.getString("first_name") %>
                    </td>
                    <td class="p-4 text-sm text-black">
                        <%= rs.getString("last_name") %>
                    </td>
                    <td class="p-4 text-sm text-black">
                        <%= rs.getString("date") %>
                    </td>
                    <td class="p-4 text-sm text-black">
                        <span class="<%= rowClass %>"> <%= rs.getString("status") %></span>
                    </td>
                    <td class="p-4">
                        <button class="mr-4" title="Edit" onclick="editRecord(<%= rs.getInt("student_id") %>, '<%= rs.getString("first_name") %>', '<%= rs.getString("last_name") %>', '<%= rs.getString("date") %>', '<%= rs.getString("status") %>')">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 fill-blue-500 hover:fill-blue-700" viewBox="0 0 348.882 348.882">
                                <path d="m333.988 11.758-.42-.383A43.363 43.363 0 0 0 304.258 0a43.579 43.579 0 0 0-32.104 14.153L116.803 184.231a14.993 14.993 0 0 0-3.154 5.37l-18.267 54.762c-2.112 6.331-1.052 13.333 2.835 18.729 3.918 5.438 10.23 8.685 16.886 8.685h.001c2.879 0 5.693-.592 8.362-1.76l52.89-23.138a14.985 14.985 0 0 0 5.063-3.626L336.771 73.176c16.166-17.697 14.919-45.247-2.783-61.418z" />
                                <path d="M303.85 138.388c-8.284 0-15 6.716-15 15v127.347c0 21.034-17.113 38.147-38.147 38.147H68.904c-21.035 0-38.147-17.113-38.147-38.147V100.413c0-21.034 17.113-38.147 38.147-38.147h131.587c8.284 0 15-6.716 15-15s-6.716-15-15-15H68.904C31.327 32.266.757 62.837.757 100.413v180.321c0 37.576 30.571 68.147 68.147 68.147h181.798c37.576 0 68.147-30.571 68.147-68.147V153.388c.001-8.284-6.715-15-14.999-15z" />
                            </svg>
                        </button>
                        <button class="mr-4" title="Delete" onclick="confirmDelete(<%= rs.getInt("student_id") %>)">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 fill-red-500 hover:fill-red-700" viewBox="0 0 24 24">
                                <path d="M19 7a1 1 0 0 0-1 1v11.191A1.92 1.92 0 0 1 15.99 21H8.01A1.92 1.92 0 0 1 6 19.191V8a1 1 0 0 0-2 0v11.191A3.918 3.918 0 0 0 8.01 23h7.98A3.918 3.918 0 0 0 20 19.191V8a1 1 0 0 0-1-1Zm1-3h-4V2a1 1 0 0 0-1-1H9a1 1 0 0 0-1 1v2H4a1 1 0 0 0 0 2h16a1 1 0 0 0 0-2ZM10 4V3h4v1Z" />
                                <path d="M11 17v-7a1 1 0 0 0-2 0v7a1 1 0 0 0 2 0Zm4 0v-7a1 1 0 0 0-2 0v7a1 1 0 0 0 2 0Z" />
                            </svg>
                        </button>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Edit Attendance Modal -->
    <div id="updateAttendanceModal" class="modal" style="display:none;">
        <div class="modal-content p-8 mt-8 ml-44">
            <span class="close text-gray-500 cursor-pointer float-right text-2xl" onclick="closeModal('updateAttendanceModal')">&times;</span>
            <h2 class="text-2xl mb-4">Edit Attendance</h2>
            <form method="POST" action="updateAttendance.jsp">
                <input type="hidden" name="studentId" id="studentId">
                <div class="mb-4">
                    <label class="block text-sm font-bold mb-2">First Name</label>
                    <input type="text" name="firstName" id="firstName" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-bold mb-2">Last Name</label>
                    <input type="text" name="lastName" id="lastName" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-bold mb-2">Date</label>
                    <input type="date" name="date" id="date" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-bold mb-2">Status</label>
                    <select name="status" id="status" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        <option value="Present">Present</option>
                        <option value="Absent">Absent</option>
                    </select>
                </div>
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Update
                    </button>
                    <button type="button" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="closeModal('updateAttendanceModal')">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Attendance Modal -->
    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-content p-8 mt-8 ml-44">
            <span class="close text-gray-500 cursor-pointer float-right text-2xl" onclick="closeModal('deleteModal')">&times;</span>
            <h2 class="text-2xl mb-4">Confirm Delete</h2>
            <form method="POST" action="deleteAttendance.jsp">
                <input type="hidden" name="studentId" id="deleteStudentId">
                <p>Are you sure you want to delete this record?</p>
                <div class="flex items-center justify-between mt-4">
                    <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Delete
                    </button>
                    <button type="button" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="closeModal('deleteModal')">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>