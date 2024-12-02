<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    String username = request.getParameter("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        * {
            box-sizing: border-box;
        }
        /* Ensure the entire page takes full height */
            html, body {
            height: 100%;
            margin: 0;
            overflow: hidden; /* Prevent scrolling inside iframe */
        }

        /* Layout for sidebar and main content */
        body {
            display: flex;
            flex-direction: row;
            height: 100%;
        }

        aside {
            flex-shrink: 0;
            height: 100%;
            width: 240px; /* Adjust sidebar width */
            background-color: #fff;
            border-right: 1px solid #ddd;
            padding-top: 20px;
        }

        main {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
            overflow: hidden;
        }

        #contentArea {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            height: 100%;
            overflow: hidden; /* Prevent overflow */
        }


        #iframeContent {
            height: 100vh;  /* Set to viewport height */
            width: 100%;
            border: none;
        }


        .active {
            background-color: #E2E8F0;
            color: #1F2937;
        }
    </style>
</head>
<body>
    <aside class="flex flex-col w-72 h-screen px-4 py-8 overflow-y-auto bg-white border-r rtl:border-r-0 rtl:border-l dark:bg-gray-900 dark:border-gray-700">
        <h2 class="text-3xl font-bold">Student System</h2>
    
        <div class="flex flex-col justify-between flex-1 mt-4">
            <nav>
                <a id="attendanceLink" class="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-gray-200 hover:text-gray-700" href="javascript:void(0)" onclick="loadPage('attendance.jsp', this)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M17.988 22a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h11.988zM9 5h6v2H9V5zm5.25 6.25A2.26 2.26 0 0 1 12 13.501c-1.235 0-2.25-1.015-2.25-2.251S10.765 9 12 9a2.259 2.259 0 0 1 2.25 2.25zM7.5 18.188c0-1.664 2.028-3.375 4.5-3.375s4.5 1.711 4.5 3.375v.563h-9v-.563z"></path></svg>
    
                    <span class="mx-4 font-medium">Manage Attendance</span>
                </a>
    
                <a id="performanceLink" class="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-gray-200 hover:text-gray-700" href="javascript:void(0)" onclick="loadPage('performance.jsp', this)">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        <path d="M12 14C8.13401 14 5 17.134 5 21H19C19 17.134 15.866 14 12 14Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
    
                    <span class="mx-4 font-medium">Manage Performance</span>
                </a>
    
                <a id="attendanceReporLink" class="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-gray-200 hover:text-gray-700" href="javascript:void(0)" href="" onclick="loadPage('attendance-report.jsp', this)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><circle cx="12" cy="4" r="2"></circle><path d="M12 18h2v-5h2V9c0-1.103-.897-2-2-2h-4c-1.103 0-2 .897-2 2v4h2v5h2z"></path><path d="m18.446 11.386-.893 1.789C19.108 13.95 20 14.98 20 16c0 1.892-3.285 4-8 4s-8-2.108-8-4c0-1.02.892-2.05 2.446-2.825l-.893-1.789C3.295 12.512 2 14.193 2 16c0 3.364 4.393 6 10 6s10-2.636 10-6c0-1.807-1.295-3.488-3.554-4.614z"></path></svg>
    
                    <span class="mx-4 font-medium">View Attendance</span>
                </a>
    
                <a id="performanceReportLink" class="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-gray-200 hover:text-gray-700" href="javascript:void(0)" onclick="loadPage('performance-report.jsp', this)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M8 12.052c1.995 0 3.5-1.505 3.5-3.5s-1.505-3.5-3.5-3.5-3.5 1.505-3.5 3.5 1.505 3.5 3.5 3.5zM9 13H7c-2.757 0-5 2.243-5 5v1h12v-1c0-2.757-2.243-5-5-5zm11.294-4.708-4.3 4.292-1.292-1.292-1.414 1.414 2.706 2.704 5.712-5.702z"></path></svg>
    
                    <span class="mx-4 font-medium">View Performance</span>
                </a>
    
                <hr class="my-6 border-gray-200 dark:border-gray-600" />
            </nav>
            <span class="mx-4 font-medium -mb-14">User Profile</span>
            <div class="flex items-center px-4 -mx-2">
                <img class="object-cover mx-2 rounded-full h-9 w-9" src="https://thumbs.dreamstime.com/b/vibrant-cartoon-profile-illustration-featuring-cheerful-young-person-hooded-sweatshirt-pic-customizable-335486586.jpg" alt="avatar" />
                <span class="mx-2 font-medium text-gray-800 dark:text-gray-200"><%= username %></span>
            </div>
        </div>
    </aside>
    <main class="p-6">
        <div id="contentArea class="flex-1">
            <!-- Content will be loaded dynamically here -->
            <iframe id="iframeContent" src="attendance.jsp" width="100%" height="100%" frameborder="0"></iframe>
        </div>
    </main>

    <script>
        // Function to load content into the iframe and set the active class
        function loadPage(page, element) {
            // Remove active class from all links
            const links = document.querySelectorAll('nav a');
            links.forEach(link => link.classList.remove('active'));
            
            // Add active class to the clicked link
            element.classList.add('active');
            
            // Load the content into the iframe
            const iframe = document.getElementById('iframeContent');
            iframe.src = page;
        }
    
        // Load default page (attendance.jsp) on page load
        window.onload = function() {
            loadPage('attendance.jsp', document.getElementById('attendanceLink'));
        };
    </script>
</body>
</html>

