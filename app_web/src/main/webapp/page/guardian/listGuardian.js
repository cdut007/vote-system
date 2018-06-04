
//取消主列表上的监标人
function plusUserToMain(clearnData){
    //clearnData 是需要取消勾选的
    var easyId = "#itemGuardianList_datagrid";
    var rows=$(easyId).datagrid("getSelected");
    if(rows && rows.length<1){
        $.messager.alert('系统提示','王志，这里没有内容！');
    }
    $(rows).each(function(i){//主信息
        var rowIndex=$(easyId).datagrid("getRowIndex",this);
        var data = this.guardians;
        if(!data){
            data = [];
        }

        $.each(data,function(k){
        	//console.log('this.id='+this.id+" clearnData.id="+clearnData.id);
            if(this.id==clearnData.id){
                data.splice(k,1);
            }
        });


        $(easyId).datagrid("updateRow",{index:i,row:this});
    });

}
$(function() {

    var firstload = true ;
	
	$("#removeOrganizationUser").click(function(){
		removeOrganizationUser();
	});
    function queryOrganizationUser() {
        var organization = $("#department-treegrid").treegrid("getSelected");
        var searchParam={
            userName : $("[name='userName']").val()
        };
        key=$("[name='cascade']").is(":checked")?"departmentIdIn":"departmentId";
        searchParam[key]=organization.id;
        searchParam['page']=1;
        searchParam['pageSize']=20;
        $("#userList").datagrid('reload',searchParam);


            // $("#userList").datagrid({
            //     url : ctx + "/guardian/guardianListData",
            //     queryParams :searchParam
            // });
    }
    function queryOrganizationUserBak() {
        var organization = $("#department-treegrid").treegrid("getSelected");
        var searchParam={
            userName : $("[name='userName']").val()
        };
        key=$("[name='cascade']").is(":checked")?"departmentIdIn":"departmentId";
        searchParam[key]=organization.id,
            $("#userList").datagrid({
                url : ctx + "/guardian/guardianListData",
                queryParams :searchParam
            });
    }
	$("#department-treegrid").treegrid({
		title : "部门结构",
		fitColumns : true,
		idField : "id",
		border : false,
		striped : true,
		treeField : "departmentName",
		animate : false,
		url : ctx + "/department/getDepartmentTreeByInstanceId",
        //queryParams:{'items':items},
        queryParams:{"id":$("#projectInstanceId").val()},
		columns : [ [ 
			{field : "departmentName",title : "部门名称",width : '100%'}
		] ],
		onSelect : function(rowData) {
			queryOrganizationUser();
			/*$("#userList").datagrid({
				url : ctx + "/user/pagingUserData",
				queryParams : {
					departmentIdIn : rowData.id
				}
			});*/
		},
		onLoadSuccess : function(row, data) {
			if (data.length > 0) {
                userListInit(data[0].id);
                //queryOrganizationUserBak()
			}
		}
	});

    function userListInit(id) {
        var searchParam={
            userName : $("[name='userName']").val()
        };
        searchParam['departmentId']=id;
	$("#userList").datagrid({
		title:"人员列表",
		toolbar:'#userlisttoolbar',
		rownumbers:true,
        url : ctx + "/guardian/guardianListData",
        queryParams :searchParam,
		//sortName:"userName",
		//sortOrder:"asc",
		border:false,
		pagination:false,
		fit:true,
		idField: 'id',
		striped:true,
		pageSize:20,
        onLoadSuccess:function(data){
            setUserAlreadyCheck();
            if(firstload) {
                $("#popDiv").hide();
                firstload = false ;
            }
        },
        onCheck:function(index,data){
            setUserToMain();
            //console.log(data.userName+" 已选　中");
        },
        onUncheck:function(index,data){
            //console.log(data.id+" user.id 未选　中");
            plusUserToMain(data);
            //console.log(data.userName+" 未选　中");
        },
		columns:[[
			{field:'id',checkbox:true},
			{title:"姓名",field:'userName',align:"center",width:80, formatter: function (value,rowData,rowIndex) {
                return "<span title='" + rowData.phone + "'>" + value + "</span>";
            }},
			{title:"性别",field:'gender',align:"center",width:60},
			{title:"所属单位",field:'department.departmentName',width:80},
			{title:"登录账号",field:'loginName',width:80},
			{title:"帐号状态",field:'deleteMark',align:"center",width:80},
			{title:"监标标段",field:'itemList',align:"center",width:200,formatter:function(value,rowData,rowIndex){
				var ret = "";
//				console.log('value.length＝'+value.length);
//				if(value.length && value.length>0){
//					$.each(value,function(i){
//				console.log('this.bdmc00＝'+this);
//				console.log('this.bdmc00＝'+this.bdmc00);
//						ret += " , " +this.bdmc00;
//					});
//				}
			 	return value;
			}}
			
			
		]]
	});
    }
});

