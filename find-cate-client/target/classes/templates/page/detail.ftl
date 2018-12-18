<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Colorlib">
    <meta name="description" content="#">
    <meta name="keywords" content="#">
    <!-- Favicons -->
    <link rel="shortcut icon" href="#">
    <!-- Page Title -->
    <title>Listing &amp; Directory Website Template</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900" rel="stylesheet">
    <!-- Simple line Icon -->
    <link rel="stylesheet" href="/css/simple-line-icons.css">
    <!-- Themify Icon -->
    <link rel="stylesheet" href="/css/themify-icons.css">
    <!-- Hover Effects -->
    <link rel="stylesheet" href="/css/set1.css">
    <!-- Swipper Slider -->
    <link rel="stylesheet" href="/css/swiper.min.css">
    <!-- Magnific Popup CSS -->
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="/css/style.css">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>

    <script type="text/javascript">
        $(document).ready(function(){
            GetTheShopInformation();
        });

        $(document).ready(function () {
            GetCommityList();
        });

        $(document).ready(function () {
            hideAndShow();
        });

        $(document).ready(function () {
            $("#sendCommity").click(function () {
                if ($("#commityContent").val().trim().length >= 1) {
                    $.ajax({url:"http://localhost:12344/commity/comment",
                        // dataType:"json",
                        type: 'post',
                        contentType: 'application/json',
                        data:JSON.stringify(GetCommityJsonData()),
                        beforeSend: function(request) {
                            request.setRequestHeader("Jwt-Token","${jwtToken}");
                        }
                        ,success:function(data){
                            var json = eval(data);
                            $("#commityContent").val('');
                            $("#commitylist").empty();
                            GetCommityList();
                        }
                    });
                } else {
                    alert("输入不能为空！");
                }
                return false;
            })
        });

        function replyCommity(commityId) {
            if ($("#content"+commityId).val().trim().length>=1){
                $.ajax({url:"http://localhost:12344/reply/replys",
                    // dataType:"json",
                    type: 'post',
                    contentType: 'application/json',
                    data:JSON.stringify(GetReplyJsonData(commityId)),
                    beforeSend: function(request) {
                        request.setRequestHeader("Jwt-Token","${jwtToken}");
                    }
                    ,success:function(data){
                        var json = eval(data);
                        $(".replyArea").toggle();
                        $("#commitylist").empty();
                        GetCommityList();
                    }
                });
            } else {
                alert("输入不能为空！");
            }
            return false;
        }
        function GetReplyJsonData(commityId) {
            var json = {
                "commity_id": commityId,
                "reply_content": $("#content"+commityId).val()
            };
            return json;
        }
        
        <#--function sendCommity() {-->
            <#--if ($("#commityContent").val().trim().length >= 1) {-->
                <#--$.ajax({url:"http://localhost:12344/commity/comment",-->
                    <#--// dataType:"json",-->
                    <#--type: 'post',-->
                    <#--contentType: 'application/json',-->
                    <#--data:JSON.stringify(GetCommityJsonData()),-->
                    <#--beforeSend: function(request) {-->
                        <#--request.setRequestHeader("Jwt-Token","${jwtToken}");-->
                    <#--}-->
                    <#--,success:function(data){-->
                        <#--var json = eval(data);-->
                        <#--$("#commitylist").empty();-->
                        <#--GetCommityList();-->
                    <#--}-->
                <#--});-->
            <#--} else {-->
                <#--alert("输入不能为空！");-->
            <#--}-->
            <#--return false;-->
        <#--}-->

        function GetCommityJsonData() {
            var json = {
                "shop_id":${shopId},
                "comment":$("#commityContent").val()
            }
            return json;
        }

        function hideAndShow() {
            $(document).click(function(e) {
                if (e.target.tagName == "A" && e.target.className=='replyShow') {
                    var id = e.target.id
                    $("#replyArea"+id).toggle();
                }
            });
        }

        function GetTheShopInformation() {
            $.ajax({
                url:"${backserver}/shop/getone?shopId=${shopId}",
                type: 'get',
                contentType: 'application/json',
                success: function (data) {
                    var json = eval(data);
                    $("#shop_id").text(json.content[0].shopId);
                    $("#shop_name").text(json.content[0].shopName);
                    $("#shop_address").text(json.content[0].shopAddress);
                    $("#shop_telenumber").text(json.content[0].shopTelenumber)
                }
            })
        }
        function GetCommityList() {
            $.ajax({
                url:"${backserver}/commity/gets?shopId=${shopId}",
                type:'get',
                contentType:'application/json',
                success:function (data) {
                    var json = eval(data);
                    createCommityElement(json)
                }
            })
        }

        function GetUserInfomation() {
            $.ajax({
                url:"${backserver}/user/info",
                type: "get",
                contentType: 'application/json',
                beforeSend: function(request) {
                    request.setRequestHeader("Jwt-Token","${jwtToken}");
                },
                success: function(data){
                    var json = eval(data);
                    $("#userimg").append("<img class=\"img-fluid\" src=\"${imgserver}/"+data.content[0].userPhoto +"\"  width=\"130\" height=\"130\" >");
                    $("#navbarDropdownMenuLink").text(data.content[0].userName+">>");
                }
            })
        }

        function createCommityElement(data) {
            var modelList = data.numberOfElements;
            var commity = data.content;
            if(modelList>0){

                for(var i=0; i<modelList; i++){
                    // var option="<option value=\""+modelList[i].modelId+"\"";
                    // if(_LastModelId && _LastModelId==modelList[i].modelId){
                    //     option += " selected=\"selected\" "; //默认选中
                    //     _LastModelId=null;
                    // }
                    var value ="<div class=\"customer-review_wrap\">" +
                            "<div class=\"customer-img\">" +
                            "<img src=\"/images/customer-img1.jpg\" class=\"img-fluid\" alt=\"#\">" +
                            "<p>"+ commity[i].user.userName +"</p>" +
                            "</div>" +
                            "<div class=\"customer-content-wrap\">" +
                            "<div class=\"customer-content\">" +
                            "<div class=\"customer-review\">" +
                            "<h4>标题</h4>" +
                            "<span></span>" +
                            "<span></span>" +
                            "<span></span>" +
                            "<span></span>" +
                            "<span class=\"round-icon-blank\"></span>" +
                            "<p>"+ commity[i].commityTime + "</p>" +
                            "</div>" +
                            "<div class=\"customer-rating\">8.0</div>" +
                            "</div>" +
                            "<p id=\"commity_content\" class=\"customer-text\">" + commity[i].commityContent +"</p>" +
                            "<a style='margin: 0 0 0 460px' id=\""+commity[i].commityId+"\" class='replyShow'><span class=\"icon-like\"></span>回复</a>"+
                            "<hr>"+
                            "<p id = \"replylist"+commity[i].commityId+"\"></p>"+
                            "<ul>" +
                            "</ul>" +
                            "<div class='replyArea' id = \"replyArea"+commity[i].commityId+"\" style=\"padding: 50px 50px 10px;\">" +
                            "<form class=\"bs-example bs-example-form\" id='reply' role=\"form\" onsubmit='return replyCommity("+commity[i].commityId+")'>"+
                            "   <div class=\"row\">"+
                            "       <div class=\"input-group\">"+
                            "           <textarea form='reply' name=\"content\" id=\"content"+commity[i].commityId +"\"  style=\"width:350px;height:200px;\">"+
                            "</textarea>"+
                            "           <span class=\"input-group-btn\">"+
                            "               <input id=\"send\" style='margin-top: -53px' class=\"btn btn-default\" type=\"submit\" >"+
                            "           </span>"+
                            "       </div>"+
                            "   </div>"+
                            "</form>"+
                            "</div>"+
                            "                                            </div>" +
                            "                                            </div>" ;
                    $("#commitylist").append(value);
                    $.each(commity[i].replyList,function (key,reply) {
                        var value ="<div style='margin:15px 0 0 20px'>"+
                                "<div class=\"customer-review\">"+
                                "<p>回复人："+ reply.user.userName +"</p>"+
                                "</div>"+
                                "<br/>"+
                                "<p style='margin-top: -15px' class=\"customer-text\">" + reply.replyContent +"</p>"+
                                "<br/>"+
                                "<p >"+ reply.replyTime +"</p>"+
                                "<br/>"+
                                "</div>"+
                                "<hr>";
                        $("#replylist"+commity[i].commityId).append(value);
                    })

                }
                $(".replyArea").hide();
            }
        }

        // function createReplyElement(data) {
        //
        //     if (modelList>0){
        //         for (var j=0; j<modelList; j++) {
        //             var value = "<p>"+ reply[j].user.userName +"</p>"+
        //                         "<p class=\"customer-text\">" + reply[j].replayContent +"</p>";
        //             $("#replylist"+reply.commity.commityId).append(value);
        //         }
        //     }
        // }
    </script>
