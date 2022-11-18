<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Danh sach</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div class="flex">
    <div class="w-64 " aria-label="Sidebar">
        <div class="overflow-y-auto py-4 px-3 bg-gray-50 rounded dark:bg-gray-800 h-[100vh]">
            <ul class="space-y-2">
                <li>
                    <a href="#" class="flex items-center p-2 text-base font-normal rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                        <svg aria-hidden="true" class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z"></path><path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z"></path></svg>
                        <span class="ml-3 text-zinc-50	 hover:text-gray-900 dark:hover:text-white">
                            Danh sách
                        </span>
                    </a>
                </li>
                <li>
                    <a href="#" class="flex items-center p-2 text-base font-normal rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                        <svg aria-hidden="true" class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path></svg>
                        <span class="ml-3 text-zinc-50	 hover:text-gray-900 dark:hover:text-white">Thông tin tài khoản</span>
                    </a>
                </li>
                <li>
                    <a href="${contextPath}/login?logout" class="flex items-center p-2 text-base font-normal  rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                        <svg aria-hidden="true" class="flex-shrink-0 w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z" clip-rule="evenodd"></path></svg>
                        <span class="ml-3  text-zinc-50	 hover:text-gray-900 dark:hover:text-white">Đăng xuất</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="flex flex-column w-full m-3">

        <div class="mb-3">
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onclick="window.location.href='${contextPath}/create'">
                Thêm mới</button>
        </div>

        <div id="content">
            <div class="">
                <div class="card shadow mb-4">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-primary">Danh sách tài liệu</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>Tiêu đề</th>
                                    <th>Tác giả</th>
                                    <th class="w-[40%]">Mô tả</th>
                                    <th>Ngày phát hành</th>
                                    <th>Số trang</th>
                                    <th>Thể loại</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
<%--                                <tr>--%>
<%--                                    <td>Tiger Nixon</td>--%>
<%--                                    <td>System Architect</td>--%>
<%--                                    <td>Edinburgh</td>--%>
<%--                                    <td>61</td>--%>
<%--                                    <td>2011/04/25</td>--%>
<%--                                    <td>$320,800</td>--%>
<%--                                    <td>--%>
<%--&lt;%&ndash;                                        view detail&ndash;%&gt;--%>
<%--                                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">--%>
<%--                                            Xem--%>
<%--                                        </button>--%>
<%--                                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">--%>
<%--                                            Sửa--%>
<%--                                        </button>--%>
<%--                                        <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">--%>
<%--                                            Xóa--%>
<%--                                        </button>--%>
<%--                                    </td>--%>
<%--                                </tr>--%>

                                <c:forEach items="${books}" var="item">
                                    <tr>
                                        <td>${item.title}</td>
                                        <td>${item.author}</td>
                                        <td>${item.description}</td>
                                        <td>${item.publishedDate}</td>
                                        <td>${item.pages}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.type == 1}">
                                                    <span>Truyện tranh</span>
                                                </c:when>
                                                <c:when test="${item.type == 2}">
                                                    <span>Truyện ngắn</span>
                                                </c:when>
                                                <c:when test="${item.type == 3}">
                                                    <span>Truyện dài</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>Khác</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                                                    onclick="window.location.href='${contextPath}/detailOredit/${item.id}'">
                                                Sửa
                                            </button>
                                            <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                                                    onclick="window.location.href='${contextPath}/delete/${item.id}'">
                                                Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

        </div>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- /container -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

</body>
</html>
