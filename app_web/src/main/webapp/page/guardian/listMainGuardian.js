//设置已有的监标人为选中状态 begin
function setUserAlreadyCheck(){

    var thech2 = $("input[type='checkbox'][name='id']");
    thech2.attr("checked",false);
    thech2.prop("checked",false);

    var easyId = "#itemGuardianList_datagrid";
    var rows=$(easyId).datagrid("getSelected");
    if(rows && rows.length<1){
        //$.messager.alert('系统提示','王志，这里没有内容！');
    }else{
		
		$(rows).each(function(i){
			var haveGuardians = this.guardians;

			if(haveGuardians && haveGuardians.length>0){
				$.each(haveGuardians,function(j){
					var thech = $("input[type='checkbox'][name='id'][value='"+this.id+"']");
					thech.attr("checked",true);
					thech.prop("checked",true);
				});
			}
		});
	}
}


//弹出窗中确定时，设置已有的监标人显示 begin
function setUserToMain(){

    var thech2 = $("input[type='checkbox'][name='id']:checked");
    var userId = thech2.val();

    var easyId = "#itemGuardianList_datagrid";
    var rows=$(easyId).datagrid("getSelected");
    if(rows && rows.length<1){
        $.messager.alert('系统提示','王志，这里没有内容！');
    }
    $(rows).each(function(i){//主信息
        var data = this.guardians;
        if(!data){
            data = [];
        }

        var userLists = "#userList";
        var userListrows=$(userLists).datagrid("getRows");
        $(userListrows).each(function(j){
            var thechuser = $("input[type='checkbox'][name='id'][value='"+this.id+"']:checked");
            if(thechuser && thechuser.length>0){
                var userIdAtPop = this.id;
                var usernameAtPop = this.userName ;
                var ishaved = false ;
                $.each(data,function(k){
                    if(this.id==userIdAtPop){
                        ishaved = true ;
                    }
                });

                if(ishaved == false){
                    var user = {id:userIdAtPop,userName:usernameAtPop};
                    data[data.length] = user ;
                }
            }

        });

        var rowIndex=$(easyId).datagrid("getRowIndex",this);
        this.guardians=data;
        $(easyId).datagrid("updateRow",{index:rowIndex,row:this});

    });
}
//弹出窗中确定时，设置已有的监标人显示 end


$(function(){



//设置已有的监标人为选中状态 over

//创建　选择监标人弹窗
    function createOrUpdateGuardian(rowData){

        $("#popDiv").show();
        var dialog=$("#popDiv").dialog({
            title:"指定监标人",
            onLoadSuccess:
                setUserAlreadyCheck(),
            buttons:[
                {text:"关闭",handler:function(){
                        dialog.dialog("close");
                    }}
            ]
        })

    }

    var itemGuardianId="#itemGuardianList_datagrid";
    /*****
     * 显示　标段和监标人列表
     */
    $(itemGuardianId).datagrid({
        title:"指定监标人",
        singleSelect : true,
        rownumbers : true,
        fitColumns : true,
        striped : true,
        pagination : true,
        collapsible:true,
        height:300,
        url : ctx+"/guardian/itemGuardianListByApplyId",
        queryParams:{id:$("#expertApplyId").val()},
        idField:"itemId",
        onOpen:function(){
            $(this).on("click","a.edit",function(){
                var rowIndex=parseInt($(this).parent().parent().parent().attr("datagrid-row-index"));
                createOrUpdateGuardian($(itemGuardianId).datagrid("getRows")[rowIndex]);
            });
        },
        columns : [ [
            {field : "itemId",title : "itemId",align : "left",width:100,hidden:true},
            {field : "itemName",title : "标段名称",align : "left",width:200,formatter:function(value,rowData,rowIndex){

                return rowData["itemName"];
            }},
            {field : "guardians",title : "监标人",align : "left",width:200,formatter:function(value,rowData,rowIndex){

                    var users = rowData["guardians"];
                    var itemId = rowData["itemId"];
                    if(users!=null && users.length && users.length>0){
                        var ret = "<div id='itemdiv_"+itemId+"'>";
                        var shw = "";
                        $.each(users,function(i){
                            //itemguardian_ 标段id _　人员id
                            var userid = this.id,username = this.userName ;
                            shw += "、"+this.userName;
                            shw += "<input type='hidden' name='itemguardian_"+itemId+"_' id='itemguardian_"+itemId+"_"+userid+"' value='true' />";
                        });
                        shw = shw.substring(1);

                        ret +=shw+ "</div>";
                        return ret;
                    }else{
                        return "";
                    }
                }},
            {title : "操作",field : "handle",width:50,formatter : function(value, rowData) {
                    var itemId = rowData["itemId"];
                    var users = rowData["guardians"];
                    var itemId = rowData["itemId"];
                    if(users!=null && users.length && users.length>0){
                        return "<a class='small red button edit'>修改</a>";
                    }else{
                        return "<a class='small red button edit'>指定监标人</a>";
                    }

                }}
        ] ]
    });

    //主页面　上保存按钮触发
	function saveGuardianItem(){


        var easyId = "#itemGuardianList_datagrid";
        var rows=$(easyId).datagrid("getRows");
        if(rows && rows.length<1){
            $.messager.alert('系统提示','王志，这里没有内容！');
        }
        var data=[];
        $(rows).each(function(i){
            var itemId = this.itemId ;
            var guardians = this.guardians;
            if(guardians && guardians.length && guardians.length>0){
                $.each(guardians,function(j){
                    // console.log('itemId='+itemId);
                    // console.log('userId='+this.id);
                    data[data.length]={itemId:itemId,userId:this.id};
                });
            }else{
                data[data.length]={itemId:itemId};
            }
        });

        if(data.length && data.length==0){
            var xx = confirm('系统提示:没有指定监标人，确定监标人不参与？');
            if(xx){

            }else{
                return ;
            }
        }

			$.ajax({
				url : ctx+"/guardian/addItemUsers?_"+Math.random(),
				type : "post",
				data :  JSON.stringify(data),
				dataType : "json",
                contentType : 'application/json;charset=utf-8', //设置请求头信息
				beforeSend:function(){
					$.messager.progress({
						title:"系统提示",
						msg:"正在保存标段监标人..."
					});
				},
				success : function(data) {
					$.messager.progress("close");
					if(data.success){
						$("#id").val(data.data);

                        var passVal= $("input[name=pass]").val();
                        if("true"==passVal){
                            $("#completeForm").submit();
                        }else{

                            $.messager.alert("系统提示", data.msg);
                        }


                        var forRefreshTaskId = $('#forRefreshTaskId').val();
						if(forRefreshTaskId!=null && forRefreshTaskId!=''){
							window.location.href=ctx+"/workflow/customTaskForm?taskId="+forRefreshTaskId;
						}else{
                           // window.location.href=ctx+"/home";
                        }
					}else{
						$.messager.alert("系统提示", data.msg);
					}
				},
				complete:function(){
					
				}
			});
	}

	$("#saveGuardianInMain").click(saveGuardianItem);


    $("#pass").click(function () {
        $("input[name=pass]").val("true");
        saveGuardianItem();
    });

});