</head>

<body>
<!--============================= HEADER =============================-->
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
                                            GetUserInfomation();
                                        });
                                    </script>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            用户名
                                            <span class="icon-arrow-down"></span>
                                        </a>
                                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                            <a class="dropdown-item" id="userpage" href="/user/info">个人主页</a>
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
<!--//END HEADER -->
<!--============================= BOOKING =============================-->
<div>
    <!-- Swiper -->
    <div class="swiper-container">
        <div class="swiper-wrapper">

            <div class="swiper-slide">
                <a href="/images/reserve-slide2.jpg" class="grid image-link">
                    <img src="/images/reserve-slide2.jpg" class="img-fluid" alt="#">
                </a>
            </div>
            <div class="swiper-slide">
                <a href="/images/reserve-slide1.jpg" class="grid image-link">
                    <img src="/images/reserve-slide1.jpg" class="img-fluid" alt="#">
                </a>
            </div>
            <div class="swiper-slide">
                <a href="/images/reserve-slide3.jpg" class="grid image-link">
                    <img src="/images/reserve-slide3.jpg" class="img-fluid" alt="#">
                </a>
            </div>
            <div class="swiper-slide">
                <a href="/images/reserve-slide1.jpg" class="grid image-link">
                    <img src="/images/reserve-slide1.jpg" class="img-fluid" alt="#">
                </a>
            </div>
            <div class="swiper-slide">
                <a href="/images/reserve-slide2.jpg" class="grid image-link">
                    <img src="/images/reserve-slide2.jpg" class="img-fluid" alt="#">
                </a>
            </div>
            <div class="swiper-slide">
                <a href="/images/reserve-slide3.jpg" class="grid image-link">
                    <img src="/images/reserve-slide3.jpg" class="img-fluid" alt="#">
                </a>
            </div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination swiper-pagination-white"></div>
        <!-- Add Arrows -->
        <div class="swiper-button-next swiper-button-white"></div>
        <div class="swiper-button-prev swiper-button-white"></div>
    </div>
