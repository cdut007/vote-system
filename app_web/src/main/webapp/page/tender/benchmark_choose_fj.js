var jtBenchmark3ControlPriceRatio = 0;	// 交通基准价3保存随机抽取的控制价下浮系数
function random(){
	$("#randomData").attr("disabled","disabled");
	$("#randomData").hide();
	var uniqueMethodId_judg = $("#uniqueMethodId_judg").val();
	//$("#benchmarkId_random").click();
	//var rondom_id = Obj.id;
	
	//区分交通和房建：房建暂时没有随机抽取评标基准价需求！
	if(uniqueMethodId_judg == "JT"){
		var array = new Array();
		$("#benchmarkId option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#benchmarkId").val(data.data);
					$("#benchmarkId").attr("disabled","disabled");
					
					changeBy();
					
					var uniqueMethodName = $("#benchmarkId").find("option:selected").text();
					
					if(uniqueMethodName=="评标基准价1"){
						//alert("现在是交通评标基准价1");
						$("#jt_benchmark_1_control_price_ratio_random").click();
						$("#jt_benchmark_1_benchmark_ratio_random").click();
						$("#jt_benchmark_1_add_right_ratio_random").click();
						$("#jt_benchmark_1_remove_top_last_price_random").click();
						$("#jt_benchmark_1_control_price_ratio").attr("disabled","disabled");
						$("#jt_benchmark_1_benchmark_ratio").attr("disabled","disabled");
						$("#jt_benchmark_1_add_right_ratio").attr("disabled","disabled");
						$("#jt_benchmark_1_remove_top_last_price").attr("disabled","disabled");
					}else if(uniqueMethodName=="评标基准价2"){
						//alert("现在是交通评标基准价2");
						$("#jt_benchmark_2_control_price_ratio_random").click();
						$("#jt_benchmark_2_k_ratio_random").click();
						$("#jt_benchmark_2_control_price_ratio").attr("disabled","disabled");
						$("#jt_benchmark_2_k_ratio").attr("disabled","disabled");
					}else if(uniqueMethodName=="评标基准价3"){
						//alert("现在是交通评标基准价3");
						$("#jt_benchmark_3_control_price_ratio_random").click();
						$("#jt_benchmark_3_k_ratio_random").click();
						$("#jt_benchmark_3_control_price_ratio").attr("disabled","disabled");
						$("#jt_benchmark_3_k_ratio").attr("disabled","disabled");
						
						//	实现自动随机选中固定数量的投标人：
						// （1）有效投标人数量在10（含）以内时’随机抽取50％数量’但不小于3个;
						// （2）有效投标人数量在l0～20（含）时’随机抽取40％数量’但不小于6个;
						// （3）有效投标人数量大于20时’随机抽取30％数量’但不小于9个。
						
						var controlPrice = $("#controlPrice").val();//alert("controlPrice："+controlPrice);
						var jt_benchmark_3_control_price_ratio = $("#jt_benchmark_3_control_price_ratio").val();//alert("jt_benchmark_3_control_price_ratio："+jt_benchmark_3_control_price_ratio);
						// 最终最高投标报价
						var finalControlPrice = controlPrice*(1-(jtBenchmark3ControlPriceRatio/100));//alert("finalControlPrice："+finalControlPrice);
						// 理论成本价
						var basePrice = (finalControlPrice*0.5 + avgPrice*0.5)*0.85;//alert("basePrice："+basePrice);
						
						var bidFileArray = new Array();
						$("input[name='avg_price_tenders']").each(function(){ 
							var price = $(this).attr("bidfileprice");
							var bidfilepricedw = $(this).attr("bidfilepricedw");
							
							if(bidfilepricedw == 1){
								
							}else{
								price = price * 10000;
							}
							
							if(basePrice <= price && price <= finalControlPrice){
								bidFileArray.push($(this).val());
							}
						});
						
						//	 实现自动随机选中固定数量的投标人：
						// （1）有效投标人数量在10（含）以内时’随机抽取50％数量’但不小于3个;
						// （2）有效投标人数量在l0～20（含）时’随机抽取40％数量’但不小于6个;
						// （3）有效投标人数量大于20时’随机抽取30％数量’但不小于9个。
						
						//alert(bidFileArray);
						$.ajax({
							url : ctx+"/benchmarkRandom/randomTenders",
							data:{"array":bidFileArray},
							type:"post",
							dataType:"json",
							traditional: true,//这里设置为true
							success : function(data) {
								if(data.success){
									for(var i=0; i<data.data.length; i++){
										//alert(data.data[i]);
										$("input[name='avg_price_tenders'][value="+data.data[i]+"]").attr("checked","checked");
										$("input[name='avg_price_tenders']").attr("disabled","disabled");
									}
								}
							}
						});
					}
				}
			}
		});
	
	}else{
		
		//var FW_benchmarkName = "${data.benchmarkInstance.benchmarkName}";
		var FW_benchmarkId = $("#benchmarkId").val();
		if(FW_benchmarkId=="8fe87e02-647b-487b-9ec2-6542a1ca0d40"){	// 评标基准价1(房建)
			$("#FWSZ_BMK_1_DOWN_RATIO_RANDOM").click();
			$("#FWSZ_BMK_1_DOWN_RATIO").attr("disabled","disabled");
		}else if(FW_benchmarkId=="33de53d2-3a59-4b7a-bd63-6ff2f393f83f"){	// 评标基准价2(房建)
			$("#FWSZ_BMK_2_DOWN_RATIO_RANDOM").click();
			$("#FWSZ_BMK_2_DOWN_RATIO").attr("disabled","disabled");
			
			// 评标基准价=最高投标限价×权重+合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算数平均值×权重
			var bidFileArray = new Array();
			$("input[name='FWSZ_BMK_2_TENDERS']").each(function(){ 
				bidFileArray.push($(this).val());
			});
			
			$.ajax({
				url : ctx+"/benchmarkRandom/randomTendersFWSZ2",
				data:{"array":bidFileArray},
				type:"post",
				dataType:"json",
				traditional: true,//这里设置为true
				success : function(data) {
					if(data.success){
						//console.info(data.data);
						window.setTimeout(function(){
							
							var list = eval(data.data);
							list.forEach(function(e){
								//alert(e);
								$("#"+e+"FWSZ_BMK_2").attr("disabled","disabled");
								//$("input[name='FWSZ_BMK_2_TENDERS'][value=4e63e55c-d800-43bf-aebf-dca4e31b3eb3]").prop("checked",true);
								$("input[name='FWSZ_BMK_2_TENDERS'][value="+e+"]").prop("checked",true);
							});
							
							/*for(var i=0; i<data.data.length; i++){
								//$("#"+data.data[i]+"FWSZ_BMK_2").attr("checked","checked");
								$("input[name='FWSZ_BMK_2_TENDERS'][value="+data.data[i]+"]").attr("checked","checked");//TODO 这种写法不能生效，原因是否是：拼接value的data.data[i]无法识别？
								alert(data.data[i]);
								var vv = $("#"+data.data[i]+"FWSZ_BMK_2").val();
								alert(vv);
								$("#"+data.data[i]+"FWSZ_BMK_2").attr("disabled","disabled");
								//$("input[name='FWSZ_BMK_2_TENDERS']").attr("disabled","disabled");
							}*/
						},4000);
					}
				}
			});
			
			$("#FWSZ_BMK_2_CONTROL_PRICE_RIGHT_RANDOM").click();
			$("#FWSZ_BMK_2_CONTROL_PRICE_RIGHT").attr("disabled","disabled");
		}else if(FW_benchmarkId=="a789f3dd-9256-427a-990e-9dbec8d661a8"){	// 评标基准价3(房建)
			$("#FWSZ_BMK_3_DOWN_RATIO_RANDOM").click();
			$("#FWSZ_BMK_3_DOWN_RATIO").attr("disabled","disabled");
			
			// 评标基准价=合成范围内随机抽取9家投标报价（不足的全部抽取）中去掉一个最高投标报价和一个最低投标报价的算术平均值
			var bidFileArray = new Array();
			$("input[name='FWSZ_BMK_3_TENDERS']").each(function(){ 
				bidFileArray.push($(this).val());
			});
			
			$.ajax({
				url : ctx+"/benchmarkRandom/randomTendersFWSZ2",
				data:{"array":bidFileArray},
				type:"post",
				dataType:"json",
				traditional: true,//这里设置为true
				success : function(data) {
					if(data.success){
						window.setTimeout(function(){
							var list = eval(data.data);
							list.forEach(function(e){
								$("#"+e+"FWSZ_BMK_3").attr("disabled","disabled");
								$("input[name='FWSZ_BMK_3_TENDERS'][value="+e+"]").prop("checked",true);
							});
						},4000);
					}
				}
			});
		}else if(FW_benchmarkId=="40289e8d-6121916d-0161-21916d6f-0000"){	// 房屋市政勘察评标基准价
			$("#FWSZ_BMK_4_WEIGHT_RANDOM").click();
			$("#FWSZ_BMK_4_WEIGHT").attr("disabled","disabled");
		}else if(FW_benchmarkId=="4028e300-624113f1-0162-4113f175-0000"){	// 经评审的最低投标价法(房建)
			$("#FWSZ_BMK_5_DOWN_RATIO_RANDOM").click();
			$("#FWSZ_BMK_5_DOWN_RATIO").attr("disabled","disabled");
		}
	}
}


