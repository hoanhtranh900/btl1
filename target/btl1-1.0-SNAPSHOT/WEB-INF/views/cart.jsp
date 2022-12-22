<%--
  Created by IntelliJ IDEA.
  User: za
  Date: 12/22/2022
  Time: 8:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<c:set var="contextPath" value="${request.getContextPath()}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>cart</title>


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
    <div class="w-[calc(100%-20rem)] p-3">
        <form action="/save-order" method="post" id="form-create" class="w-full m-3" enctype="multipart/form-data"
              onsubmit="return confirmForChanges()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div id="hide-input">

            </div>
            <div class="flex shadow-md ">
                <div class="w-3/4 bg-white px-10 py-10">
                    <div class="flex justify-between border-b pb-8">
                        <h1 class="font-semibold text-2xl">Giở hàng</h1>
                        <h2 class="font-semibold text-2xl"><span id="total">0</span> Sản phẩm</h2>
                    </div>
                    <div class="flex mt-10 mb-5">
                        <h3 class="font-semibold text-gray-600 text-xs uppercase w-2/5">Sản phẩm</h3>
                        <h3 class="font-semibold text-center text-gray-600 text-xs uppercase w-1/5 text-center">Số
                            lượng</h3>
                        <h3 class="font-semibold text-center text-gray-600 text-xs uppercase w-1/5 text-center">Giá</h3>
                        <h3 class="font-semibold text-center text-gray-600 text-xs uppercase w-1/5 text-center">Tổng
                            tiền</h3>
                    </div>
                    <%--                    <div class="flex items-center hover:bg-gray-100 -mx-8 px-6 py-5">--%>
                    <%--                        <div class="flex w-2/5"> <!-- product -->--%>
                    <%--                            <div class="w-20">--%>
                    <%--                                <img class="h-24" src="http://localhost:8080/downloadFile/1"--%>
                    <%--                                     alt="">--%>
                    <%--                            </div>--%>
                    <%--                            <div class="flex flex-col justify-between ml-4 flex-grow">--%>
                    <%--                                <span class="font-bold text-sm">Iphone 6S</span>--%>
                    <%--                                <span class="text-red-500 text-xs">Apple</span>--%>
                    <%--                                <a href="#" class="font-semibold hover:text-red-500 text-gray-500 text-xs">Remove</a>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                        <div class="flex justify-center w-1/5">--%>
                    <%--                            <svg class="fill-current text-gray-600 w-3" viewBox="0 0 448 512">--%>
                    <%--                                <path d="M416 208H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h384c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>--%>
                    <%--                            </svg>--%>

                    <%--                            <input class="mx-2 border text-center w-8" type="text" value="1">--%>

                    <%--                            <svg class="fill-current text-gray-600 w-3" viewBox="0 0 448 512">--%>
                    <%--                                <path d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>--%>
                    <%--                            </svg>--%>
                    <%--                        </div>--%>
                    <%--                        <span class="text-center w-1/5 font-semibold text-sm">$400.00</span>--%>
                    <%--                        <span class="text-center w-1/5 font-semibold text-sm">$400.00</span>--%>
                    <%--                    </div>--%>
                    <div id="list-product">

                    </div>


                </div>


                <div id="summary" class="w-1/4 px-8 py-10">
                    <h1 class="font-semibold text-2xl border-b pb-8">Thông tin thanh toán</h1>

                    <div class="py-2">
                        <label class="font-medium inline-block mb-3 text-sm uppercase">Giao hàng</label>
                        <div class="block p-2 text-gray-600 w-full text-sm">
                            <div>Phí giao hàng: 15000</div>
                        </div>
                    </div>
                    <div class="py-2">
                        <label class="font-medium inline-block mb-3 text-sm uppercase">Địa chỉ nhận hàng</label>
                        <input id="address"
                               class="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
                               type="text" placeholder="Nhập địa chỉ" aria-label="dia chi">

                    </div>

                    <div class="border-t mt-2">
                        <div class="flex font-semibold justify-between py-6 text-sm uppercase">
                            <span>Tổng tiền thanh toán</span>
                            <span id="total-money">0</span>
                        </div>
                        <button type="submit"
                                class="bg-indigo-500 font-semibold hover:bg-indigo-600 py-3 text-sm text-white uppercase w-full">
                            Thanh toán
                        </button>
                    </div>
                </div>

            </div>
        </form>

    </div>