</div>
<!--//END BOOKING -->
<!--============================= RESERVE A SEAT =============================-->
<section class="reserve-block">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5 id="shop_name">Tasty Hand-Pulled Noodles</h5>
                <p><span>$$$</span>$$</p>
                <p class="reserve-description">Innovative cooking, paired with fine wines in a modern setting.</p>
            </div>
            <div class="col-md-6">
                <div class="reserve-seat-block">
                    <div class="reserve-rating">
                        <span>9.5</span>
                    </div>
                    <div class="review-btn">
                        <a href="#review" class="btn btn-outline-danger">WRITE A REVIEW</a>
                        <span id="commity_total"></span>
                    </div>
                    <div class="reserve-btn">
                        <div class="featured-btn-wrap">
                            <a href="#" class="btn btn-danger">RESERVE A SEAT</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--//END RESERVE A SEAT -->
<!--============================= BOOKING DETAILS =============================-->
<section class="light-bg booking-details_wrap">
    <div class="container">
        <div class="row">
            <div class="col-md-8 responsive-wrap">
                <div class="booking-checkbox_wrap">
                    <div class="booking-checkbox">
                        <p>Tasty Hand-Pulled Noodles is a 1950s style diner located in Madison, Wisconsin. Opened in 1946 by Mickey Weidman, and located just across the street from Camp Randall Stadium, it has become a popular game day tradition amongst
                            many Badger fans. The diner is well known for its breakfast selections, especially the Scrambler, which is a large mound of potatoes, eggs, cheese, gravy, and a patrons’ choice of other toppings.</p>
                        <p>Mickies has also been featured on “Todd’s Taste of the Town” during one of ESPN’s college football broadcasts. We are one of the best Chinese restaurants in the New York, New York area. We have been recognized for our outstanding
                            Chinese & Asian cuisine, excellent Chinese menu, and great restaurant specials. We are one of the best Chinese restaurants in the New York, New York area. We have been recognized for our outstanding Chinese & Asian cuisine,
                            excellent Chinese menu, and great restaurant specials.</p>
                        <hr>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Bike Parking</span>
                            </label> </div>
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Wireless Internet  </span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Smoking Allowed  </span>
                            </label> </div>
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Street Parking</span>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Special</span>
                            </label> </div>
                        <div class="col-md-4">
                            <label class="custom-checkbox">
                                <span class="ti-check-box"></span>
                                <span class="custom-control-description">Accepts Credit cards</span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="booking-checkbox_wrap mt-4" >
                    <a name="review"></a>
                    <h5 >评论区</h5>
                    <hr>
                    <div style="padding: 50px 50px 10px;">

                        <form class="bs-example bs-example-form"  id='commity' role="form" onsubmit='return false'>
                            <div class="row">
                                <div class="input-group">
                                  <textarea form='commity' name="commityContent" id="commityContent"  style="width:550px;height:150px;"></textarea>
                                    <span class="input-group-btn">
                                        <input id="sendCommity" style='margin-top: -122px' class="btn btn-default" type="submit" >
                                    </span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div id="commitylist">

                    </div>
                <#--<div class="customer-review_wrap">-->
                <#--<div class="customer-img">-->
                <#--<img src="/images/customer-img1.jpg" class="img-fluid" alt="#">-->
                <#--<p>Amanda G</p>-->
                <#--</div>-->
                <#--<div class="customer-content-wrap">-->
                <#--<div class="customer-content">-->
                <#--<div class="customer-review">-->
                <#--<h6>Best noodles in the Newyork city</h6>-->
                <#--<span></span>-->
                <#--<span></span>-->
                <#--<span></span>-->
                <#--<span></span>-->
                <#--<span class="round-icon-blank"></span>-->
                <#--<p id="commity_time"></p>-->
                <#--</div>-->
                <#--<div class="customer-rating">8.0</div>-->
                <#--</div>-->

                <#--<p id="commity_content" class="customer-text">xxxxxxx-->
                <#--</p>-->
                <#--<ul>-->
                <#--<li><img src="/images/review-img1.jpg" class="img-fluid" alt="#"></li>-->
                <#--<li><img src="/images/review-img2.jpg" class="img-fluid" alt="#"></li>-->
                <#--<li><img src="/images/review-img3.jpg" class="img-fluid" alt="#"></li>-->
                <#--</ul>-->
                <#--<span>28 people marked this review as helpful</span>-->
                <#--<a href="#"><span class="icon-like"></span>Helpful</a>-->
                <#--</div>-->
                <#--</div>-->
                    <hr>
                    <#--<div style="padding: 50px 50px 10px;">-->
                    <#--<form class="bs-example bs-example-form" id='reply' role="form" onsubmit='return false'>-->
                      <#--<div class="row">-->
                           <#--<div class="input-group">-->
                                  <#--<textarea form='reply' name="content" id="content"  style="width:550px;height:150px;">-->
                            <#--</textarea>-->
                                   <#--&lt;#&ndash;<input id='commity_id' value='commity[i].commityId' type='hidden'>&ndash;&gt;-->
                                  <#--<span class="input-group-btn">-->
                                          <#--<input id="send" style='margin-top: -122px' class="btn btn-default" type="submit" >-->
                                       <#--</span>-->
                               <#--</div>-->
                       <#--</div>-->
                    <#--</form>-->
                    <#--</div>-->
                <#--</div>-->
                </div>
            </div>
            <div class="col-md-4 responsive-wrap">
                <div class="contact-info">
                    <!--<img src="/images/map.jpg" class="img-fluid" alt="#">-->
                    <div class="address">
                        <span class="icon-location-pin"></span>
                        <p id="shop_address"> Doyers St<br> New York, NY 10013<br> b/t Division St & St James Pl <br> Chinatown, Civic Center</p>
                    </div>
                    <div class="address">
                        <span class="icon-screen-smartphone"></span>
                        <p id="shop_telenumber"> +44 20 7336 8898</p>
                    </div>
                    <div class="address">
                        <span class="icon-link"></span>
                        <p>https://burgerandlobster.com</p>
                    </div>
                    <div class="address">
                        <span class="icon-clock"></span>
                        <p>Mon - Sun 09:30 am - 05:30 pm <br>
                            <span class="open-now">OPEN NOW</span></p>
                        <p id="shop_id"></p>
                    </div>
                    <!--<a href="#" class="btn btn-outline-danger btn-contact">SEND A MESSAGE</a>-->
                </div>
                <div class="follow">
                    <div class="follow-img">
                        <img src="/images/follow-img.jpg" class="img-fluid" alt="#">
                        <h6>Christine Evans</h6>
                        <span>New York</span>
                    </div>
                    <!--<ul class="social-counts">-->
                    <!--<li>-->
                    <!--<h6>26</h6>-->
                    <!--<span>Listings</span>-->
                    <!--</li>-->
                    <!--<li>-->
                    <!--<h6>326</h6>-->
                    <!--<span>Followers</span>-->
                    <!--</li>-->
                    <!--<li>-->
                    <!--<h6>12</h6>-->
                    <!--<span>Followers</span>-->
                    <!--</li>-->
                    <!--</ul>-->
                    <!--<a href="#">FOLLOW</a>-->
                </div>
            </div>
        </div>
    </div>
