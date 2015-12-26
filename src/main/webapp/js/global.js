//验证是否数组
function isBlank(arg) {
	return arg == null || arg.length == 0 ? true : false;
}

// 邮箱
function isValidEmail(email) {
	var regu = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|com|gov|mil|org|edu|int)$";
	var re = new RegExp(regu);
	return (email.search(re) != -1) ? true : false;
}

// 是否为整数
function isInteger(num) {
  var patrn=/^[0-9]*[1-9][0-9]*$/;   
  if (!patrn.exec(num)) 
   return false  
  else
   return true  
 }  

// 验证密码 只能输入6-20个字母、数字、
function isPasswd(str) 
{ 
	var reg=/[^A-Za-z0-9]/g;
    if (reg.test(str)){ 
    return  false ; 
    }else{ 
      if (str.length < 6 || str.length > 16){
       return false;
      }

	return true ;    
	}
	
}


// 网址
function IsURL(str_url) {
	var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
			+ "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" // ftp的user@
			+ "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
			+ "|" // 允许IP和DOMAIN（域名）
			+ "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
			+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
			+ "[a-z]{2,6})" // first level domain- .com or .museum
			+ "(:[0-9]{1,4})?" // 端口- :80
			+ "((/?)|" // a slash isn't required if there is no file name
			+ "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
	var re = new RegExp(strRegex);
	// re.test()
	if (re.test(str_url)) {
		return (true);
	} else {
		return (false);
	}
}


function urlEncode(str) {
		var str = "";
		if(typeof(str)=="undefined"){ 
			str = "";
		}
		str = encodeURI(str);
		str = encodeURIComponent(str);
 		return str;
}

// 验证手机号码
function validatemobile(obj) {
	 var mobile= obj;
	 if (isBlank(mobile)) {
	 	return false;
	 }
	var reg0=/^13\d{9}$/;
	var reg1=/^15\d{9}$/;
	var reg2=/^18\d{9}$/;
	if(reg0.test(mobile) || reg1.test(mobile) || reg2.test(mobile) ){
		return true;
	}else{
		return false;
	}
}


function checkUrl(url) {
	if (url.length <= 7) {
		return false;
	}
	url = url.toLowerCase();
	var result = url.match(/http:\/\//ig);
	if (result != null) {
		if (result.length == 1) {
			return true;
		}
	}
	return false;
}

function urlEncode(str) {
	return encodeURIComponent(str);
}

function strDate(str) {
	var reg = /^(\d{1,4})(-  |\/)(\d{1,2})\2(\d{1,2})$/;
	var r = str.match(reg);
	if (r == null) {
		return false;
	}
	var d = new Date(r[1], r[3] - 1, r[4]);
	if (r[1] != d.getFullYear()) {
		return false;
	}
	if (r[3] != (d.getMonth() + 1)) {
		return false;
	}
	if (r[4] != d.getDate()) {
		return false;
	}
	return true;
}

function IsDigit() {
	return ((event.keyCode >= 48) && (event.keyCode <= 57));
}


function strlen(str) {
	var len;
	var i;
	len = 0;
	for (i = 0; i < str.length; i++) {
		if (str.charCodeAt(i) > 255) {
			len += 2;
		} else {
			len++;
		}
	}
	return len;
}

function strlen2(str) {
	var len;
	var i;
	len = 0;
	for (i = 0; i < str.length; i++) {
		if (str.charCodeAt(i) > 255) {
			return true;
		}
	}
	return false;
}

function isWhiteWpace(s) {
	var whitespace = " \t\n\r";
	var i;
	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (whitespace.indexOf(c) >= 0) {
			return true;
		}
	}
	return false;
}

function isSsnString(ssn) {
	var re = /^[0-9a-z][\w-.]*[0-9a-z]$/i;
	if (re.test(ssn)) {
		return true;
	} else {
		return false;
	}
}

function getRaiovalue(o) {
	for ( var i = 0; i < o.length; i++) {
		if (o[i].checked) {
			return o[i].value;
		}
	}
}

