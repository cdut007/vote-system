<div  class="form-container ">

    <div class="layui-row">
        <div class="layui-col-xs5 status-container" style="width: 49%;margin-right: 1%">
            <label class="form">任务流程</label>
            <fieldset class="layui-elem-field layui-field-title">

            </fieldset>

            <div class="time_line_box">
                <div class="time_line" style="width:100%;">
                    <ol>
                        <li>
                            <a data-index="0" class="order_item" style="left:6%;">经办人</a>
                        </li>
                        <li>
                            <a data-index="1" class="order_item" style="left:33%;">科室负责人</a>
                        </li>
                        <li>
                            <a data-index="2" class="order_item " style="left:60%;">分管负责人</a>
                        </li>
                        <li>
                            <a data-index="3" class="order_item" style="left:86%;">审批人</a>
                        </li>

                    </ol> <!--0.125,0.40 0.67 0.92-->
                    <span class="filling_line" id="cursor" style="transform: scaleX(0.40);"></span>
                </div>
            </div>
        </div>
        <div class="layui-col-xs5 status-container" style="width: 49%;margin-left: 1%;min-height:128px">
            <label class="form">任务状态</label>
            <fieldset class="layui-elem-field layui-field-title">

            </fieldset>
            <label class="layui-form-label" id="fail_label" style="width: 100%;text-align: left;color: red;display:none;">未通过审核</label>
            <label class="layui-form-label" id="remarkInfo" style="width: 100%;text-align: left">审核中</label>
        </div>
    </div>





</div>



<style>

    .status-container{

        background-clip: padding-box;
        box-shadow: 1px 1px 1px 1px rgba(0, 0, 0, .3);
        border-width: 1px;
        padding: 10px;
        border-radius: 2px;
        border-color: #e6e6e6;
        background-color:#FFFFFF;


    }

    .time_line_box{
        position: relative;
        height: 60px;
        overflow: hidden;
    }
    .time_line{
        position: absolute;
        z-index: 1;
        left: 0;
        top: 49px;
        height: 2px;
        background: #dfdfdf;
        -webkit-transition: -webkit-transform 0.4s;
        -moz-transition: -moz-transform 0.4s;
        transition: transform 0.4s;
    }
    .order_item{
        position: absolute;
        bottom: 0;
        z-index: 2;
        text-align: center;
        font-size: 13px;
        padding-bottom: 15px;

    }
    .order_item:after{
        content: '';
        position: absolute;
        left: 50%;
        right: auto;
        transform: translateX(-50%);
        bottom: -5px;
        height: 10px;
        width: 10px;
        border-radius: 50%;
        border: 2px solid #dfdfdf;
        background-color: #f8f8f8;
    }

    .pass_selected{
        color: #0154AD;
    }

    .pass_selected:after{
        background-color: #62c370;
        border-color: #62c370;
    }


    .selected{
        color: #0154AD;
    }

    .selected:after{
        background-color: #0154AD;
        border-color: #0154AD;
    }
    .filling_line{
        position: absolute;
        z-index: 1;
        left: 0;
        top: 0;
        height: 100%;
        width: 100%;
        background-color: #0154AD;
        transform-origin: left center;
        transition-property: transform;
        transition-duration: 0.3s;
        transition-timing-function: initial;
        transition-delay: initial;
    }


</style>


<script type="text/javascript">


    layui.use(['itenderReview','table','util','element'], function () {
        var items = $(".order_item");
        var cursorFlags=[0.10,0.40 ,0.67 ,1.0];
        var cursorNames=['经办人','科室负责人' ,'分管负责人' ,'审批人'];

        var cursor = document.getElementById("cursor");
        var operator ="${(user.operator)!}";
        var currentCursorIndex = getOperatorIndex(operator);


        var id = "${itenderReview.id!}";
        $.ajax({
            url: "/review/getSignListByReview",
            type: "POST",
            dataType: "json",
            data: {reviewId:id,signResult:'forbidden'},
            success: function (res) {
                if(res!=null){
                    if(res.status){
                        var text='';
                        for(var i = 0 ; i<res.data.length;i++){
                            var item = res.data[i];
                            text+=item.description+"<br>";
                        }
                        if(res.data.length>0){
                            $("#fail_label").css('display','block');
                            $('#remarkInfo').html(text);
                        }


                    }else{
                        console.log("提交失败!");
                    }
                }else{
                    console.log("提交失败!");
                }
            },
            error: function (xmlHttpReq, error, ex) {
                console.log("提交失败!");
            }
        })



        function getOperatorNameByIndex(index) {

            var operators=['operator','department_leader','branch_leader','approver'];
            if(!index ||index == -1){
                return null;
            }

            return operators[index];
        }



        $.ajax({
            url: "/review/getTaskListByReview",
            type: "POST",
            dataType: "json",
            data: {reviewId:id},
            success: function (res) {
                if(res!=null){
                    if(res.status){


                        if(res.data.length>0){
                            items.each(function(i, item) {
                                        var index =  $(item).attr('data-index');
                                        var operatorName = getOperatorNameByIndex(index);

                                for(var j = 0 ; j<res.data.length;j++){
                                    var itemTask = res.data[i];
                                    if(itemTask.role == operatorName){
                                        var operator = cursorNames[index];
                                        $(item).text(operator+":"+ itemTask.userNickName);
                                        break;
                                    }
                                }

                                    }
                            );
                        }


                    }else{
                        console.log("获取任务列表失败!");
                    }
                }else{
                    console.log("获取任务列表失败!");
                }
            },
            error: function (xmlHttpReq, error, ex) {
                console.log("获取任务列表失败!");
            }
        })




        function getOperatorIndex(operator) {

            var operators=['operator','department_leader','branch_leader','approver'];
            for(var i = 0 ; i<operators.length;i++){
                if(operators[i] == operator){
                   return i;

                }
            }

            return -1;
        }


        items.each(function(i, item) {
            var index =  $(item).attr('data-index');
                    if(currentCursorIndex < index){
                        $(item).removeClass('selected');
                    }else{
                        $(item).removeClass('selected');
                        $(item).removeClass('pass_selected');
                        if(currentCursorIndex == index){
                            $(item).addClass('selected');
                        }else{
                            $(item).addClass('pass_selected');
                        }

                    }
                }
        );
        cursor.style.transform = 'scaleX('+cursorFlags[currentCursorIndex]+')';



    });

</script>

