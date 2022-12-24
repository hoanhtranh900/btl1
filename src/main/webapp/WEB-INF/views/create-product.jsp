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

    <title>page2</title>

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
    <%--    with = 100% - slidebar--%>
    <div class="w-[calc(100%-20rem)]">
        <div class="my-3 d-flex justify-content-between">
            <div>
                <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">

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

        <form action="/save" method="post" id="form-create" class="w-full m-3" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${book.id}"/>
            <input type="hidden" name="currentRole" value="${pageContext.request.isUserInRole('ROLE_USER')}"/>


            <div class="flex">
                <div class="w-[50%]">

                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label
                                    class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                    for="grid-title">
                                Tiêu đề
                            </label>
                            <input name="title" value="${book.title}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   id="grid-title" type="text"/>
                        </div>
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-author">
                                Tác giả
                            </label>
                            <input name="author" value="${book.author}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   id="grid-author" type="text"/>
                        </div>
                    </div>
                    <%--            description--%>
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-description">
                                Mô tả
                            </label>
                            <%--                            <textarea name="description"--%>
                            <%--                                           class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"--%>
                            <%--                                           id="grid-description" type="text"/>--%>
                            <textarea name="description"
                                      class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                      id="grid-description" type="text">${book.description}</textarea>
                        </div>
                    </div>

                    <%--            publish date and pages--%>
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2">
                                Ngày phát hành
                            </label>
                            <div class="row justify-content-center">
                                <div class="mb-3">
                                    <input value="${book.publishedDate}"
                                           id="publish-date" class="form-control" type="date" name="publishedDate"/>

                                    <span id="startDateSelected"></span>
                                </div>
                            </div>
                        </div>
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-pages">
                                Số trang
                            </label>
                            <input name="pages" value="${book.pages}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   id="grid-pages" type="number"/>
                        </div>
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-pages">
                                Giá
                            </label>
                            <input name="price" value="${book.price}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   type="number"/>
                        </div>
                        <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-pages">
                                Số lượng còn lại
                            </label>
                            <input name="remain" value="${book.remain}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   type="number"/>
                        </div>
                    </div>

                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-type">
                                Thể loại
                            </label>
                            <select name="type" value="${book.type}"
                                    class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                    id="grid-type">
                                <option value="1">Truyện tranh</option>
                                <option value="2">Truyện ngắn</option>
                                <option value="3">Truyện dài</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="w-[50%]">
                    <%--                    upload image--%>
                    <div class="flex flex-wrap mx-3 mb-6">
                        <div class="w-full mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-image">
                                Ảnh bìa
                            </label>
                            <div class="flex">
                                <input onchange="loadFile(event)" name="file"
                                       class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                       id="grid-image" type="file"/>

                                <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                                    <div class="delete-file-btn">
                                        <button type="button"
                                                class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                                                onclick="deleteFile()">
                                            Xóa ảnh
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <img id="output"/>

                    </div>
                </div>
            </div>


            <%--            submit--%>
            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                <div class="flex flex-wrap -mx-3 mb-6">
                    <div class="w-full px-3 mb-6 md:mb-0">
                        <button type="button" onclick="checkSubmit()"
                                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                            Save
                        </button>
                    </div>
                </div>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('ROLE_USER')}">
            <div class="flex">
                <div class="w-[40%]">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 px-3"
                               for="grid-pages">
                            Số lượng
                        </label>
                        <div class="flex w-full px-3 mb-6 md:mb-0">
                            <div class="align-self-center">
                                <input name="numberToBuy" type="number"
                                       class="appearance-none block  bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                       id="numberToBuy"/>
                            </div>
                            <div class="align-self-center">
                                <button type="button"
                                        onclick="addToCart(${book.id}, '${book.title}', '${book.author}', '${book.description}', '${book.publishedDate}', '${book.pages}', '${book.type}', '${book.price}')"
                                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                    Thêm vào giỏ hàng
                                </button>
                            </div>
                        </div>
                    </div>

                        <%--                vote ( max is 5 and min is 1 ) --%>
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 px-3"
                               for="grid-pages">
                            Đánh giá
                        </label>
                        <div class="flex w-full px-3 mb-6 md:mb-0 gap-3">
                            <div>
                                <input name="vote" placeholder="Nội dung đánh giá"
                                       class="appearance-none block  bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                       id="vote"/>
                            </div>
                            <div class="align-self center">
                                <select class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                        id="vote-star">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                            </div>
                            <div class="align-self center">
                                <button type="button"
                                        onclick="voteBook(${book.id}, '${book.title}', '${book.author}', '${book.description}', '${book.publishedDate}', '${book.pages}', '${book.type}', '${book.price}')"
                                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                    Đánh giá
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-[60%]">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 px-3"
                               for="grid-pages">
                            Đánh giá: <c:out value="${votes.size()}"/> lượt.
                            Trung bình: <c:out value="${averageVote}"/> sao
