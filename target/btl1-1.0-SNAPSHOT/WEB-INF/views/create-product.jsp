<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
        <form action="/save" method="post" id="form-create" class="w-full m-3" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${book.id}"/>

            <h2>Thêm sách</h2>

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
                        <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
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
                        <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-pages">
                                Số trang
                            </label>
                            <input name="pages" value="${book.pages}"
                                   class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
                                   id="grid-pages" type="number"/>
                        </div>
                        <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
                                   for="grid-pages">
                                Giá
                            </label>
                            <input name="price" value="${book.price}"
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

                                <div class="delete-file-btn">
                                    <button type="button" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                                            onclick="deleteFile()">
                                        Xóa ảnh
                                    </button>
                                </div>
                            </div>
                        </div>

                        <img id="output"/>

                    </div>
                </div>
            </div>


            <%--            submit--%>
            <div class="flex flex-wrap -mx-3 mb-6">
                <div class="w-full px-3 mb-6 md:mb-0">
                    <button type="button" onclick="checkSubmit()"
                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                        Save
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"
        integrity="sha512-CryKbMe7sjSCDPl18jtJI5DR5jtkUWxPXWaLCst6QjH8wxDexfRJic2WRmRXmstr2Y8SxDDWuBO6CQC6IE4KTA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/script.js"></script>

</body>
</html>
