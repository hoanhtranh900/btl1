<%--
  Created by IntelliJ IDEA.
  User: za
  Date: 12/22/2022
  Time: 7:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="contextPath" value="${request.getContextPath()}"/>
<html>
<body>
<div class="w-64" aria-label="Sidebar">
    <div class="overflow-y-auto py-4 px-1 bg-gray-800 rounded h-[100vh] ">
        <ul class="space-y-2">
            <li>
                <a href="${contextPath}/list"
                   class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-500">
                    <svg aria-hidden="true"
                         class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                         fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z"></path>
                        <path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z"></path>
                    </svg>
                    <span class="ml-3 text-zinc-50 hover:text-gray-900">
                            Danh sách
                        </span>
                </a>
            </li>

            <c:if test="${pageContext.request.userPrincipal != null}">
                <li>
                    <a href="${contextPath}/logout"
                       class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-500">
                        <svg aria-hidden="true"
                             class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                             fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                  d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1z"
                                  clip-rule="evenodd"></path>
                        </svg>
                        <span class="ml-3 text-zinc-50 hover:text-gray-900">
                                Đăng xuất
                            </span>
                    </a>
                </li>
            </c:if>
            <c:if test="${pageContext.request.userPrincipal == null}">
                <li>
                    <a href="${contextPath}/login"
                       class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-500">
                        <svg aria-hidden="true"
                             class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                             fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                  d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1z"
                                  clip-rule="evenodd"></path>
                        </svg>
                        <span class="ml-3 text-zinc-50 hover:text-gray-900">
                                Đăng nhập
                            </span>
                    </a>
                </li>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">

                <li>
                    <a href="${contextPath}/cart"
                       class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-500">
                        <svg aria-hidden="true"
                             class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                             fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z"></path>
                            <path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z"></path>
                        </svg>
                        <span class="ml-3 text-zinc-50 hover:text-gray-900">
                            Giỏ hàng
                        </span>
                    </a>
                </li>
            </c:if>



        </ul>
    </div>
</div>
<div role="alert" aria-live="assertive" aria-atomic="true"  data-delay="5000" id="toast-id" class="toast position-fixed top-[15px] right-[15px] z-50" >
    <div class="toast-body" id="message-toast">

    </div>
</div>
</body>
</html>
