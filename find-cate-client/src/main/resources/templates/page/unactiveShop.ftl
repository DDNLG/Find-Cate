<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Find Cate</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900" rel="stylesheet">
    <!-- Simple line Icon -->
    <link rel="stylesheet" href="css/simple-line-icons.css">
    <!-- Themify Icon -->
    <link rel="stylesheet" href="css/themify-icons.css">
    <!-- Hover Effects -->
    <link rel="stylesheet" href="css/set1.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="/scss/bootstrap.css"/>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>
    <#assign JwtToken=Session.jwtToken>
    <script type="text/javascript">
        function GetUserInfomation(jwtToken) {
            $.ajax({
                url:"${backserver}/user/info",
                type: "get",
                contentType: 'application/json',
                beforeSend: function(request) {
                    request.setRequestHeader("Jwt-Token",jwtToken);
                },
                success: function(data){
                    var json = eval(data);
                    $("#navbarDropdownMenuLink").text(data.content[0].userName+">>");
                    $("#usertel").text(data.content[0].userTelenumber);
                    $("#userDeal").append('<a class="dropdown-item" href="/user/quit">退出登录</a>');
                    if(data.content[0].userEmail=="484499@qq.com")
                        $("#userDeal").append('<a class="dropdown-item" href="/active">审核</a>');
                }
            })
        }
        $(document).ready(function(){
                $.ajax({url:"${backserver}/shop/unactive",
                    // dataType:"json",
                    type: 'get',
                    contentType: "application/x-www-form-urlencoded",
                    beforeSend:function(request){
                        request.setRequestHeader("Jwt-Token","${JwtToken}");
                    },
                    success:function(data){
                        var json = eval(data);
                        $.each(json,function (key,shop) {
                            var shopId=shop.shopId;
                            var shopName=shop.shopName;
                            var shopTelenumber=shop.shopTelenumber;
                            var shopAddress=shop.shopAddress;
                            var value = "<tr><td>"+shopId+"</td>"
                            +"<td>"+shopName+"</td>"+
                                "<td>"+shopTelenumber+"</td>"+
                                "<td>"+shopAddress+"</td>" +
                                '<td><a class="shopActive" id="'+shopId+'" href="#">激活</a></td>' +
                                "</tr>"
                            ;
                            $("#tb").append(value);
                        })
                    },
                    error:function () {

                    }

                });
            });
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(document).click(function(e){
                // console.log(e.target.tagName);
                if(e.target.tagName=="A"&&e.target.className=="shopActive"){
                var id = {
                    "id":$(e.target).attr("id")
                };

            $.ajax({url:"${backserver}/shop/active",
                // dataType:"json",
                type: 'post',
                contentType: "application/json",
                data:JSON.stringify(id),
                beforeSend:function(request){
                    request.setRequestHeader("Jwt-Token","${JwtToken}");
                },
                success:function(){
                    $(location).attr('href', 'active');
                },
                error:function () {

                }

            });
        }
        });
        });
    </script>
</head>
<body class="container">
<div class="dark-bg sticky-top">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="navbar-brand" href="/index">Find Cate</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-menu"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <ul class="navbar-nav">
                            <#if Session.jwtToken?exists>
                            <script>
                                $(document).ready(function(){
                                    GetUserInfomation("${jwtToken}");
                                });
                            </script>
                            <li class="nav-item dropdown">
                                <a class="nav-link" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    用户名
                                    <span class="icon-arrow-down"></span>
                                </a>
                                <div id="userDeal" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="/user/info">个人主页</a>
                                    <a class="dropdown-item" href="/index">返回</a>
                                    <!--<a class="dropdown-item" href="#"></a>-->
                                    <!--<a class="dropdown-item" href="#">Something else here</a>-->
                                </div>
                            </li>
                            <#else>
                            <li>
                                <a href="/user/login" class="btn btn-outline-light top-btn"></span> 登录</a>
                            </li>
                            <li><a href="/user/register" class="btn btn-outline-light top-btn"><span class="ti-plus"></span> 注册</a></li>
                            </#if>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</div>
<br/>
<h1>申请列表</h1>
<br/><br/>
<div class="with:80%">
    <table class="table table-hover">
        <thead>
        <tr>
            <th>shopId</th>
            <th>shopName</th>
            <th>shopTelenumber</th>
            <th>shopAddress</th>
            <th>审核</th>
        </tr>
        </thead>
        <tbody id="tb">



        </tbody>
    </table>
</div>
<!--<div class="form-group">-->
<!--<div class="col-sm-2 control-label">-->
<!--<a href="/toAdd" th:href="" class="btn btn-info">上一页</a>-->
<!--</div>-->
<!--<div class="col-sm-2 control-label">-->
<!--<a href="/toAdd" th:href="" class="btn btn-info">下一页</a>-->
<!--</div>-->
<!--</div>-->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
<footer class="main-block dark-bg">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="copyright">

                    <p>网络162第八组&nbsp&nbsp&nbsp&nbsp<a href="#" target="_blank" title="关于我们">关于我们

                            <ul>
                                <li><a href="#"><span class="ti-facebook"></span></a></li>
                                <li><a href="#"><span class="ti-twitter-alt"></span></a></li>
                                <li><a href="#"><span class="ti-instagram"></span></a></li>
                            </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
</html>