</section>
<!--//END BOOKING DETAILS -->
<!--============================= FOOTER =============================-->
<footer class="main-block dark-bg">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="copyright">

                    <p>Copyright &copy; 2018 Listing. All rights reserved | made with Colorlib -  More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>

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
<!--//END FOOTER -->




<!-- jQuery, Bootstrap JS. -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="/js/jquery-3.2.1.min.js"></script>
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<!-- Magnific popup JS -->
<script src="/js/jquery.magnific-popup.js"></script>
<!-- Swipper Slider JS -->
<script src="/js/swiper.min.js"></script>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3,
        slidesPerGroup: 3,
        loop: true,
        loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
</script>
<script>
    if ($('.image-link').length) {
        $('.image-link').magnificPopup({
            type: 'image',
            gallery: {
                enabled: true
            }
        });
    }
    if ($('.image-link2').length) {
        $('.image-link2').magnificPopup({
            type: 'image',
            gallery: {
                enabled: true
            }
        });
    }
</script>
</body>

</html>

<#--<!DOCTYPE html>-->
<#--<html lang="en">-->

<#--<head>-->
    <#--<!-- Required meta tags &ndash;&gt;-->
    <#--<meta charset="utf-8">-->
    <#--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <#--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
    <#--<meta name="author" content="Colorlib">-->
    <#--<meta name="description" content="#">-->
    <#--<meta name="keywords" content="#">-->
    <#--<!-- Favicons &ndash;&gt;-->
    <#--<link rel="shortcut icon" href="#">-->
    <#--<!-- Page Title &ndash;&gt;-->
    <#--<title>Listing &amp; Directory Website Template</title>-->
    <#--<!-- Bootstrap CSS &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/bootstrap.min.css">-->
    <#--<!-- Google Fonts &ndash;&gt;-->
    <#--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900" rel="stylesheet">-->
    <#--<!-- Simple line Icon &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/simple-line-icons.css">-->
    <#--<!-- Themify Icon &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/themify-icons.css">-->
    <#--<!-- Hover Effects &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/set1.css">-->
    <#--<!-- Swipper Slider &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/swiper.min.css">-->
    <#--<!-- Magnific Popup CSS &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/magnific-popup.css">-->
    <#--<!-- Main CSS &ndash;&gt;-->
    <#--<link rel="stylesheet" href="/css/style.css">-->
    <#--<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">-->
    <#--</script>-->

    <#--<script type="text/javascript">-->
        <#--$(document).ready(function(){-->
            <#--GetTheShopInformation();-->
        <#--});-->
        <#--function GetTheShopInformation() {-->
            <#--$.ajax({-->
                <#--url:"${backserver}/shop/getone?shopId=${shopId}",-->
                <#--type: 'get',-->
                <#--contentType: 'application/json',-->
                <#--success: function (data) {-->
                    <#--var json = eval(data);-->
                    <#--$("#shop_name").text(json.content[0].shopName);-->
                    <#--$("#shop_address").text(json.content[0].shopAddress);-->
                    <#--$("#shop_telenumber").text(json.content[0].shopTelenumber)-->
                <#--}-->
            <#--})-->
        <#--}-->
        <#--function GetCommityList() {-->
            <#--$.ajax({-->
                <#--url:"${backserver}/shop/getone?shopId=${shopId}",-->
            <#--})-->
        <#--}-->
        <#--function GetUserInfomation() {-->
            <#--$.ajax({-->
                <#--url:"${backserver}/user/info",-->
                <#--type: "get",-->
                <#--contentType: 'application/json',-->
                <#--beforeSend: function(request) {-->
                    <#--request.setRequestHeader("Jwt-Token","${jwtToken}");-->
                <#--},-->
                <#--success: function(data){-->
                    <#--var json = eval(data);-->
                    <#--$("#userimg").append("<img class=\"img-fluid\" src=\"${imgserver}/"+data.content[0].userPhoto +"\"  width=\"130\" height=\"130\" >");-->
                    <#--$("#navbarDropdownMenuLink").text(data.content[0].userName+">>");-->
                <#--}-->
            <#--})-->
        <#--}-->
    <#--</script>-->
