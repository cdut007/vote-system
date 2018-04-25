<div  class="form-container ">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>任务流程</legend>
    </fieldset>
    <div class="time_line_box">
        <div class="time_line" style="width:100%;">
            <ol>
                <li>
                    <a data-index="0" class="order_item" style="left:10%;">经办人</a>
                </li>
                <li>
                    <a data-index="1" class="order_item" style="left:37%;">科室负责人</a>
                </li>
                <li>
                    <a data-index="2" class="order_item " style="left:64%;">分管负责人</a>
                </li>
                <li>
                    <a data-index="3" class="order_item" style="left:90%;">审批人</a>
                </li>

            </ol> <!--0.125,0.40 0.67 0.92-->
            <span class="filling_line" id="cursor" style="transform: scaleX(0.40);"></span>
        </div>
    </div>


</div>



<style>

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
        var cursorFlags=[0.122,0.40 ,0.67 ,1.0];
        var cursor = document.getElementById("cursor");
        var operator ="${(user.operator)!}";
        var currentCursorIndex = getOperatorIndex(operator);


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

