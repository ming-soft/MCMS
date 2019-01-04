var Ms={};
Ms.validate = {
		/**
		 * ==================================================================
		 * 功能：替换空格（将多个连续空格替换为一个空格） 使用：ReplaceSpace(obj) 返回：string
		 * ==================================================================
		 */
		"replaceSpace":function(str) {
			 while ( str.indexOf("  ") >= 0 )
			 {
			  str = str.replace("  " ," ");
			 }
			 return str;
		},
		/**
		 * ================================================================== 
		 * 功能：检查是否要显示提示窗口
		 * ==================================================================
		 */
		"ifShow":function(ShowMsg){
			 if (ShowMsg == "" ){
			  return false;
			 }else{
			  return true;
			 }			
		},
		/**
		 * ==================================================================
		 * 功能：检测是否存在变量
		 * ==================================================================
		 */				
		"isExitsFunction":function(funcName){
		    try {
		        if (typeof(eval(funcName)) == "function") {
		            return true;
		        }
		    } catch(e) {}
		    return false;
		},		
		/**
		 * ==================================================================
		 * 功能：检测是否存在变量
		 * ==================================================================
		 */		
		"isExitsVariable":function(variableName){
			  try {
			        if (typeof(variableName) == "undefined") {
			            //alert("value is undefined"); 
			            return false;
			        } else {
			            //alert("value is true"); 
			            return true;
			        }
			    } catch(e) {}
			    return false;
		},		
		/**
		 * ==================================================================
		 * 功能：非空检查，不忽略空格 提示信息：输入框为空，请输入！ 使用：isNull(obj,string) 返回：bool
		 * ==================================================================
		 */
		"isNull":function(str,ShowMsg){
			 var show =this.ifShow(ShowMsg) ;
			 // 非空检查
			 if(str == ""){
				  if (show) alert(ShowMsg);
					  return false;
				 }else {
					 return true;
			 }			
		},
		/**
		 * ================================================================== 功能：邮箱地址检查
		 * 提示信息：未输入邮件地址或邮件地址无效！ 使用：MailCheck(obj,string) 返回：bool
		 * ==================================================================
		 */
		 "mailCheck":function(obj,ShowMsg)
		{
		 var show = ifShow(ShowMsg) ;
		 
		 if(obj.value!= "")
		 {
		  var ok1=obj.value.indexOf("@");
		  var ok2=obj.value.indexOf(".");
		  if(!((ok1!=-1)&&(ok2!=-1)))
		  {
		   if (show) alert(ShowMsg);
		   obj.focus();
		   obj.select();
		   return false;
		  }
		  var allowstrlist = "&#%<>";
		  var endvalue = true;
		  for (i=0;i<obj.value.length;i++) 
		  {
		   if (allowstrlist.indexOf(obj.value.substr(i,1))!=-1) 
		   {
		    endvalue=false;   
		    break;
		   }
		  }
		  if(endvalue==false)
		  {
		   if (show) alert(ShowMsg);
		   obj.focus();
		   obj.select();
		   return false;   
		  }
		  // 邮件地址正确
		  return true;
		 }
		 else
		 {
		  // 请输入电子信箱地址
		  if (show) alert(ShowMsg);
		  obj.focus();
		  obj.select();
		  return false;
		 }
		},
		





	/**
	 * ==================================================================
	 * 功能：检查输入的是否为数字 提示信息：未输入或输入的不是一个合法的数字！ 使用：isNumeric(obj,string) 返回：bool
	 * ==================================================================
	 */
	 "isNumeric":function(obj,ShowMsg)
		{ 
		 var show = ifShow(ShowMsg) ;
		 
		 var IfTrue = obj.value.search(/^(-|\+)?\d+(\.\d+)?$/) != -1;
		 
		 if (show && IfTrue ==false)
		 { 
		  alert(ShowMsg);
		  obj.focus();
		  obj.select();
		  return false;
		 } 
		 else
		 {
		  return true;
		 }
	},

	/**
	 * ================================================================== 功能：打印
	 * 使用：Print() 返回：
	 * ==================================================================
	 */
	 "Print":function()
	{
	
	 document.all.print.style.display = "none";
	 window.print();
	 window.close();
	},
	
	/**
	 * ==================================================================
	 * 功能：判断是否为日期(格式:yyyy-mm-dd) 提示信息：未输入或输入的日期格式错误！ 使用：isDate(obj,string) 返回：bool
	 * ==================================================================
	 */
	 "isDate":function(obj,ShowMsg)
	{
	 var show = ifShow(ShowMsg) ;
	 
	 if(obj.value==null)
	 {
	 if (show) alert(ShowMsg);
	 return false;
	 }
	 
		if(obj.value=="")
		{
	 if (show) alert(ShowMsg);
	 return false;
	 }
		
		var datePat=/^(\d{2}|\d{4})(\-)(\d{1,2})(\-)(\d{1,2})$/;
		
		var dateStr=obj.value;
		// is the format ok?
	 var matchArray = dateStr.match(datePat);
	
	
		if (matchArray==null)
		{
	  if (show) alert(ShowMsg);
			return false;
		}
		year=matchArray[1];
		month=matchArray[3];
		day=matchArray[5];
	
		if (year.length!=4 || month.length!=2 || day.length!=2)
		{
	  if (show) alert(ShowMsg);
			return false;
		}
		if (month < 1 || month > 12)
		{
	  if (show) alert(ShowMsg);
			return false;
		}
		if (day < 1 || day > 31)
		{
	  if (show) alert(ShowMsg);
			return false;
		}
	
		if ((month==4 || month==6 || month==9 || month==11) && day==31)
		{
	  if (show) alert(ShowMsg);
			return false;
		}
	
		if (month==2)
		{
			var isleap=(year % 4==0 && (year % 100 !=0 || year % 400==0));
			if (day>29 || ((day==29) && (!isleap)))
			{
	   if (show) alert(ShowMsg);
				return false;
			}
		}
		return true;
	},

	/**
	 * ==================================================================
	 * 功能：日期大小判断(格式：yyyy-mm-dd) 提示信息：未输入或输入的开始日期大于结束日期！
	 * 使用：JudgeDate(obj1,obj2,string) 返回：bool
	 * ==================================================================
	 */
	 "JudgeDate":function(obj1,obj2,ShowMsg)
	{
	 var show = ifShow(ShowMsg) ;
	 
	 var eva = isDate(obj1,"") && isDate(obj2,"");
	 
		if(obj1.value!="" && obj2.value!="" & eva != false)
		{
	  var date1 = obj1.value;
			var myDate1 = Date.parse(date1.replace("-","/"));
			var date2 = obj2.value;
			var myDate2 = Date.parse(date2.replace("-","/"));
			if(myDate1 > myDate2)
			{
				if (show) alert(ShowMsg);
				return false;
			}
			else
			{
	   return true;
			}
		}
		else
		{
	  if (show) alert(ShowMsg);
	  return false;
		}
	},

/**
 * ==================================================================
 * 功能：字符串操作,去除字符串两边的空格 使用：Trim(string) 返回：string
 * ==================================================================
 */                                
            /**
			 * ==================================================================
			 * 功能：去除左边的空格 使用：LTrim(string) 返回：string
			 * ==================================================================
			 */
             "LTrim":function(str)
            {
                var whitespace = new String(" \t\n\r");
                var s = new String(str);
                
                if (whitespace.indexOf(s.charAt(0)) != -1)
                {
                    var j=0, i = s.length;
                    while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
                    {
                        j++;
                    }
                    s = s.substring(j, i);
                }
                return s;
            },
             
            /**
			 * ==================================================================
			 * 功能：去除右边的空格 使用：RTrim(string) 返回：string
			 * ==================================================================
			 */
             "RTrim":function(str)
            {
                var whitespace = new String(" \t\n\r");
                var s = new String(str);
             
                if (whitespace.indexOf(s.charAt(s.length-1)) != -1)
                {
                    var i = s.length - 1;
                    while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
                    {
                        i--;
                    }
                    s = s.substring(0, i+1);
                }
                return s;
            },
            
	// 去除前后空格
	 "Trim":function(str)
	{
		return this.RTrim(this.LTrim(str));
	},            


	/**
	 * ==================================================================
	 * 功能：无效字符的检测（不允许输入特殊字符） 提示信息：未输入或输入包含非法字符 使用：CheckChar(obj,Lchar,string)
	 * Lchar：要检查的特殊字符 返回：bool
	 * ==================================================================
	 */
	 "CheckChar":function(obj,Lchar,ShowMsg)
	{
	 var show = ifShow(ShowMsg);
	
	 var strlist = Lchar; // "~!@#$%^&*?<>\"\'";
	 
	 // 无效字符的检测
	 if(obj.value!= "")
	 {  
	  var tmpbool=true;
	  for (i=0;i<obj.value.length;i++)
	  {
	   if(strlist.indexOf(obj.value.substr(i,1))!=-1)
	   {
		tmpbool=false;
		break;
	   }
	   else
	   {}
	  }
	  
	  if(tmpbool==false)
	  {
	   if (show) alert(ShowMsg + strlist);
	   obj.focus();
	   obj.select();
	   return false;
	  }
	  else
	  {
	   return true;
	  }
	 }
	 else
	 {
	  if (show) alert(ShowMsg + strlist);
	  return false;
	 }
	  
	},

	/**
	 * ==================================================================
	 * 功能：判断是否为整数、正整数、负整数、正整数+0、负整数+0 提示信息：参数错误或输入的不是一个（整数）。。
	 * 使用：isInt(obj,string,int or string,string) (测试对象,+ or - or empty,empty or
	 * 0,显示信息) 空 整数 + 正整数 - 负整数 返回：bool
	 * ==================================================================
	 */
	 "isInt":function(obj,sign,zero,ShowMsg)
	{
	 var show =this.ifShow(ShowMsg);
	 
	 var objStr = obj.value;
		var reg;    
		var bolzero;    
		
		if(this.Trim(objStr)=="")
		{  
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
			return false;
		}
		else
		{
			objStr=objStr.toString();
		}    
		
		if((sign==null)||(this.Trim(sign)==""))
		{
			sign="+-";
		}
		
		if((zero==null)||(this.Trim(zero)==""))
		{
			bolzero=false;
		}
		else
		{
			zero=zero.toString();
			if(zero==0)
			{
				bolzero=true;
			}
			else
			{
				if (show) alert(ShowMsg);
				obj.focus();
				obj.select();
				return false;
			}
		}
		
		switch(sign)
		{
			case "+-":
				// 整数
				reg=/(^-?|^\+?)\d+$/;            
				break;
			case "+": 
				if(!bolzero)           
				{
					// 正整数
					reg=/^\+?[0-9]*[1-9][0-9]*$/;
				}
				else
				{
					// 正整数+0
					// reg=/^\+?\d+$/;
					reg=/^\+?[0-9]*[0-9][0-9]*$/;
				}
				break;
			case "-":
				if(!bolzero)
				{
					// 负整数
					reg=/^-[0-9]*[1-9][0-9]*$/;
				}
				else
				{
					// 负整数+0
					// reg=/^-\d+$/;
					reg=/^-[0-9]*[0-9][0-9]*$/;
				}            
				break;
			default:
				if (show) alert(ShowMsg);
				obj.focus();
	   obj.select();
				return false;
				break;
		}
		
		var r=objStr.match(reg);
		if(r==null)
		{
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
			return false;
		}
		else
		{    
			return true;     
		}
	},
	/**
	 * ==================================================================
	 * 功能：判断是否为浮点数、正浮点数、负浮点数、正浮点数+0、负浮点数+0 提示信息：参数错误或输入的不是一个（浮点数）。。
	 * 使用：isFloat(obj,string,int or string,string) (测试对象,+ or - or empty,empty or
	 * 0,提示信息) 参数二： 空 浮点数 + 正浮点数 - 负浮点数 返回：bool
	 * ==================================================================
	 */
	 "isFloat":function(obj,sign,zero,ShowMsg)
	{
	 var show = ifShow(ShowMsg);
	 
	 var objStr = obj.value;
		var reg;    
		var bolzero;    
		
		if(Trim(objStr)=="")
		{
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
			return false;
		}
		else
		{
			objStr=objStr.toString();
		}    
		
		if((sign==null)||(Trim(sign)==""))
		{
			sign="+-";
		}
		
		if((zero==null)||(Trim(zero)==""))
		{
			bolzero=false;
		}
		else
		{
			zero=zero.toString();
			if(zero==0)
			{
				bolzero=true;
			}
			else
			{
				if (show) alert(ShowMsg);
				obj.focus();
	  obj.select();
				return false;
			}
		}
		
		switch(sign)
		{
			case "+-":
				// 浮点数
				reg=/^((-?|\+?)\d+)(\.\d+)?$/;
				break;
			case "+": 
				if(!bolzero)           
				{
					// 正浮点数
		reg=/^\+?(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
				}
				else
				{
					// 正浮点数+0
					reg=/^\+?\d+(\.\d+)?$/;
				}
				break;
			case "-":
				if(!bolzero)
				{
					// 负浮点数
		reg=/^-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
				}
				else
				{
					// 负浮点数+0
					reg=/^((-\d+(\.\d+)?)|(0+(\.0+)?))$/;
				}            
				break;
			default:
				if (show) alert(ShowMsg);
				obj.focus();
	  obj.select();
				return false;
				break;
		}
		
		var r=objStr.match(reg);
		if(r==null)
		{
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
			return false;
		}
		else
		{        
			return true;     
		}
	},


	/**
	 * ==================================================================
	 * 功能：验证身份证号码是否有效 提示信息：未输入或输入身份证号不正确！ 使用：isIDno(obj,string) 返回：bool
	 * ==================================================================
	 */
	 "isIDcard":function(obj,ShowMsg)
	{
	 var show = ifShow(ShowMsg);
	 
	 // aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",71:"台湾",81:"香港",82:"澳门",91:"国外"};
	 var aCity = "11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91";
	 
	 var iSum = 0;
	 var info = "";
	 var idCardLength = obj.value.length;
	
	 if(!/^\d{17}(\d|x)$/i.test(obj.value)&&!/^\d{15}$/i.test(obj.value)) 
	 {
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
	  return false;
	 }
	 
	 // 在后面的运算中x相当于数字10,所以转换成a
	 obj.value = obj.value.replace(/x$/i,"a");
	 
	 var curCity = obj.value.substr(0,2);
	
	 if(!(aCity.indexOf(curCity) > 0) )
	 {
	  if (show) alert(ShowMsg);
	  obj.focus();
	  obj.select();
	  return false;
	 }
	
	 if (idCardLength==18)
	 {
	  sBirthday=obj.value.substr(6,4)+"-"+Number(obj.value.substr(10,2))+"-"+Number(obj.value.substr(12,2));
	  var d = new Date(sBirthday.replace(/-/g,"/"));
	  if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))
	  {
	   if (show) 
		alert(ShowMsg);
	   obj.focus();
	   obj.select();
	   return false;
	  }
	 
	  for(var i = 17;i>=0;i --)
	  iSum += (Math.pow(2,i) % 11) * parseInt(obj.value.charAt(17 - i),11);
	 
	  if(iSum%11!=1)
	  {
	   if (show) 
		alert(ShowMsg);
	   obj.focus();
	   obj.select();
	   return false;
	  }
	 
	 }
	 else if (idCardLength==15)
	 {
	  sBirthday = "19" + obj.value.substr(6,2) + "-" + Number(obj.value.substr(8,2)) + "-" + Number(obj.value.substr(10,2));
	  var d = new Date(sBirthday.replace(/-/g,"/"));
	  var dd = d.getFullYear().toString() + "-" + (d.getMonth()+1) + "-" + d.getDate();
	
	  if(sBirthday != dd)
	  {   
	   if (show) 
		alert(ShowMsg);
	   obj.focus();
	   obj.select();
	   return false;
	  }
	 }
	 return true; 
	},


	/**
	 * ==================================================================
	 * 功能：验证电话号码格式是否正确 提示信息：未输入或输入电话号码格式不正确！ 使用：isPhoneNo(obj,string) 返回：bool
	 * ==================================================================
	 */
	 "isPhoneNo":function(obj,ShowMsg)
	{
	 var show = ifShow(ShowMsg);
	 
	 var phoneNo = obj.value;
	 var Endvalue = true;
	 var allowstrlist = "1234567890()-";
	 if(phoneNo!="")
	 {   
	  for (i=0;i<phoneNo.length;i++) 
	  {
		if (allowstrlist.indexOf(phoneNo.substr(i,1)) == -1) 
		{
	   Endvalue = false;   
	   break;
		}
	  }
	  if(Endvalue == false)
	  {
	   if (show) 
		alert(ShowMsg);
	   obj.focus();
	   obj.select();
	   return false;
	  }
	 }
	 else
	 {
	  if (show) 
		alert(ShowMsg);
	  obj.focus();
	  obj.select();
	  return false;
	 }
	 return true;
	},

	/**
	 * ==================================================================
	 * 功能：将金额小写转化成汉字大写 提示信息：
	 * 使用：MoneyToUpper('零,壹,贰,叁,肆,伍,陆,柒,捌,玖,','元,拾,佰,仟,万,拾,佰,仟,亿,拾,角,分,整,零零,零亿,亿万,零万,零元,零角,零分,',obj.value)
	 * 返回：string str1 = "零,壹,贰,叁,肆,伍,陆,柒,捌,玖," str2 =
	 * "元,拾,佰,仟,万,拾,佰,仟,亿,拾,角,分,整,零零,零亿,亿万,零万,零元,零角,零分,"
	 * ==================================================================
	 */
	 "MoneyToUpper":function(str1,str2,Num)
	{
		var charList1 = str1.split(",");
		var charList2 = str2.split(",");
	   
	 for( i = Num.length-1;i>=0;i--)
	 {
	  // 替换tomoney()中的“,”
	  Num = Num.replace(",","");
	  // 替换tomoney()中的空格
	  Num = Num.replace(" ","");
	 }
	 
	 // 替换掉可能出现的￥字符
	 Num = Num.replace("￥","");
	 // 验证输入的字符是否为数字
	 if(isNaN(Num)) 
	 {
	  alert("Error: Not a Number !");
	  return "";
	 }
	 
	   // ---字符处理完毕，开始转换，转换采用前后两部分分别转换---
	   var part = String(Num).split(".");
	   var newchar = "";   
	   // 小数点前进行转化
	 for(i = part[0].length - 1; i>= 0 ; i--)
	 {
	  // 若数量超过拾亿单位，提示
	  if(part[0].length > 10)
	  { 
	   alert("Error Over Max Length !");
	   return "";
	  }
	  var tmpnewchar = "";
	  
	  var perchar = part[0].charAt(i);
		 
	  tmpnewchar= charList1[perchar] + tmpnewchar;
	  
	  var indx = part[0].length-i-1;
	  if (indx == 0 || indx == 4 || indx == 8 || indx == 9)
	  {
	   tmpnewchar = tmpnewchar + charList2[indx];
	  }
	  else
	  {
	   if(perchar!=0) tmpnewchar = tmpnewchar + charList2[indx];
	  }
	  newchar = tmpnewchar + newchar;
		  
	 }
	
	 // 小数点之后进行转化
		if( String(Num).indexOf(".") != -1)
		{
	  if(part[1].length > 2) 
	  {
	   part[1] = part[1].substr(0,2);
	  }
	  for(i=0;i<part[1].length;i++)
	  {
	   tmpnewchar = "";
	   perchar = part[1].charAt(i);
		   
	   tmpnewchar = charList1[perchar] + tmpnewchar;              
	   if(i==0)tmpnewchar =tmpnewchar + charList2[10];  // 角
	   if(i==1)tmpnewchar = tmpnewchar + charList2[11]; // 分
	   newchar = newchar + tmpnewchar;
	  } 
		 
	 }    
	  
	 // alert(newchar);
	
	 // 替换 零零 为 零
	 while(newchar.search(charList2[13]) != -1)
	 {
	  newchar = newchar.replace(charList2[13], charList1[0]);  // 零零 to 零
	  newchar = newchar.replace(charList2[14], charList2[8]);  // "零亿" to "亿"
	  newchar = newchar.replace(charList2[15], charList2[8]);  // "亿万" to "亿"
	 
	  newchar = newchar.replace(charList2[16], charList2[4]);  // "零万" to "万"
	  newchar = newchar.replace(charList2[17], charList2[0]);  // "零元" to "元"
	  newchar = newchar.replace(charList2[18], "");    // "零角" to ""
	  newchar = newchar.replace(charList2[19], "");    // "零分" to ""
	 }
	 
	  newchar = newchar.replace(charList2[14], charList2[8]);  // "零亿" to "亿"
	  newchar = newchar.replace(charList2[15], charList2[8]);  // "亿万" to "亿"
	 
	  newchar = newchar.replace(charList2[16], charList2[4]);  // "零万" to "万"
	  newchar = newchar.replace(charList2[17], charList2[0]);  // "零元" to "元"
	  newchar = newchar.replace(charList2[18], "");    // "零角" to ""
	  newchar = newchar.replace(charList2[19], "");    // "零分" to ""
	
	 newchar = newchar + charList2[12];
	
		// 0.6元的情况
	 if(newchar.indexOf(charList2[0]) == 0)
	  newchar = newchar.replace(charList2[0],"");
	 
	 return newchar;
	},
	
};