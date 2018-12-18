<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="/open/scriptaculous/lib/prototype.js" type="text/javascript"></script>
    <script src="/open/scriptaculous/src/effects.js" type="text/javascript"></script>
    <script type="text/javascript" src="/open/validation.js"></script>
    <#--<script type="text/javascript">-->
        <#---->
            <#---->
            <#--function setActiveStyleSheet(title) {-->
                <#--var i, a, main;-->
                <#--for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {-->
                    <#--if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {-->
                        <#--a.disabled = true;-->
                        <#--if(a.getAttribute("title") == title) a.disabled = false;-->
                    <#--}-->
                <#--}-->
            <#--}-->

    <#--</script>-->
    <link title="style1" rel="stylesheet" href="/open/style.css" type="text/css" />
    <link title="style2" rel="alternate stylesheet" href="/open/style2.css" type="text/css" />
    <link title="style3" rel="alternate stylesheet" href="/open/style3.css" type="text/css" />
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>
    <#assign JwtToken=Session.jwtToken>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#open").click(function(){
                $.ajax({url:"http://localhost:12344/shop/open",
                    // dataType:"json",
                    type: 'post',
                    contentType: 'application/json',
                    data:JSON.stringify(GetJsonData())
                    ,
                    beforeSend:function(request){
                        request.setRequestHeader("Jwt-Token","${JwtToken}");
                    },
                    success:function(){
                        $(location).attr('href', '/index');
                    },
                    error:function () {

                    }

                });
            });
        });
        function GetJsonData() {
            var json = {
                "shop_name": $("#field4").val(),
                "shop_telenumber": $("#field5").val(),
                "shop_addr": $("#field6").val(),
                "password": $("#field7").val(),
                "shop_lng": $("#field11").val(),
                "shop_lat": $("#field10").val(),
                "shop_photo": $("#field9").val()
            };
            return json;
        }
    </script>
</head>
<body>
<div class="style_changer">
    <div class="style_changer_text">Themes:</div>
    <input type="submit" value="1" onclick="setActiveStyleSheet('style1');" />
    <input type="submit" value="2" onclick="setActiveStyleSheet('style2');" />
    <input type="submit" value="3" onclick="setActiveStyleSheet('style3');" />
</div>

<div class="form_content">
    <form id="test" onsubmit="return false">

        <fieldset>
            <legend>店铺信息</legend>

            <div class="form-row">
                <div class="field-label"><label for="field4">店铺名</label>:</div>
                <div class="field-widget"><input name="shopName" id="field4" class="required" title="Enter your shopName" /></div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field5">店铺电话</label>:</div>
                <div class="field-widget"><input name="shopTelenumber" id="field5" class="required validate-email" title="Enter your telephoneNumber" /></div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field6">店铺地址</label>:</div>
                <#--<div class="field-widget">-->
                    <#--<select id="field6" name="field6" class="validate-selection" title="Choose your department">-->
                        <#--<option>Select one...</option>-->
                        <#--<option>Accounts</option>-->
                        <#--<option>Human Resources</option>-->
                        <#--<option>Information Technology</option>-->
                        <#--<option>Animal Management</option>-->
                        <#--<option>Ultimate Frisby</option>-->
                    <#--</select>-->
                <#--</div>-->
                <div class="field-widget"><input type="text" name="shopAddress" id="field6" class="required validate-password" title="Enter a shopAddress" /></div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field7">用户密码</label>:</div>
                <div class="field-widget"><input type="password" name="pwd1" id="field7" class="required validate-password" title="Enter a password greater than 6 characters" /></div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field9">确认密码</label>:</div>
                <div class="field-widget"><input type="password" name="pwd2" id="field8" class="required validate-password-confirm" title="Enter the same password for confirmation" /></div>
            </div>
        </fieldset>

        <fieldset>
            <legend class="optional">可选信息</legend>
             <div class="form-row">
                <div class="field-label"><label for="field9">店铺照片</label>:</div>
                <div class="field-label">
                    <input name="field3" id="field9" class="optional" title="上传店铺照片" />
                </div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field10">店铺经度</label>:</div>
                <div class="field-label"><input name="lat" id="field10" class="optional" title="输入经度值" /></div>
            </div>

            <div class="form-row">
                <div class="field-label"><label for="field11">店铺纬度</label>:</div>
                <div class="field-label"><input name="lng" id="field11" class="optional" title="输入纬度值" /></div>
            </div>

            <#--<div class="form-row-select">-->

                <#--<fieldset>-->
                    <#--<legend class="optional">Ocupation</legend>-->
                    <#--<label class="left">-->
                        <#--<input type="radio" class="radio_input" name="field11" id="field11-male" value="1" />Artist <br />-->
                        <#--<input type="radio" class="radio_input" name="field11" id="field11-female" value="2"/>Businessperson<br />-->
                        <#--<input type="radio" class="radio_input" name="field11" id="field11-female" value="2"/>Factory worker<br />-->
                        <#--<input type="radio" class="radio_input" name="field11" id="field11-female" value="2"/>Engineer<br />-->
                        <#--<input type="radio" class="radio_input" name="field11" id="field11-female" value="2"/>Journalist<br />-->

                    <#--</label>-->



                <#--</fieldset>-->

            <#--</div>-->


        </fieldset>
        <input type="submit" id="open" class="submit" value="Submit" /> <input class="reset" type="button" value="Reset" onclick="valid.reset(); return false" />
    </form>
</div>
<script type="text/javascript">
    function formCallback(result, form) {
        window.status = "valiation callback for form '" + form.id + "': result = " + result;
    }

    var valid = new Validation('test', {immediate : true, onFormValidate : formCallback});
    Validation.addAllThese([
        ['validate-password-confirm', 'please try again.', {
            equalToField : 'field8'
        }]
    ]);
</script>

</body>
</html>