</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        //check if have message error
        var message = "${message}";
        if (message != "") {
            alert(message);
        }


        let cart = JSON.parse(localStorage.getItem('cart'));
        let listProduct = document.getElementById('list-product');
        let total = 0;
        console.log(cart);
        for (let i = 0; i < cart.length; i++) {
            let product = cart[i];
            let productId = product.id;
            let productName = product.title;
            //substring if length ? 10 show ...
            let description = product.description;
            if(description.length > 20){
                description = description.substring(0,10) + "...";
            }
            let author = product.author;
            let price = product.price;
            let quantity = product.quantity;

            let div = document.createElement('div');
            div.className = 'flex items-center hover:bg-gray-100 -mx-8 px-6 py-5';
            div.innerHTML = `
            <div class="flex w-2/5">
                <div class="w-20">
                    <img class="h-24" src="http://localhost:8080/downloadFile/` + productId + `"
                         alt="">
                </div>
                <div class="flex flex-col justify-between ml-4 flex-grow">
                    <span class="font-bold text-sm">` + productName + `</span>
                    <span class="text-red-500 text-xs">` + author + `</span>
                    <span class="font-semibold hover:text-red-500 text-gray-500 text-xs">` + description + `</span>
                </div>
            </div>
            <div class="flex justify-center w-1/5">
                <svg class="fill-current text-gray-600 w-3" viewBox="0 0 448 512" onclick="decreaseQuantity(` + productId + `)">
                    <path d="M416 208H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h384c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>
                </svg>

                <input class="mx-2 border text-center w-8" type="text" value="` + quantity + `">

                <svg class="fill-current text-gray-600 w-3" viewBox="0 0 448 512" onclick="increaseQuantity(` + productId + `)">
                    <path d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32
                    V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"/>
                </svg>
            </div>
            <span class="text-center w-1/5 font-semibold text-sm">` + price + `</span>
            <span class="text-center w-1/5 font-semibold text-sm">` + price * quantity + `</span>
        `;
            listProduct.appendChild(div);
            total += (Number(price) * Number(quantity));
        }
        document.getElementById('total').innerHTML = cart ? cart.length : 0;
        document.getElementById('total-money').innerHTML = total;

    });

    function decreaseQuantity(productId) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        for (let i = 0; i < cart.length; i++) {
            let product = cart[i];
            if (product.id === productId) {
                if (product.quantity > 1) {
                    product.quantity--;
                } else {
                    cart.splice(i, 1);
                }
            }
        }
        localStorage.setItem('cart', JSON.stringify(cart));
        window.location.reload();
    }

    function increaseQuantity(productId) {
        let cart = JSON.parse(localStorage.getItem('cart'));
        for (let i = 0; i < cart.length; i++) {
            let product = cart[i];
            if (product.id === productId) {
                product.quantity++;
            } else {
                cart.splice(i, 1);
            }
        }
        localStorage.setItem('cart', JSON.stringify(cart));
        window.location.reload();
    }

    function confirmForChanges() {
        console.log("helo")
        // use ajax to send data to controller
        let cart = JSON.parse(localStorage.getItem('cart'));
        let listProduct = document.getElementById('list-product');
        let stringCart = localStorage.getItem('cart').toString().trim();

        //calulate total money
        let totalMoney = 0;
        if (cart.length > 0) {
            for (let i = 0; i < cart.length; i++) {
                let product = cart[i];
                let price = product.price;
                let quantity = product.quantity;
                totalMoney += (Number(price) * Number(quantity));
            }
            let address = document.getElementById('address').value;
            // add data to id = hide-input
            let hideInput = document.getElementById('hide-input');
            hideInput.innerHTML = `
                <input type="hidden" name="totalMoney" value="` + totalMoney + `">
                <input type="hidden" name="address" value="` + address + `">
                <textarea name="cart" style="display: none">` + stringCart + `</textarea>

            `;


        } else {
            let hideInput = document.getElementById('hide-input');
            hideInput.innerHTML = `
                <input type="hidden" name="totalMoney" value="">
                <input type="hidden" name="address" value="">
                <textarea name="cart" style="display: none"></textarea>
                `
        }

    }
</script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"
        integrity="sha512-CryKbMe7sjSCDPl18jtJI5DR5jtkUWxPXWaLCst6QjH8wxDexfRJic2WRmRXmstr2Y8SxDDWuBO6CQC6IE4KTA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

</body>
</html>
