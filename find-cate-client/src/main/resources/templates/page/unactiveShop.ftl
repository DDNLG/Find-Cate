<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>userList</title>
    <link rel="stylesheet" href="/scss/bootstrap.css"/>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>
    <#assign JwtToken=Session.jwtToken>
    <script type="text/javascript">
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
                                '<td><a id="'+shopId+'" href="#">激活</a></td>' +
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
                if(e.target.tagName=="A"){
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

</body>
</html>