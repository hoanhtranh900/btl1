<%--
  Created by IntelliJ IDEA.
  User: za
  Date: 12/23/2022
  Time: 12:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="contextPath" value="${request.getContextPath()}"/>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<div class="flex">
    <jsp:include page="slidebar.jsp"></jsp:include>
    <div class="w-full m-3">
        <div class="w-[100%] p-3">
            <div class="flex shadow-md ">
                <div class="w-[100%] bg-white px-10 py-10">
                    <div class="flex justify-between border-b pb-8">
                        <h1 class="font-semibold text-2xl">Lịch sử đặt hàng</h1>
                        <h2 class="font-semibold text-2xl"><span id="total">
                                0
                        </span> Đơn hàng</h2>
                    </div>
                    <div class="flex mt-10 mb-5">
                        <h3 class="font-semibold text-gray-600 text-xs uppercase w-[5%]">STT</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%] ">Ngày
                            đặt hàng</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">Thành
                            tiền</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">Trạng
                            thái</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">địa chỉ</h3>
                        <h3 class="font-semibold text-gray-600 text-xs uppercase w-[20%]">Sản phẩm</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">Số
                            lượng</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">
                            Giá</h3>
                        <h3 class="font-semibold  text-gray-600 text-xs uppercase w-[10%]">
                            Hành động</h3>

                    </div>
                    <div id="list-product" class="overflow-y-auto h-[65vh] overflow-x-hidden">

                    </div>


                </div>


            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"
        integrity="sha512-CryKbMe7sjSCDPl18jtJI5DR5jtkUWxPXWaLCst6QjH8wxDexfRJic2WRmRXmstr2Y8SxDDWuBO6CQC6IE4KTA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

<script>
    function changeStatus(e, id) {
        console.log(id)
        //call ajax update
        $.ajax({
            url: "${contextPath}/order/updateStatus",
            type: "GET",
            data: {
                id: id,
                status: document.getElementById("select1").value
            },
            success: function (data) {
                console.log(data)
                if (data) {
                    alert("Cập nhật thành công")
                } else {
                    alert("Cập nhật thất bại")
                }
            }
        })

    }

    function cancelOrder(id) {
        $.ajax({
            url: "${contextPath}/order/cancelOrder",
            type: "GET",
            data: {
                id: id
            },
            success: function (data) {
                console.log(data)
                if (data) {
                    alert("Hủy đơn hàng thành công")
                    window.location.reload()
                } else {
                    alert("Hủy đơn hàng thất bại")
                }
            }
        })
    }

    $(document).ready(function () {
        let orderBooks_ = [];
        let result = [];
        <c:forEach items="${orderBooks}" var="orderBook">
        orderBooks_.push({
            id: ${orderBook.id},
            book: {
                id: ${orderBook.book.id},
                title: "${orderBook.book.title}",
                author: "${orderBook.book.author}",
                description: "${orderBook.book.description}",
                price: ${orderBook.book.price},
                image: "${contextPath}/downloadFile/${orderBook.book.id}"
            },
            quantity: ${orderBook.quantity},
            total: ${orderBook.total},
            status: ${orderBook.status},
            price: "${orderBook.book.priceString}",
            address: "${orderBook.address}",
            moneyConvert: "${orderBook.moneyConvert}",
            buyDateString: "${orderBook.buyDateString}",
            statusString: "${orderBook.statusString}",
            orderHistoryId: "${orderBook.orderHistoryId}"

        });
        </c:forEach>

        result = _.chain(orderBooks_)
            .groupBy('orderHistoryId')
            .map((value, key) => ({
                orderHistoryId: key,
                total: _.sumBy(value, 'total'),
                moneyConvert: value[0].total.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}),
                orderBooks: value,
                status: value[0].status,
                address: value[0].address,
                buyDateString: value[0].buyDateString,
                statusString: value[0].statusString,
                imageFirst: value[0].book.image
            }))
            .value();

        console.log(orderBooks_);
        console.log(result);

        let html = '';
        result.forEach((item, index) => {
            if (result[index].orderBooks) {
                result[index].orderBooks.forEach((item1, index1) => {
                    //just show index + 1 at first item
                    html += `<div class="flex items-center hover:bg-gray-100  py-5">
                            <div class="flex w-[5%]">
                                <span class="text-left font-semibold text-sm ">` + ((index1 == 0) ? (index + 1) : "") + `</span>
                            </div>

                            <span class=" w-[10%] font-semibold text-sm">` + ((index1 == 0) ? (item.buyDateString) : "") + `</span>

                             <div class="flex w-[10%]">
                                <span class="text-left font-semibold text-sm ml-3">` + ((index1 == 0) ? (item.moneyConvert) : "") + `</span>
                            </div>

                            <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">
                                <span class=" w-[10%] font-semibold text-sm">` + ((index1 == 0) ? (item.statusString) : "") + `</span>
                            </c:if>
                            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                                <select id="select1" onchange="changeStatus(this,`+ item1.id + ` )" style="opacity: ` + ((index1 == 0) ? 1 : 0) + `" ` + ((index1 == 0) ? "" : "disabled") + ` class=" w-[10%] font-semibold text-sm">
                                    <option value="1" `+ ((item.status == 1) ? "selected" : "") + `>Đang xử lý</option>>Chờ xử lý</option>
                                    <option value="2" `+ ((item.status == 2) ? "selected" : "") + `>Đang giao hàng</option>
                                    <option value="3" `+ ((item.status == 3) ? "selected" : "") + `>Đã giao hàng</option>
                                    <option value="4" `+ ((item.status == 4) ? "selected" : "") + `>Đã hủy</option>
                                </select>
                            </c:if>
                            <span class=" w-[10%] font-semibold text-sm text-left ml-3">` + ((index1 == 0) ? (item.address) : "") + `</span>

                            <div class="flex w-[20%]">
                                <div>
                                    <img class="h-24" src="` + item1.book.image + `" alt="">
                                </div>
                                <div class="flex flex-col justify-between ml-4 flex-grow">
                                    <span class="font-bold text-sm">` + item1.book.title + `</span>
                                    <span class="text-red-500 text-xs">` + item1.book.author + `</span>
                                    <span class="font-semibold hover:text-red-500 text-gray-500 text-xs">` + item1.book.description + `</span>
                                </div>
                            </div>
                            <span class=" w-[10%] font-semibold text-sm text-left">` + item1.quantity + `</span>

                            <span class=" w-[10%] font-semibold text-sm text-left">` + item1.price + `</span>

                            <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">
                                <button onclick="cancelOrder(`+ item1.id + `)" class="w-[10%]
                                bg-blue-500 hover:bg-blue-700
                                ` + ((index1 == 0 ) ? "" : "hidden") + `
                                ` + ((item1.status == 4 || item1.status == 3 ) ? "hidden" : "") + `
                                text-white font-bold py-2 px-4 rounded">Hủy</button>
                            </c:if>

                        </div>`;

                })
            }
        });

        // add html to id = list-product
        $('#list-product').html(html);
        $('#total').html(result.length);



    })

</script>

</body>
</html>