function doCheckAlls(tag2, tag) {
	var status = document.getElementById(tag).checked;
	var arrays = document.getElementsByName(tag2);
	if (arrays) {
		for ( var i = 0; i < arrays.length; i++) {
			arrays[i].checked = status;
		}
	}
}

function doCheck(tag) {
	var arrays = document.getElementsByName(tag);
	if (arrays) {
		for ( var i = 0; i < arrays.length; i++) {
			if (arrays[i].checked) {
				return true;
			}
		}
	}
	return false;
}


// 验证是否是整数
function check(v) {
	var reg = /^\d+$/g;
	if (reg.test(v) == false) {
		return false;
	}
	return true;
}

// 比较两个日期的大小
// s1 日期
// operator 规则
// s2 日期
function compareDate(obj1, operator, obj2) {

	// 日期的有效性检测.
	if (obj1 != "" && obj2 != "") {
		// 生效日期.
		var start = obj1;
		// 失效日期.
		var end = obj2;
		// 以"-"分割字符串，返回数组.
		var startArr = start.split("-");
		var endArr = end.split("-");
		// 格式化为Date对像.
		var startDate = new Date(startArr[0], startArr[1], startArr[2]);
		var endDate = new Date(endArr[0], endArr[1], endArr[2]);

		// 得到从 1970 年 1 月 1 日开始计算到 Date 对象中的时间之间的毫秒数.
		var startDT = startDate.getTime();
		var endDT = endDate.getTime();
		if (operator == ">") {
			if (startDT > endDT) {
				return true;
			}
		} else if (operator == "<") {
			if (startDT < endDT) {
				return true;
			}
		}
	}

	return false;
}

