<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title></title>
      <!-- <#include "/include/head-file.ftl"/> -->
      <!--#include virtual="../include/head-file.ftl" -->
   </head>
   <body>
      <!--#include virtual="menu.ftl" -->
      <!--#include virtual="metarial/index.ftl" -->
      <!--#include virtual="metarial/form.ftl" -->
      <!--#include virtual="picture/index.ftl" -->
      <!--#include virtual="keyword/index.ftl" -->
      <!--#include virtual="keyword/form.ftl" -->
      <!--#include virtual="menu/index.ftl" -->
      <!--#include virtual="menu/new-pic-form.ftl" -->
      <!--#include virtual="menu/material-bank-form.ftl" -->
      <!--#include virtual="message/index.ftl" -->
   </body>
</html>
<script>
    // 测试使用 ==> 微信其他接口走之前需要先走这几个接口
    (function(){
        ms.http.get(ms.manager + "/mweixin/11/function.do")
        .then((res)=>{
            console.log('res',true);
        }, (err) => {
            console.log(err)
        })
    })()
</script>