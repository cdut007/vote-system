/*******************************************************************************
 * easyui 表单验证扩展
 */
$
		.extend(
				$.fn.validatebox.defaults.rules,
				{
					/***********************************************************
					 * 组织机构代码号
					 */
					organNo : {
						validator : function(value, param) {
							var reg = /(^[\dA-Z]{8}\-[\dA-Z]$)|(^[\dA-Z]{18}$)/;
							return reg.test(value);
						},
						message : "组织机构代码格式错误"
					},
					/***********************************************************
					 * 组织机构代码号
					 */
					noUseOrganNo : {
						validator : function(value, param) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateOrganNo",
								data : {
									organNo : value,
									id : param[0]
								}
							}).responseText == "true";
						},
						message : '组织机构代码已经被注册'
					},
					/***********************************************************
					 * 单位名称
					 */
					noUseOrganName : {
						validator : function(value, param) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateOrganName",
								data : {
									organName : value,
									id : param[0]
								}
							}).responseText == "true";
						},
						message : '单位名称已经被注册'
					},
					/***********************************************************
					 * 营业执照注册号
					 */
					licenseNo : {
						validator : function(value, param) {
							var reg = /(^[\d]{15}$)|(^[\dA-Z]{18}$)/;
							return reg.test(value);
						},
						message : "营业执照注册号格式错误"
					},
					/***********************************************************
					 * 法人代码
					 */
					legalNo : {
						validator : function(value, param) {
							var reg = /(^[\dA-Z]{9}$)|(^[\dA-Z]{18}$)/;
							return reg.test(value);
						},
						message : "法人代码格式错误"
					},
					noUseLicenseNo : {
						validator : function(value, param) {
							return $
									.ajax({
										async : false,
										url : ctx
												+ "/common/validateBusinessLicenseNo",
										data : {
											businessLicenseNo : value,
											id : param[0]
										}
									}).responseText == "true";
						},
						message : "营业执照注册号已经被注册"
					},
					/***********************************************************
					 * 税务登记证
					 */
					taxNo : {
						validator : function(value, param) {
							var reg = /(^[\dA-Z]{15}$)|(^[\dA-Z]{18}$)|(^[\dA-Z]{20}$)/;
							return reg.test(value);
						},
						message : "税务登记号格式错误"
					},
					noUseTaxNo : {
						validator : function(value, param) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateTaxNo",
								data : {
									taxNo : value,
									id : param[0]
								}
							}).responseText == "true";
						},
						message : "税务登记号已经被注册"
					},
					/***********************************************************
					 * 两个表单值相同
					 */
					equals : {
						validator : function(value, param) {
							return value == $(param[0]).val();
						},
						message : '{1} 和  {2} 的值必须相同！'
					},
					/***********************************************************
					 * 两个表单数值相同
					 */
					numberequals : {
						validator : function(value, param) {
							var compareValue = $(param[0]).val();
							try {
								value = parseFloat(value);
							} catch (e) {

							}
							try {
								compareValue = parseFloat(compareValue);
							} catch (e) {

							}
							return value == compareValue;
						},
						message : '{1} 和  {2} 的值必须相同！'
					},
					/***********************************************************
					 * 两个表单值不同
					 */
					unequals : {
						validator : function(value, param) {
							return value != $(param[0]).val();
						},
						message : '{1} 和  {2} 的值不能相同！'
					},
					// 验证汉字
					CHS : {
						validator : function(value) {
							return /^[\u0391-\uFFE5]+$/.test(value);
						},
						message : 'The input Chinese characters only.'
					},
					mobileOrTelephone : {
						validator : function(value) {
							var reg1 = /^1\d{10}$/;
							var reg2 = /^(^0\d{2}-?\d{8}$)|(^0\d{3}-?\d{7,8}$)|(^0\d2 -?\d{8}$)|(^0\d3 -?\d{7}$)$/;
							return reg1.test(value) || reg2.test(value);
						},
						message : '固话或移动电话号码格式错误'
					},
					// 移动手机号码验证
					Mobile : {// value值为文本框中的值
						validator : function(value) {
							var reg = /^1[3|4|5|7|8|9]\d{9}$/;
							return reg.test(value);
						},
						message : '请输入正确的手机号码'
					},
					// 固定电话
					regPhone : {// value值为文本框中的值
						validator : function(value) {
							var reg = /^(^0\d{2}-?\d{8}$)|(^0\d{3}-?\d{7,8}$)|(^0\d2 -?\d{8}$)|(^0\d3 -?\d{7,8}$)$/;
							return reg.test(value);
						},
						message : '请输入正确的固定电话号码'
					},

					// 移动手机号码或固定电话验证
					MobileOrPhone : {// value值为文本框中的值
						validator : function(value) {
							var mobileReg = /^1[3|4|5|7|8|9]\d{9}$/;
							var phoneReg = /^(^0\d{2}-?\d{8}$)|(^0\d{3}-?\d{7,8}$)|(^0\d2 -?\d{8}$)|(^0\d3 -?\d{7,8}$)$/;
							if (mobileReg.test(value) || phoneReg.test(value)) {
								return true;
							} else {
								return false;
							}
						},
						message : '请输入正确的手机号码或固定电话号码'
					},

					// 国内邮编验证
					zipCode : {
						validator : function(value) {
							var reg = /^[0-9]\d{5}$/;
							return reg.test(value);
						},
						message : '请输入正确的邮编'
					},

					// 身份证号码
					idcardNo : {
						validator : function(value) {
							// 15位和18位身份证号码的正则表达式
							var reg = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;
							return reg.test(value);
						},
						message : '请输入正确的身份证号码'
					},
					/***********************************************************
					 * 未被使用的身份证号
					 */
					noUseIdcardNo : {
						validator : function(value, param) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateIdentityNo",
								data : {
									identityNo : value,
									id : param[0]
								}
							}).responseText == "true";
						},
						message : '身份证号已经被注册'
					},
					// QQ验证
					QQ : {
						validator : function(value) {
							var reg = /^[1-9][0-9]{4,9}$/;
							return reg.test(value);
						},
						message : '请输入正确的QQ号码'
					},

					// 注册用户名
					regUserName : {
						validator : function(value) {
							// 要求大写、小写、数字、特殊字符，三种以上组成的账号(5-16位)
							var reg = /^(?![0-9a-z]+$)(?![0-9A-Z]+$)(?![0-9\W]+$)(?![a-z\W]+$)(?![a-zA-Z]+$)(?![A-Z\W]+$)[a-zA-Z0-9\W_]{5,16}$/;
							return reg.test(value);
						},
						message : '用户名必须由大写、小写、数字、特殊字符，三种以上组成(5-16位)'
					},
					// 密码
					regPassword : {
						validator : function(value) {
							// 要求大写、小写、数字、特殊字符，三种以上组成的密码账号(5-16位)
							var reg = /^(?![0-9a-z]+$)(?![0-9A-Z]+$)(?![0-9\W]+$)(?![a-z\W]+$)(?![a-zA-Z]+$)(?![A-Z\W]+$)[a-zA-Z0-9\W_]+$/;
							return reg.test(value);
						},
						message : '密码必须由大写、小写、数字、特殊字符，三种以上组成'
					},
					noUseLoginName : {
						validator : function(value) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateLoginName",
								data : {
									loginName : value
								}
							}).responseText == "true";
						},
						message : '登陆账号已经被注册'
					},
					compareDate : {
						validator : function(value, param) {
							return dateCompare($(param[0]).val(), value); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '开始日期不能大于结束日期'
					},
					// 大于某个时间
					gtTime : {
						validator : function(value, param) {
							if (param[1]) {
								$.fn.validatebox.defaults.rules.gtTime.message = param[1];
							} else {
								$.fn.validatebox.defaults.rules.gtTime.message = "结束时间不能小于开始时间";
							}
							return timeCompare($(param[0]).val(), value); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '结束时间不能小于开始时间'
					},
					// 小于某个时间
					ltTime : {
						validator : function(value, param) {
							if (param[1]) {
								$.fn.validatebox.defaults.rules.ltTime.message = param[1];
							} else {
								$.fn.validatebox.defaults.rules.ltTime.message = "开始时间不能大于结束时间";
							}
							return timeCompare(value, $(param[0]).val()); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '开始时间不能大于结束时间'
					},
					// 大于某个日期
					gtDate : {
						validator : function(value, param) {
							if (param[1]) {
								$.fn.validatebox.defaults.rules.gtDate.message = param[1];
							} else {
								$.fn.validatebox.defaults.rules.gtDate.message = "结束日期不能小于开始日期";
							}
							return dateCompare($(param[0]).val(), value); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '结束日期不能小于开始日期'
					},
					// 小于某个时间
					ltDate : {
						validator : function(value, param) {
							if (param[1]) {
								$.fn.validatebox.defaults.rules.ltDate.message = param[1];
							} else {
								$.fn.validatebox.defaults.rules.ltDate.message = "开始日期不能大于结束日期";
							}
							return dateCompare(value, $(param[0]).val()); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '开始日期不能大于结束日期'
					},
					gtHowManyDays : {
						validator : function(value, param) {
							if (param[1]) {
								$.fn.validatebox.defaults.rules.gtHowManyDays.message = param[2];
							} else {
								$.fn.validatebox.defaults.rules.gtHowManyDays.message = "结束时间不能小于开始时间";
							}
							return isGtHowManyDays($(param[0]).val(), value,
									param[1]); // 注意easyui
							// 时间控制获取值的方式
						},
						message : '结束时间不能小于开始时间'
					},

					percent : {
						validator : function(value) {
							var reg = /^\d+(\.\d+)?$/;
							return reg.test(value);
						},
						message : '请输入正确的百分比'
					},
					platPrice : {
						validator : function(value) {
							var reg = /^[1-9]\d*(\.\d+)?$/;
							return reg.test(value);
						},
						message : '请输入正确的平台使用费'
					},

					regPwd : {
						validator : function(value) {
							var reg = /^(\w){6,20}$/;
							return reg.test(value);
						},
						message : '密码只能是6-20位数字、字母或下划线'
					},

					checkZtmc : {

						validator : function(value) {

							var ztdm = $("#ztdm00").val();
							if (ztdm == "" || ztdm == null) {
								return true;
							} else {
								return $.ajax({
									async : false,
									url : ctx + "/common/validateCheckZtmc",
									data : {
										ztmc : encodeURI(value),
										ztdm : ztdm
									},
								}).responseText == "true";
							}
						},
						message : '企业名称与组织机构代码不符！'
					},

					checkZtdm : {

						validator : function(value) {
							return $.ajax({
								async : false,
								url : ctx + "/common/validateCheckZtdm",
								data : {
									ztdm : value
								}
							}).responseText == "true";
						},
						message : '组织机构代码不存在！'
					},

					checkZczb : {

						validator : function(value) {
							var ztdm = $("#ztdm00").val();
							if (ztdm == "" || ztdm == null) {
								return true;
							} else {
								return $.ajax({
									async : false,
									url : ctx + "/common/validateCheckZczb",
									data : {
										zczb : value,
										ztdm : ztdm
									}
								}).responseText == "true";
							}
						},
						message : '注册资本太高！'
					},

					checkKhyh : {

						validator : function(value) {
							var ztdm = $("#ztdm00").val();
							if (ztdm == "" || ztdm == null) {
								return true;
							} else {
								console.info(value + "khyh");
								return $.ajax({
									async : false,
									url : ctx + "/common/validateCheckKhyh",
									data : {
										khyh : encodeURI(value),
										ztdm : ztdm
									}
								}).responseText == "true";
							}
						},
						message : '开户银行不正确！'
					},

					checkJbzhzh : {

						validator : function(value) {
							var ztdm = $("#ztdm00").val();
							if (ztdm == "" || ztdm == null) {
								return true;
							} else {
								return $.ajax({
									async : false,
									url : ctx + "/common/validateCheckJbzhzh",
									data : {
										jbzhzh : value,
										ztdm : ztdm
									}
								}).responseText == "true";
							}
						},
						message : '基本账户账号不正确！'
					}

				});