function IsDate(op, formatString) {
	formatString = formatString || "ymd";
	var m, year, month, day;
	switch (formatString) {
	case "ymd":
		m = op.match(new RegExp(
				"^((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})$"));
		if (m == null)
			return false;
		day = m[6];
		month = m[5] * 1;
		year = (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
		break;
	case "dmy":
		m = op.match(new RegExp(
				"^(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))$"));
		if (m == null)
			return false;
		day = m[1];
		month = m[3] * 1;
		year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
		break;
	default:
		break;
	}
	if (!parseInt(month))
		return false;
	month = month == 0 ? 12 : month;
	var date = new Date(year, month - 1, day);
	return (typeof (date) == "object" && year == date.getFullYear()
			&& month == (date.getMonth() + 1) && day == date.getDate());
	function GetFullYear(y) {
		return ((y < 30 ? "20" : "19") + y) | 0;
	}
}



// 验证开始时间和结束时间
function validStaEndDate(sTime, eq, eTime) {

	if (!sTime.isEmpty() && eTime.isEmpty()) {
		alert("请正确选择结束时间!");
		return false;
	}

	if (!eTime.isEmpty() && sTime.isEmpty()) {
		alert("请正确选择开始时间!");
		return false;
	}

	if (compareDate(sTime, eq, eTime)) {
		alert('请正确选择开始时间和结束时间');
		return false;
	}
	return true;
}

/**
 * 验证文件名后缀格式 str 文件路径 fix 后缀名
 */
function checkFiles(str, fix) {
	var strRegex = "(" + fix + ")$"; // 用于验证图片扩展名的正则表达式
	var re = new RegExp(strRegex);
	if (re.test(str.toLowerCase())) {
		return true;
	} else {
		return false;
	}
}


/**
 * 时间变动
 * 
 * @param strInterval
 *            变动类型
 * @param NumDay
 *            变动数
 * @param dtDate
 *            变动基本时间
 * @param falg
 *            true增加、false减少
 * @return
 */
function DateAdd(strInterval, NumDay, dtDate,falg) {
	var dtTmp = new Date(dtDate);
	var f = null;
	if (isNaN(dtTmp))
		dtTmp = new Date();
	
	switch (strInterval) {
	case "s":
		if (falg)
			dtTmp = new Date(Date.parse(dtTmp) + (1000 * parseInt(NumDay)));
		else
			dtTmp = new Date(Date.parse(dtTmp) - (1000 * parseInt(NumDay)));
		break;
	case "n":
		if (falg)
			dtTmp = new Date(Date.parse(dtTmp) + (60000 * parseInt(NumDay)));
		else
			dtTmp = new Date(Date.parse(dtTmp) - (60000 * parseInt(NumDay)));
		break;
	case "h":
		if (falg)
			dtTmp = new Date(Date.parse(dtTmp) + (3600000 * parseInt(NumDay)));
		else
			dtTmp = new Date(Date.parse(dtTmp) - (3600000 * parseInt(NumDay)));
		break;
	case "d":
		if (falg)
			dtTmp = new Date(Date.parse(dtTmp) +(86400000 * parseInt(NumDay)));
		else
			dtTmp = new Date(Date.parse(dtTmp) - (86400000 * parseInt(NumDay)));
		break;
	case "w":
		if (falg)
		dtTmp = new Date(Date.parse(dtTmp)
				+((86400000 * 7) * parseInt(NumDay)));
		else
			dtTmp = new Date(Date.parse(dtTmp)
					- ((86400000 * 7) * parseInt(NumDay)));
		break;
	case "m":
		if (falg)
			dtTmp = new Date(dtTmp.getFullYear(), (dtTmp.getMonth())
				+ parseInt(NumDay), dtTmp.getDate(), dtTmp.getHours(), dtTmp
				.getMinutes(), dtTmp.getSeconds());
		else
			dtTmp = new Date(dtTmp.getFullYear(), (dtTmp.getMonth())
					- parseInt(NumDay), dtTmp.getDate(), dtTmp.getHours(), dtTmp
					.getMinutes(), dtTmp.getSeconds());
		break;
	case "y":
		// alert(dtTmp.getFullYear());
		if (falg)
		dtTmp = new Date(dtTmp.getFullYear() + parseInt(NumDay), dtTmp
				.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp
				.getMinutes(), dtTmp.getSeconds());
		else
			dtTmp = new Date(dtTmp.getFullYear() - parseInt(NumDay), dtTmp
					.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp
					.getMinutes(), dtTmp.getSeconds());
		// alert(dtTmp);
		break;
	}
	var mStr = new String(dtTmp.getMonth() + 1);
	var dStr = new String(dtTmp.getDate());
	if (mStr.length == 1) {
		mStr = "0" + mStr;
	}
	if (dStr.length == 1) {
		dStr = "0" + dStr;
	}
	return dtTmp.getFullYear() + "-" + mStr + "-" + dStr;

}

/**
 * 更改时间
 * 
 * @param d
 * @param v
 * @param objs
 * @param obje
 * @param falg
 * @return
 */
function changDays(d,v,objs,obje,falg) {
	if (falg) {
		objs.value = d;
		d = d.replace("-","/").replace("-","/");
		obje.value = DateAdd('d',v,d,falg);
	} else {
		obje.value = d;
		d = d.replace("-","/").replace("-","/");
		objs.value = DateAdd('d',v,d,falg);
	}
	return false;
}

/**
 * 循环获取表单值
 */
function getFormValues(thisForm){
	var items = thisForm.elements;
	var p=[];		
	for(var i=0;i<items.length;i++){
		var obj=items[i];			
		if (obj.type == 'text'               
					||obj.type == 'password'
					||obj.type =='textarea'
					||obj.type =='hidden'
					||obj.type =='select-one'
					) {
				var k=obj.name;
				var v=encodeURIComponent(obj.value);
				v=escape(v);
				p.push(k+"="+v);
			}
			if(obj.type =='checkbox'
						||obj.type =='radio'){
				if(obj.checked){		
					var k=obj.name;
					var v=encodeURIComponent(obj.value);
					v=escape(v);
					p.push(k+"="+v);
				}
			}
		}		
	return (p.join('&'));
}

/**
 * 得到字符串的字符长度（一个汉字占两个字符长）
 */
function getBytesLength(str) {
	// 在GBK编码里，除了ASCII字符，其它都占两个字符宽
	return str.replace(/[^\x00-\xff]/g, 'xx').length;
}

/**
 * 根据字符长来截取字符串
 */
function subStringByBytes(val, maxBytesLen) {
	var len = maxBytesLen;
	var result = val.slice(0, len);
	while(getBytesLength(result) > maxBytesLen) {
	  result = result.slice(0, --len);
	}
	return result;
}
 



/**
 * 验证文本长度 str 字符串 len 最大长度 flag true:弹出框 false:显示数量 textPar textPar
 */
function  listenTextLen(len,flag,textPar){
     var str =  $(""+ textPar).value;
     var num = str.length;
     // var arr = str.match(/[^\x00-\x80]/ig);
     // if(arr!=null)num+=arr.length;
     if (flag && num > len) {
     	alert('输入内容超出最大长度。系统将自动截断输入内容！'); 
     }
     $(""+ textPar).value = $(""+ textPar).value.substring(0,len);
    // $(""+ textPar+"Div").innerHTML = (len-num<0)?0:len-num;
}

// 获取当前格式化后的时间
function getNowFormatDate()
{
   var day = new Date();

   var Year = 0;
   var Month = 0;
   var Day = 0;
   var CurrentDate = "";
   // 初始化时间
   Year       = day.getFullYear();
   Month      = day.getMonth()+1;
   Day        = day.getDate();
   
   CurrentDate += Year + "-";
   
   if (Month >= 10 )
   {
    CurrentDate += Month + "-";
   }
   else
   {
    CurrentDate += "0" + Month + "-";
   }
   if (Day >= 10 )
   {
    CurrentDate += Day ;
   }
   else
   {
    CurrentDate += "0" + Day ;
   } 
   return CurrentDate;
}


/**
 * 用途：检查输入结束日期是否在今天之后，结束如期格式：yy-MM-dd 结束如期>=起始日期 输入： startDate：起始日期，字符串
 * endDate：结束如期，字符串 返回： 如果通过验证返回true,否则返回false
 */
function checkEndDate(edate) {
var today = getNowFormatDate(); 
var startDate = new Date(today.replace("-",",")).getTime() ;
var endDate = new Date(edate.replace("-",",")).getTime() ;
if( startDate >= endDate ) 
{  
   return false;
}
return true;
}


	// --- 设置cookie
	function setCookie(sName,sValue,expireHours) {
		var cookieString = sName + "=" + escape(sValue);
		// ;判断是否设置过期时间
		if (expireHours>0) {
			 var date = new Date();
			 date.setTime(date.getTime + expireHours * 3600 * 1000);
			 cookieString = cookieString + "; expire=" + date.toGMTString();
		}
		document.cookie = cookieString;
	}
	
	// --- 获取cookie
	function getCookie(sName) {
	  var aCookie = document.cookie.split("; ");
	  for (var j=0; j < aCookie.length; j++){
		var aCrumb = aCookie[j].split("=");
		if (escape(sName) == aCrumb[0])
		  return unescape(aCrumb[1]);
	  }
	  return null;
	}
	


// 产生随机数-n为位数
function randomNumForSearch(n){
		var result="";
    	for(var i=0;i<n;i++)
        	result+=Math.floor(Math.random()*10);
    	return result;		
	}
	


/**
 * 去除数组中重复值
 */
Array.prototype.distinct = function()   
{   
   var ret = [],
   resultArr = [],
   returnArr = [];
   var a = {};   
   for(var i=0; i<this.length; i++) {
    if(typeof a[this[i]] == "undefined") {
       a[this[i]] = false; // 数组中只有一项
    }
    else{
       a[this[i]] = true;   // 数组中有重复的项
    }
   }     
   for(var i in a) {
      resultArr[resultArr.length] = i; 
      if (a[i]) {
        returnArr[returnArr.length] = i; 
    }
   }
   ret[0] = resultArr;
   ret[1] = returnArr;
   return ret;   
}

function isNumber(str){ 
	var num = 0;
	// 判断是否数字
	var reg = /^\-?([1-9]\d*|0)(\.\d+)?$/; 
	if(!reg.test(str)) 
	{ 
	    return false;
	} 	
	return true;
}
