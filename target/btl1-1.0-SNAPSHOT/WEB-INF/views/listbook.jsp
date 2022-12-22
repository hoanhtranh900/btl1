<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="contextPath" value="${request.getContextPath()}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Danh sach</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div class="flex">
    <%--    include slidebar--%>
    <jsp:include page="slidebar.jsp"></jsp:include>

    <%--    with = 100% - slidebar--%>
    <div class="w-[calc(100%-20rem)] p-3">

        <div class="mb-3 d-flex justify-content-between">
            <div>
                <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                            onclick="window.location.href='${contextPath}/create'">
                        Thêm mới
                    </button>
                </c:if>
            </div>
            <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">

                <%--            number of cart--%>
                <div class="flex items-center">
                    <button class="flex items-center justify-center flex-shrink-0 h-auto relative focus:outline-none transform"
                            aria-label="cart-button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18px" height="18px" viewBox="0 0 20 20"
                             class="md:w-4 xl:w-5 md:h-4 xl:h-5">
                            <path d="M5,4H19a1,1,0,0,1,1,1V19a1,1,0,0,1-1,1H5a1,1,0,0,1-1-1V5A1,1,0,0,1,5,4ZM2,5A3,3,0,0,1,5,2H19a3,3,0,0,1,3,3V19a3,3,0,0,1-3,3H5a3,3,0,0,1-3-3Zm10,7C9.239,12,7,9.314,7,6H9c0,2.566,1.669,4,3,4s3-1.434,3-4h2C17,9.314,14.761,12,12,12Z"
                                  transform="translate(-2 -2)" fill="currentColor" fill-rule="evenodd"></path>
                        </svg>
                        <span id="cart-number" class="cart-counter-badge
                    min-w-[20px] min-h-[20px]
                    flex items-center justify-center
                    bg-heading text-white absolute
                    -top-2.5 xl:-top-3 -right-3 -end-2.5 xl:-end-3 rounded-full font-bold bg-[#000] text-[#fff] ">0</span>
                    </button>
                </div>
            </c:if>

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
                                    <th>Sản phẩm</th>
                                    <th>Tiêu đề</th>
                                    <th>Tác giả</th>
                                    <th class="w-[30%]">Mô tả</th>
                                    <th>Ngày phát hành</th>
                                    <th>Số trang</th>
                                    <th>Thể loại</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach items="${books}" var="item">
                                    <tr>
                                        <td>
                                            <img href="${contextPath}/downloadFile/${item.id}"
                                                 src="${contextPath}/downloadFile/${item.id}"
                                                 alt="image" class="w-20 h-20">
                                        </td>
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
                                                <%--                                            show when login--%>
                                            <c:if test="${pageContext.request.userPrincipal != null}">
                                                <%--                                                check role if user show view detail else show delete and edit--%>
                                                <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">
                                                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                                                            onclick="window.location.href='${contextPath}/detailOredit/${item.id}'">
                                                        Xem chi tiết
                                                    </button>
                                                    <%--                                                   add to cart--%>
                                                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                                                            onclick="addToCart(${item.id}, '${item.title}', '${item.author}', '${item.description}', '${item.publishedDate}', '${item.pages}', '${item.type}', '${item.price}')">
                                                        Thêm vào giỏ hàng
                                                    </button>
                                                </c:if>
                                                <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                                                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                                                            onclick="window.location.href='${contextPath}/detailOredit/${item.id}'">
                                                        Sửa
                                                    </button>
                                                    <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                                                            onclick="window.location.href='${contextPath}/delete/${item.id}'">
                                                        Xóa
                                                    </button>
                                                </c:if>


                                            </c:if>
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

<!-- /container -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

<script>


    document.addEventListener("DOMContentLoaded", function () {
        //get number of cart from local storage
        loadCart()
        console.log("hello");
        var messageType = "${messageType}";
        if (messageType != "") {
            //check if messageType = 99 show notification toast
            if (messageType == "99") {
                //edit text of id = message-toast
                $("#message-toast").text("Đặt hàng thành công");
                $('#toast-id').toast('show')
            }
        }
    });

    function loadCart() {
        let cart = JSON.parse(localStorage.getItem("cart"));
        if (cart == null) {
            cart = [];
        }
        // check quantity per item
        let cartNumber = 0;
        cart.forEach(item => {
            cartNumber += item.quantity;
        })
        document.getElementById("cart-number").innerText = cartNumber;
    }

    function addToCart(id, title, author, description, publishedDate, pages, type, price) {

        let cart = JSON.parse(localStorage.getItem("cart"));
        if (cart == null) {
            cart = [];
        }
        let book = {
            id: id,
            title: title,
            author: author,
            description: description,
            publishedDate: publishedDate,
            price: price,
            pages: pages,
            type: type,
            image: ${contextPath} +"/downloadFile/" + id,
            quantity: 1
        }
        //if exist update quantity
        let index = cart.findIndex(item => item.id == id);
        if (index != -1) {
            cart[index].quantity++;
        } else {
            cart.push(book);
        }
        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
        alert('Thêm vào giỏ hàng thành công');

    }
</script>


</body>
</html>