<#--</head>-->

<#--<body>-->
    <#--<!--============================= HEADER =============================&ndash;&gt;-->
    <#--<div class="dark-bg sticky-top">-->
        <#--<div class="container-fluid">-->
            <#--<div class="row">-->
                <#--<div class="col-md-12">-->
                    <#--<nav class="navbar navbar-expand-lg navbar-light">-->
                        <#--<a class="navbar-brand" href="/index">Find Cate</a>-->
                        <#--<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">-->
              <#--<span class="icon-menu"></span>-->
            <#--</button>-->
                        <#--<div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">-->
                            <#--<ul class="navbar-nav">-->
                                <#--<#if Session.jwtToken?exists>-->
                                    <#--<script>-->
                                        <#--$(document).ready(function(){-->
                                            <#--GetUserInfomation();-->
                                        <#--});-->
                                    <#--</script>-->
                                    <#--<li class="nav-item dropdown">-->
                                        <#--<a class="nav-link" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">-->
                                            <#--用户名-->
                                            <#--<span class="icon-arrow-down"></span>-->
                                        <#--</a>-->
                                        <#--<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">-->
                                            <#--<a class="dropdown-item" id="userpage" href="/user/info">个人主页</a>-->
                                            <#--<!--<a class="dropdown-item" href="#"></a>&ndash;&gt;-->
                                            <#--<!--<a class="dropdown-item" href="#">Something else here</a>&ndash;&gt;-->
                                        <#--</div>-->
                                    <#--</li>-->
                                <#--<#else>-->
                                        <#--<li>-->
                                            <#--<a href="/user/login" class="btn btn-outline-light top-btn"></span> 登录</a>-->
                                        <#--</li>-->
                                        <#--<li><a href="/user/register" class="btn btn-outline-light top-btn"><span class="ti-plus"></span> 注册</a></li>-->
                                <#--</#if>-->
                            <#--</ul>-->
                        <#--</div>-->
                    <#--</nav>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
    <#--<!--//END HEADER &ndash;&gt;-->
    <#--<!--============================= BOOKING =============================&ndash;&gt;-->
    <#--<div>-->
        <#--<!-- Swiper &ndash;&gt;-->
        <#--<div class="swiper-container">-->
            <#--<div class="swiper-wrapper">-->

                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide2.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide2.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide1.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide1.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide3.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide3.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide1.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide1.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide2.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide2.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="swiper-slide">-->
                    <#--<a href="/images/reserve-slide3.jpg" class="grid image-link">-->
                        <#--<img src="/images/reserve-slide3.jpg" class="img-fluid" alt="#">-->
                    <#--</a>-->
                <#--</div>-->
            <#--</div>-->
            <#--<!-- Add Pagination &ndash;&gt;-->
            <#--<div class="swiper-pagination swiper-pagination-white"></div>-->
            <#--<!-- Add Arrows &ndash;&gt;-->
            <#--<div class="swiper-button-next swiper-button-white"></div>-->
            <#--<div class="swiper-button-prev swiper-button-white"></div>-->
        <#--</div>-->
    <#--</div>-->
    <#--<!--//END BOOKING &ndash;&gt;-->
    <#--<!--============================= RESERVE A SEAT =============================&ndash;&gt;-->
    <#--<section class="reserve-block">-->
        <#--<div class="container">-->
            <#--<div class="row">-->
                <#--<div class="col-md-6">-->
                    <#--<h5 id="shop_name">Tasty Hand-Pulled Noodles</h5>-->
                    <#--<p><span>$$$</span>$$</p>-->
                    <#--<p class="reserve-description">Innovative cooking, paired with fine wines in a modern setting.</p>-->
                <#--</div>-->
                <#--<div class="col-md-6">-->
                    <#--<div class="reserve-seat-block">-->
                        <#--<div class="reserve-rating">-->
                            <#--<span>9.5</span>-->
                        <#--</div>-->
                        <#--<div class="review-btn">-->
                            <#--<a href="#" class="btn btn-outline-danger">WRITE A REVIEW</a>-->
                            <#--<span id="commity_total">34 reviews</span>-->
                        <#--</div>-->
                        <#--<div class="reserve-btn">-->
                            <#--<div class="featured-btn-wrap">-->
                                <#--<a href="#" class="btn btn-danger">RESERVE A SEAT</a>-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</section>-->
    <#--<!--//END RESERVE A SEAT &ndash;&gt;-->
    <#--<!--============================= BOOKING DETAILS =============================&ndash;&gt;-->
    <#--<section class="light-bg booking-details_wrap">-->
        <#--<div class="container">-->
            <#--<div class="row">-->
                <#--<div class="col-md-8 responsive-wrap">-->
                    <#--<div class="booking-checkbox_wrap">-->
                        <#--<div class="booking-checkbox">-->
                            <#--<p>Tasty Hand-Pulled Noodles is a 1950s style diner located in Madison, Wisconsin. Opened in 1946 by Mickey Weidman, and located just across the street from Camp Randall Stadium, it has become a popular game day tradition amongst-->
                                <#--many Badger fans. The diner is well known for its breakfast selections, especially the Scrambler, which is a large mound of potatoes, eggs, cheese, gravy, and a patrons’ choice of other toppings.</p>-->
                            <#--<p>Mickies has also been featured on “Todd’s Taste of the Town” during one of ESPN’s college football broadcasts. We are one of the best Chinese restaurants in the New York, New York area. We have been recognized for our outstanding-->
                                <#--Chinese & Asian cuisine, excellent Chinese menu, and great restaurant specials. We are one of the best Chinese restaurants in the New York, New York area. We have been recognized for our outstanding Chinese & Asian cuisine,-->
                                <#--excellent Chinese menu, and great restaurant specials.</p>-->
                            <#--<hr>-->
                        <#--</div>-->
                        <#--<div class="row">-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                        <#--<span class="ti-check-box"></span>-->
                        <#--<span class="custom-control-description">Bike Parking</span>-->
                      <#--</label> </div>-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                       <#--<span class="ti-check-box"></span>-->
                       <#--<span class="custom-control-description">Wireless Internet  </span>-->
                     <#--</label>-->
                            <#--</div>-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                     <#--<span class="ti-check-box"></span>-->
                     <#--<span class="custom-control-description">Smoking Allowed  </span>-->
                   <#--</label> </div>-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                    <#--<span class="ti-check-box"></span>-->
                    <#--<span class="custom-control-description">Street Parking</span>-->
                  <#--</label>-->
                            <#--</div>-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                   <#--<span class="ti-check-box"></span>-->
                   <#--<span class="custom-control-description">Special</span>-->
                 <#--</label> </div>-->
                            <#--<div class="col-md-4">-->
                                <#--<label class="custom-checkbox">-->
                  <#--<span class="ti-check-box"></span>-->
                  <#--<span class="custom-control-description">Accepts Credit cards</span>-->
                <#--</label>-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<div class="booking-checkbox_wrap mt-4">-->
                        <#--<h5 id="commity_total">34 Reviews</h5>-->
                        <#--<hr>-->
                        <#--<div class="customer-review_wrap">-->
                            <#--<div class="customer-img">-->
                                <#--<img src="/images/customer-img1.jpg" class="img-fluid" alt="#">-->
                                <#--<p>Amanda G</p>-->
                            <#--</div>-->
                            <#--<div class="customer-content-wrap">-->
                                <#--<div class="customer-content">-->
                                    <#--<div class="customer-review">-->
                                        <#--<h6>Best noodles in the Newyork city</h6>-->
                                        <#--<span></span>-->
                                        <#--<span></span>-->
                                        <#--<span></span>-->
                                        <#--<span></span>-->
                                        <#--<span class="round-icon-blank"></span>-->
                                        <#--<p>Reviewed 2 days ago</p>-->
                                    <#--</div>-->
                                    <#--<div class="customer-rating">8.0</div>-->
                                <#--</div>-->
                                <#--<p class="customer-text">I love the noodles here but it is so rare that I get to come here. Tasty Hand-Pulled Noodles is the best type of whole in the wall restaurant. The staff are really nice, and you should be seated quickly. I usually get the-->
                                    <#--hand pulled noodles in a soup. House Special #1 is amazing and the lamb noodles are also great. If you want your noodles a little chewier, get the knife cut noodles, which are also amazing. Their dumplings are great-->
                                    <#--dipped in their chili sauce.-->
                                <#--</p>-->
                                <#--<p class="customer-text">I love how you can see into the kitchen and watch them make the noodles and you can definitely tell that this is a family run establishment. The prices are are great with one dish maybe being $9. You just have to remember-->
                                    <#--to bring cash.-->
                                <#--</p>-->
                                <#--<ul>-->
                                    <#--<li><img src="/images/review-img1.jpg" class="img-fluid" alt="#"></li>-->
                                    <#--<li><img src="/images/review-img2.jpg" class="img-fluid" alt="#"></li>-->
                                    <#--<li><img src="/images/review-img3.jpg" class="img-fluid" alt="#"></li>-->
                                <#--</ul>-->
                                <#--<span>28 people marked this review as helpful</span>-->
                                <#--<a href="#"><span class="icon-like"></span>Helpful</a>-->
                            <#--</div>-->
                        <#--</div>-->
                        <#--<hr>-->
                    <#--</div>-->
                <#--</div>-->
                <#--<div class="col-md-4 responsive-wrap">-->
                    <#--<div class="contact-info">-->
                        <#--<!--<img src="/images/map.jpg" class="img-fluid" alt="#">&ndash;&gt;-->
                        <#--<div class="address">-->
                            <#--<span class="icon-location-pin"></span>-->
                            <#--<p id="shop_address"> Doyers St<br> New York, NY 10013<br> b/t Division St & St James Pl <br> Chinatown, Civic Center</p>-->
                        <#--</div>-->
                        <#--<div class="address">-->
                            <#--<span class="icon-screen-smartphone"></span>-->
                            <#--<p id="shop_telenumber"> +44 20 7336 8898</p>-->
                        <#--</div>-->
                        <#--<div class="address">-->
                            <#--<span class="icon-link"></span>-->
                            <#--<p>https://burgerandlobster.com</p>-->
                        <#--</div>-->
                        <#--<div class="address">-->
                            <#--<span class="icon-clock"></span>-->
                            <#--<p>Mon - Sun 09:30 am - 05:30 pm <br>-->
                                <#--<span class="open-now">OPEN NOW</span></p>-->
                        <#--</div>-->
                        <#--<!--<a href="#" class="btn btn-outline-danger btn-contact">SEND A MESSAGE</a>&ndash;&gt;-->
                    <#--</div>-->
                    <#--<div class="follow">-->
                        <#--<div class="follow-img">-->
                            <#--<img src="/images/follow-img.jpg" class="img-fluid" alt="#">-->
                            <#--<h6>Christine Evans</h6>-->
                            <#--<span>New York</span>-->
                        <#--</div>-->
                        <#--<!--<ul class="social-counts">&ndash;&gt;-->
                            <#--<!--<li>&ndash;&gt;-->
                                <#--<!--<h6>26</h6>&ndash;&gt;-->
                                <#--<!--<span>Listings</span>&ndash;&gt;-->
                            <#--<!--</li>&ndash;&gt;-->
                            <#--<!--<li>&ndash;&gt;-->
                                <#--<!--<h6>326</h6>&ndash;&gt;-->
                                <#--<!--<span>Followers</span>&ndash;&gt;-->
                            <#--<!--</li>&ndash;&gt;-->
                            <#--<!--<li>&ndash;&gt;-->
                                <#--<!--<h6>12</h6>&ndash;&gt;-->
                                <#--<!--<span>Followers</span>&ndash;&gt;-->
                            <#--<!--</li>&ndash;&gt;-->
                        <#--<!--</ul>&ndash;&gt;-->
                        <#--<!--<a href="#">FOLLOW</a>&ndash;&gt;-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</section>-->
    <#--<!--//END BOOKING DETAILS &ndash;&gt;-->
    <#--<!--============================= FOOTER =============================&ndash;&gt;-->
    <#--<footer class="main-block dark-bg">-->
        <#--<div class="container">-->
            <#--<div class="row">-->
                <#--<div class="col-md-12">-->
                    <#--<div class="copyright">-->
                        <#---->
                        <#--<p>Copyright &copy; 2018 Listing. All rights reserved | made with Colorlib -  More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>-->
                        <#---->
                        <#--<ul>-->
                            <#--<li><a href="#"><span class="ti-facebook"></span></a></li>-->
                            <#--<li><a href="#"><span class="ti-twitter-alt"></span></a></li>-->
                            <#--<li><a href="#"><span class="ti-instagram"></span></a></li>-->
                        <#--</ul>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</footer>-->
    <#--<!--//END FOOTER &ndash;&gt;-->




    <#--<!-- jQuery, Bootstrap JS. &ndash;&gt;-->
    <#--<!-- jQuery first, then Popper.js, then Bootstrap JS &ndash;&gt;-->
    <#--<script src="/js/jquery-3.2.1.min.js"></script>-->
    <#--<script src="/js/popper.min.js"></script>-->
    <#--<script src="/js/bootstrap.min.js"></script>-->
    <#--<!-- Magnific popup JS &ndash;&gt;-->
    <#--<script src="/js/jquery.magnific-popup.js"></script>-->
    <#--<!-- Swipper Slider JS &ndash;&gt;-->
    <#--<script src="/js/swiper.min.js"></script>-->
    <#--<script>-->
        <#--var swiper = new Swiper('.swiper-container', {-->
            <#--slidesPerView: 3,-->
            <#--slidesPerGroup: 3,-->
            <#--loop: true,-->
            <#--loopFillGroupWithBlank: true,-->
            <#--pagination: {-->
                <#--el: '.swiper-pagination',-->
                <#--clickable: true,-->
            <#--},-->
            <#--navigation: {-->
                <#--nextEl: '.swiper-button-next',-->
                <#--prevEl: '.swiper-button-prev',-->
            <#--},-->
        <#--});-->
    <#--</script>-->
    <#--<script>-->
        <#--if ($('.image-link').length) {-->
            <#--$('.image-link').magnificPopup({-->
                <#--type: 'image',-->
                <#--gallery: {-->
                    <#--enabled: true-->
                <#--}-->
            <#--});-->
        <#--}-->
        <#--if ($('.image-link2').length) {-->
            <#--$('.image-link2').magnificPopup({-->
                <#--type: 'image',-->
                <#--gallery: {-->
                    <#--enabled: true-->
                <#--}-->
            <#--});-->
        <#--}-->
    <#--</script>-->
<#--</body>-->

<#--</html>-->