<%--                            ( >3 - chán, >4 - bình thường, >4.5 - hay )--%>
                            ( <c:choose>
                                <c:when test="${averageVote < 3.5}">
                                    <c:out value="chán"/>
                                </c:when>
                                <c:when test="${averageVote < 4.5}">
                                    <c:out value="bình thường"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="hay"/>
                                </c:otherwise>
                        </c:choose> )
                        </label>

                        <div class="container max-h-[30vh] overflow-y-scroll">
                            <div class="row">
                                <div class="col-md-8" id="vote-list">
                                        <%--                                    <div class="comments-list">--%>
                                        <%--                                        <div class="media">--%>
                                        <%--                                            <p class="pull-right"><small>5 days ago</small></p>--%>
                                        <%--                                            <div class="media-body">--%>
                                        <%--                                                <h4 class="media-heading user_name">Baltej Singh</h4>--%>
                                        <%--                                                Wow! this is really great.--%>
                                        <%--                                            </div>--%>
                                        <%--                                        </div>--%>
                                        <%--                                    </div>--%>
                                    <c:forEach items="${votes}" var="vote">
                                        <div class="comments-list">
                                            <div class="media">
                                                <p class="pull-right text-xs"><small>${vote.voteDate}</small></p>
                                                <div class="media-body">
                                                    <h4 class="media-heading user_name"><b>${vote.user.fullName} - ${vote.vote} sao</b>
                                                        </h4>
                                                        ${vote.comment}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:if>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"
        integrity="sha512-CryKbMe7sjSCDPl18jtJI5DR5jtkUWxPXWaLCst6QjH8wxDexfRJic2WRmRXmstr2Y8SxDDWuBO6CQC6IE4KTA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

<script>
    $(document).ready(function () {
        //check role if has role_user disable all input, select
        //get by name = currentRole
        let currentRole = $("input[name='currentRole']").val();
        if (currentRole) {
            $("input").attr("disabled", true);
            $("select").attr("disabled", true);
            $("textarea").attr("disabled", true);
            // $("button").attr("disabled", true);
        }
        // expect numberToBuy
        $("input[name='numberToBuy']").attr("disabled", false);
        $("input[name='vote']").attr("disabled", false);
        //expect vote-star
        $("select[id='vote-star']").attr("disabled", false);

    });

    function voteBook(bookId, title, author, description, publishedDate, pages, type, price) {
        let voteComment = $("input[name='vote']").val();
        let voteStar = $("select[id='vote-star']").val();

        console.log(vote);
        $.ajax({
            url: "${contextPath}/vote",
            type: "GET",
            dataType: 'json',
            data: {
                bookId: bookId,
                voteComment: voteComment,
                voteStar: voteStar
            },
            contentType: "application/json",
            success: function (data) {
                console.log(data);
                if (data) {
                    alert("Đánh giá thành công");
                    window.location.href = "${contextPath}/detailOredit/" + bookId;
                } else {
                    alert("Đánh giá thất bại");
                }
            },
            fail: function (e) {
                console.log(e);
                alert("Đánh giá thất bại");
            }
        })
    }


    var deleteFile = function () {
        document.getElementById("output").src = "";
        document.getElementById("grid-image").value = "";
    }

    var loadFile = function (event) {
        var output = document.getElementById('output');

        //set max height and width
        output.style.maxHeight = "300px";
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
            URL.revokeObjectURL(output.src) // free memory
        }
    };

    //show value for publish-date
    <%--var publishDate = "${book.publishedDate}";--%>
    <%--document.getElementById("publish-date").value = publishDate;--%>
    <%--console.log(publishDate);--%>
</script>
<script>


    document.addEventListener("DOMContentLoaded", function () {
        //get number of cart from local storage
        loadCart();
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
        let numberToBuy = document.getElementById("numberToBuy").value;
        if (numberToBuy == null || numberToBuy == "") {
            alert("Vui lòng nhập số lượng");
            return;
        }

        let cart = JSON.parse(localStorage.getItem("cart"));
        if (cart == null) {
            cart = [];
        }
        for (let i = 0; i < numberToBuy; i++) {
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
        }


        loadCart();
        alert('Thêm vào giỏ hàng thành công');
        //clear numberToBuy
        document.getElementById("numberToBuy").value = "";

    }
</script>
<script>
    function checkSubmit() {
        console.log("helo")
        var author = document.getElementById("form-create").author.value;
        var title = document.getElementById("form-create").title.value;
        var description = document.getElementById("form-create").description.value;
        var pages = document.getElementById("form-create").pages.value;
        var type = document.getElementById("form-create").type.value;
        var publishDate = document.getElementById("form-create").publishedDate.value;

        if (author == "" || title == "" || description == "" || pages == "" || type == "" || publishDate == "" || publishDate == undefined) {
            alert("Vui lòng nhập đầy đủ thông tin");
        } else document.getElementById("form-create").submit();
    }

    //check if have message error
    var message = "${message}";
    if (message != "") {
        alert(message);
    }

    let publishDate = "${book.publishedDate}";
    if (publishDate != "") {

        //covert publishDate to date
        let date = new Date(publishDate);

        document.getElementById("publish-date").valueAsDate = date
    }

    let image = '${book.image}';
    if (image != "") {
        let img = document.getElementById("output");
        img.src = "data:image/png;base64," + image;
        //set max height and width
        img.style.maxHeight = "300px";

    }


</script>


</body>
</html>