function changeBy(){
	//alert("调用");
	$("#benchmarkId").change(function() {
		var benchmarkId = this.value;
		//alert(benchmarkId);
		uniqueMethodId = $("#"+benchmarkId).val();
		$(".benchmarkDescription").hide();
		$("#benchmarkDescription_" + benchmarkId).show();
		$(".ratio_p").hide();
		
		$("#" + uniqueMethodId).show();
		disableInvalidBidFile();
	}).change();
}




function pleaseRandom(Obj){
	
	//var rondom_id = $(this).attr("id");
	var rondom_id = Obj.id;
	var array = new Array();
	
	
	if(rondom_id=="benchmarkId_random"){
		$("#benchmarkId option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#benchmarkId").val(data.data);
					changeBy();
				}
			}
		});
	}else 
	/* 房屋市政 TODO 需要优化冗余代码 */
	if(rondom_id=="FWSZ_BMK_1_DOWN_RATIO_RANDOM"){
		$("#FWSZ_BMK_1_DOWN_RATIO option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_1_DOWN_RATIO").val(data.data);
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_2_DOWN_RATIO_RANDOM"){
		$("#FWSZ_BMK_2_DOWN_RATIO option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_2_DOWN_RATIO").val(data.data);
					updateFWSZBenchmar('FWSZ_BMK_2');
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_2_CONTROL_PRICE_RIGHT_RANDOM"){
		$("#FWSZ_BMK_2_CONTROL_PRICE_RIGHT option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_2_CONTROL_PRICE_RIGHT").val(data.data);
					var selvalue_next = 100 - Number(data.data);
					$("#FWSZ_BMK_2_AVG_PRICE_RIGHT").val(selvalue_next);
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_2_AVG_PRICE_RIGHT_RANDOM"){
		$("#FWSZ_BMK_2_AVG_PRICE_RIGHT option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_2_AVG_PRICE_RIGHT").val(data.data);
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_3_DOWN_RATIO_RANDOM"){
		$("#FWSZ_BMK_3_DOWN_RATIO option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_3_DOWN_RATIO").val(data.data);
					updateFWSZBenchmar('FWSZ_BMK_3');
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_4_WEIGHT_RANDOM"){
		$("#FWSZ_BMK_4_WEIGHT option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_4_WEIGHT").val(data.data);
				}
			}
		});
	}else if(rondom_id=="FWSZ_BMK_5_DOWN_RATIO_RANDOM"){
		$("#FWSZ_BMK_5_DOWN_RATIO option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#FWSZ_BMK_5_DOWN_RATIO").val(data.data);
				}
			}
		});
	}
	
	/* 交通相关 TODO 需要优化冗余代码 */
	else if(rondom_id=="jt_benchmark_1_control_price_ratio_random"){
		$("#jt_benchmark_1_control_price_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_1_control_price_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_1_benchmark_ratio_random"){
		$("#jt_benchmark_1_benchmark_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_1_benchmark_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_1_add_right_ratio_random"){
		$("#jt_benchmark_1_add_right_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_1_add_right_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_1_remove_top_last_price_random"){
		$("#jt_benchmark_1_remove_top_last_price option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_1_remove_top_last_price").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_2_control_price_ratio_random"){
		$("#jt_benchmark_2_control_price_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_2_control_price_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_2_k_ratio_random"){
		$("#jt_benchmark_2_k_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_2_k_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_3_control_price_ratio_random"){
		$("#jt_benchmark_3_control_price_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_3_control_price_ratio").val(data.data);
					jtBenchmark3ControlPriceRatio = data.data;
				}
			}
		});
	}else if(rondom_id=="jt_benchmark_3_k_ratio_random"){
		$("#jt_benchmark_3_k_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_benchmark_3_k_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_fw_kc_jl_benchmark_1_control_price_ratio_random"){
		$("#jt_fw_kc_jl_benchmark_1_control_price_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_fw_kc_jl_benchmark_1_control_price_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_fw_kc_jl_benchmark_1_benchmark_ratio_random"){
		$("#jt_fw_kc_jl_benchmark_1_benchmark_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_fw_kc_jl_benchmark_1_benchmark_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="fw_kc_jl_benchmark_1_add_right_ratio_random"){
		$("#fw_kc_jl_benchmark_1_add_right_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#fw_kc_jl_benchmark_1_add_right_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_sj_sg_cb_benchmark_1_control_price_ratio_random"){
		$("#jt_sj_sg_cb_benchmark_1_control_price_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_sj_sg_cb_benchmark_1_control_price_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_sj_sg_cb_benchmark_1_benchmark_ratio_random"){
		$("#jt_sj_sg_cb_benchmark_1_benchmark_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_sj_sg_cb_benchmark_1_benchmark_ratio").val(data.data);
				}
			}
		});
	}else if(rondom_id=="jt_sj_sg_cb_benchmark_1_add_right_ratio_random"){
		$("#jt_sj_sg_cb_benchmark_1_add_right_ratio option").each(function(){ 
			var txt = $(this).val();  
			if(txt!=''){
				array.push(txt);
			}
		});
		$.ajax({
			url : ctx+"/benchmarkRandom/random",
			data:{"array":array},
			type:"post",
			dataType:"json",
			traditional: true,//这里设置为true
			success : function(data) {
				if(data.success){
					$("#jt_sj_sg_cb_benchmark_1_add_right_ratio").val(data.data);
				}
			}
		});
	}
	
		
	
	
}