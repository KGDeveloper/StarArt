window.onload = function () {
    /*获取屏幕的高度*/
    var heightH=$(window).height();
    $('.beijing').css('height',heightH);

    var timer;

    var flag = true;

    var upData = null;

    function getToken() {
        var query = window.location.search.substring(1);
        return query.split(" --")[0].split("=")[1];
    }

    var token =  getToken();

    var  params = {
        
        "searchType": 1,
        "longitude": 40.222012,
        "longitude":116.248283,
        "ids":[1,2,3],
        "similarity": 20,
        "pageSize":20,
        "pageIndex":1,
        "sex": 1,
    }

    $.ajax({
        headers:{
            "Content-type":"application/json",
            "User-Agent":"wyxqIOS",
           "Authorization":"Bearer"+" "+token,
        },
        url:"http://iartplanet.com/api/user/list",
        type:"post",
        data:JSON.stringify(params),
        success:function (data) {
            upData = data.data.list;
            initData(upData);
           /* 设置卡片内容 */
           $('.popBox .zzz .dis-name> h3').text($('.gif2').attr("data-dis"));
           $('.popBox .zzz .dis-name> span').text($('.gif2').attr("data-num")+"%匹配");
           $('.popBox .sub-btn > .great').attr("uid",$('.gif2').attr("data-id"));
           $('.popBox .sub-btn > .great').attr("username",$('.gif2').attr("data-dis"));
        }

    });

    function initData(arr) {
        var string1 = arr;
        var max =   Math.max.apply(Math, string1.map(function(o) {return o.similarity}));
        var number1 = null;
        var data = "";
        var data2 = "";
        
        for(var i = 0; i < string1.length; i++){
            if(string1[i].similarity == max){
                number1 = string1[i];
                data2 = '<div class="gif2 step1 current" data-num=" '+number1.similarity+' " data-id = " '+ number1.userId +' "  data-dis = " '+number1.username+' "><img src="img/'+ random(1,12) +'.png" alt=""></div>';
            }
            // data +=  '<span class="img'+ random(1,16) +'"   "><img src="img/('+ random(4,12) +').png" alt=""></span>';
        }
        $(".ball").append(data2);
        // $(".ball").append(data);
    }

    function initData2(arr) {
        var string1 = arr;
        var max =   Math.max.apply(Math, string1.map(function(o) {return o.similarity}));
        var number1 = null;
        var data = "";


        for(var i = 0; i < string1.length; i++){
            if(string1[i].similarity == max){
                number1 = string1[i];
                data = '<div class="gif2 step1 current" data-num=" '+number1.similarity+' " data-id = " '+ number1.id +' "  data-dis = " '+number1.username+' "><img src="img/'+ random(1,12) +'.png" alt=""></div>';
            }
        }
        $(".ball").append(data);

        if(flag){
            $(".gif2").css({"top":"64%","right":"50%"});
            flag = false;
        }else{
            $(".gif2").css({"top":"48%","right":"20%"});
            flag = true;
        }

    }

    function changeTab(){
        var nearby1 = $('.gif_1').offset().left;
        var nearby2 = $('.gif2').offset().left;

        var nums = $('.gif2').attr("data-num");
        var nearby3 = nearby2 - nearby1;
        if($('.gif2').offset().top > Math.ceil(heightH * 0.32)){
            $('.lightning').css({
                'top': '57%',
                'left': '23%',
                'width':'155px',
                'transform': 'rotate(50deg)'
            });
        }
        if($('.gif2').offset().top > Math.ceil(heightH * 0.32) && $('.gif2').offset().top < Math.floor(heightH * 0.64)){
            $('.lightning').css({
                'top': '49%',
                'left': '28%',
                'width':'120px',
                'transform': 'rotate(12deg)'
            });
        }
        if(nearby3<=120 && nearby3>=95 && nums>=1){ //满足匹配度高达90%出现闪电

            $('.lightning').css('display','block');
            setTimeout(function () {
                $('.beijing_1').css('animation-play-state', 'paused'); //动画暂停
                $('.popBox').slideDown();
                clearInterval(timer);
            },800);
        }else{
            $('.lightning').css('display','none')
        }
    }

    // 点击不感兴趣

    $(".miss").on('click',function () {
        missClick(this);
    });

    // 点击私聊
    $(".great").on('click',function () {
        window.chatWithUserID($(this).attr("uid"),$(this).attr("username"));
    });

    function missClick(that) {
        $('.lightning').css('display','none');
        $('.popBox').slideUp();
        $('.beijing_1').css('animation-play-state', 'running'); //动画开始

        var _thisNum =parseInt( $(that).parent().prev().children(".dis-name").find(".similarity").text());

        $(".step1").attr("data-num",""+-_thisNum+"").removeClass("gif2");


        for (var i = upData.length-1; i>0; i--)
            if (upData[i].similarity==_thisNum)
                upData.splice(i,1);

        initData2(upData);

        timer=setInterval(changeTab,10);
        setTimeout(function () {
            $('.popBox .zzz .dis-name> h3').text($('.gif2').attr("data-dis"));
            $('.popBox .zzz .dis-name> span').text($('.gif2').attr("data-num")+"%匹配");
            $('.popBox .sub-btn > .great').attr("uid",$('.gif2').attr("data-id"));
            $('.popBox .sub-btn > .great').attr("username",$('.gif2').attr("data-dis"));
        },500)

    }

    function random(lower, upper) {
        return Math.floor(Math.random() * (upper - lower+1)) + lower;
    }
    timer=setInterval(changeTab,10);


    /*
     * 点击刷新图标 请求你们的API
     * success 回调函数 里调用initData 方法 传data参数
     *
     * */

    $("#refresh").on('click',function () {
        var fl = confirm("试试换一批吗？");
        if(fl){
            $.ajax({
                headers:{
                    "Content-type":"application/json",
                },
                url:"**************",
                type:"post",
                data:{

                },
                success:function (data) {
                    initData(data);
                }
            })
        }else{
            return false;
        }

    })
};







