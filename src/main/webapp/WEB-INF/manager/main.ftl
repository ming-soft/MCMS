<!--主界面-->
<!DOCTYPE html>
<html lang="en">
<head> 
  <title>铭飞CMS</title> 
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <link rel="icon" href="http://cdn.mingsoft.net/global/images/ms.ico" type="x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" /> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /> 
  <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
  <script src="${base}/static/plugins/echarts.4.2.1/echarts.min.js"></script>
  <#include "../../include/head-file.ftl">
<style>
body{  height: 100%;}
 [v-cloak] {
   display: none;
 }
</style>
</head>
<body>
<div id="main" v-cloak>
  <el-main class="ms-container">
    <!-- 右侧头部 -->
    <div class="left">
      <div class="real-time-data">
        <el-header class="header" style="height: 35px;">
          <div> <i class="iconfont icon-shugang"></i>实时数据</div>
        </el-header>
        <div class="box">
          <el-row :gutter="20" class="box-detail" justify="center" style="text-align: center">
            <el-col :span="8">在售</el-col>
            <el-col :span="8">断货</el-col>
            <el-col :span="8">停售</el-col>
          </el-row>
          <el-row :gutter="20" class="box-number" >
            <el-col :span="8">1204</el-col>
            <el-col :span="8">23</el-col>
            <el-col :span="8">2</el-col>
          </el-row>
          <el-row :gutter="20" class="box-percentage" >
            <el-col :span="8">99%</el-col>
            <el-col :span="8">5%</el-col>
            <el-col :span="8">0.1%</el-col>
          </el-row>
        </div>
      </div>
      <div class="real-time-data">
        <el-header class="header" style="height: 35px;">
          <i class="iconfont icon-shugang"></i>计划目标
        </el-header>
        <div class="box">
          <el-row :gutter="20" class="box-detail" >
            <el-col :span="12">生产中</el-col>
            <el-col :span="12">已完成</el-col>
          </el-row>
          <el-row :gutter="20" class="box-number" >
            <el-col :span="12">104</el-col>
            <el-col :span="12">230</el-col>
          </el-row>
          <el-row :gutter="20" class="box-percentage" >
            <el-col :span="12">28%</el-col>
            <el-col :span="12">62%</el-col>
          </el-row>
        </div>
      </div>
      <div class="real-time-data" style="flex: 3;">
        <el-header class="header" style="height: 35px;">
          <i class="iconfont icon-shugang"></i>财务状况
            <div style="float: right;">
                五月<i class="el-icon-arrow-down"></i>
            </div>
        </el-header>
        <div class="box">
          <el-row :gutter="20" class="box-detail" >
            <el-col :span="12">当前余额</el-col>
            <el-col :span="12">待收货款</el-col>
          </el-row>
          <el-row :gutter="20" class="box-number" >
            <el-col :span="12"><div class="money"><span class="font">￥</span>120400.<span class="font">00</span></div></el-col>
            <el-col :span="12"><span class="font">￥</span>5111.<span class="font">99</span></el-col>
          </el-row>
        </div>
        <#--统计图-->
        <div id="chartFinance" style="width: 100%;height: 180px"></div>
      </div>
    </div>
    <div class="right">
      <div class="right-top">
        <div class="right-top-box real-time-data" style="width: 40%">
          <el-header class="header" style="height: 35px;">
            <i class="iconfont icon-shugang"></i>广告收支对比
          </el-header>
          <#--统计图-->
            <div id="chartAdvertising" style="width: 100%;height: 240px"></div>
        </div>
        <div class="right-top-box real-time-data">
          <el-header class="header">
            <i class="iconfont icon-shugang"></i>生命周期
          </el-header>
          <#--统计图-->
            <div id="chartLife" style="width: 100%;height: 210px"></div>
        </div>
        <div class="right-top-box real-time-data">
          <el-header class="header">
            <i class="iconfont icon-shugang"></i>销售物流
          </el-header>
            <div id="chartSales" style="width: 100%;height: 210px"></div>
          <#--统计图-->
        </div>
      </div>
      <div class="real-time-data" style="flex: 5;margin: 9px;">
        <el-header class="header" style="height: 35px;">
          <i class="iconfont icon-shugang"></i>团队业绩
            <div style="float: right;">
                本周<i class="el-icon-arrow-down"></i>
            </div>
        </el-header>
        <div class="backgroundImage">
          <div id="chartTeam" style="width: 100%;height: 400px"></div>
        </div>
        <#--统计图-->
      </div>
    </div>
  </el-main>
</div>
<div id="custom">
  <el-dialog title="收货地址" :visible.sync="dialogFormVisible">
    <el-form :model="form">
      <el-form-item label="活动名称" :label-width="150">
        <el-input v-model="form.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="活动区域" :label-width="150">
        <el-select v-model="form.region" placeholder="请选择活动区域">
          <el-option label="区域一" value="shanghai"></el-option>
          <el-option label="区域二" value="beijing"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="dialogFormVisible = false">确 定</el-button>
    </div>
  </el-dialog>
</div>
</body>
</html>
<script>

  function cs(){
    var data= {
      data(){ return {
        dialogFormVisible: true,
        form: {
          region: "111",
          formLabelWidth:150,
          name: "测试弹框"
        },
      }} ,
      mounted: function () {
        console.log(2222)
      }
    };
    custom('custom',data);
  }
  function custom(id,obj) {
    var dom = parent.document.getElementById("id");
    if (!dom) {
      dom = parent.document.createElement('div');
      dom.id =id;
      parent.document.body.appendChild(dom);
    }
    dom.innerHTML = document.querySelector('#'+id).innerHTML;
    if(obj.data&&(typeof obj.data)==="object"){
      obj.data = function () {
        return obj.data
      }
    }
    var ctor = parent.Vue.extend(obj);
   return  new ctor().$mount('#'+id);
  }
</script>
<script>
  var mainVue = new Vue({
    el: '#main',
    data:{
      chartFinance:'',
      chartAdvertising:'',
      chartLife:'',
      chartSales:'',
      chartTeam:'',
    },
    methods: {
      list: function () {
        this.finance();
        this.advertising();
        this.life();
        this.sales();
        this.team();
      },
      finance: function () {
        this.chartFinance = echarts.init(document.getElementById("chartFinance"));
        var option = {
          tooltip: {
            trigger: 'none',
          },
          grid:{
            x:5,
            y:30,
            x2:5,
            y2:30,
          },
          xAxis: {
            type: 'category',
            silent: false,
            splitLine: {
              show: false
            },
            axisLine: {
              show: false
            },
            axisTick: {
              show: false
            },
            data: ['01', '02', '03', '04', '05', '06','07']
          },
          yAxis: {
            show: false,
            minInterval: 8,
          },
          series: [
            {
              type:'line',
              smooth: true,
              data: [{value:7,symbol:'none'},
                {value:4.5,symbol:'circle',symbolSize:9,itemStyle:{borderColor:'#069bff',color:'#ffe'}},
                {value:3.5,symbol:'none'},
                {value:2.5,symbol:'none'},
                {value:2,symbol:'none'},
                {value:1.5,symbol:'none'},
                {value:2,symbol:'none'}],
              lineStyle:{
                color:'#069bff',
                width: 2,
              },
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: '#cfebfd'
                    }, {
                        offset: 1,
                        color: '#ffe'
                    }])
                }
            },
              itemStyle:{
                color:'#069bff',
                borderWidth: 4,
              }
            },
            {
              type:'line',
              smooth: true,
              data: [{value:2,symbol:'none'},
                    {value:1,symbol:'none'},
                    {value:2,symbol:'none'},
                    {value:3,symbol:'none'},
                    {value:5,symbol:'circle',symbolSize:9,itemStyle:{borderColor:'#feb23a',color:'#ffe'}},
                    {value:4,symbol:'none'},
                    {value:6,symbol:'none'}],
              lineStyle:{
                color:'#feb23a',
                width: 2,
              },
                areaStyle: {
                    normal: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: '#fedba3'
                        }, {
                            offset: 1,
                            color: '#ffe'
                        }])
                    }
                },
              itemStyle:{
                color:'#feb23a',
                borderWidth: 4,
              }
            }
          ]
        };
          this.chartFinance.setOption(option);
      },
        advertising: function(){
            this.chartAdvertising = echarts.init(document.getElementById("chartAdvertising"));
            var option = {
                tooltip: {
                    trigger: 'none',
                },
                legend: {
                    itemWidth: 10,
                    itemHeight: 10,
                    right: '10%',
                    top: 0,
                    data:['支出','收入']
                },
                grid:{
                  x:25,
                  y:10,
                  x2:25,
                  y2:25,
                },
                xAxis: {
                    type: 'category',
                    silent: false,
                    splitLine: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    data: ['01', '02', '03', '04', '05', '06','07']
                },
                yAxis: {
                    splitLine:{
                      show: true,
                      lineStyle:{
                        color:'#f6f6f6',
                      },
                    },
                    axisLine:{
                      show: false,
                    },
                    axisTick:{
                      show: false,
                    },
                    axisLabel:{
                      show: false,
                    },
                },
                series: [
                    {
                        name:'支出',
                        type:'bar',
                        barWidth:'15%',
                        itemStyle:{
                            color: '#feb23a',
                        },
                        data:[7,7,7,4,5,7.5,7.5]
                    },
                    {
                        name:'收入',
                        type:'bar',
                        barWidth:'15%',
                        itemStyle:{
                            color: '#069bff',
                        },
                        data:[8,8,5,3.5,8,9,9]
                    }
                ]
            };
            this.chartAdvertising.setOption(option);
        },
        life: function(){
            this.chartLife = echarts.init(document.getElementById("chartLife"));
            var option = {
                tooltip : {
                    trigger: 'none',
                },
                legend: {
                  itemWidth: 10,
                  itemHeight: 10,
                  itemGap:20,
                    x : 'center',
                    y : 'bottom',
                    data:['热销期','复购率','平销期','旺销期','滞销期']
                },
                calculable : true,
                series : [
                    {
                        type:'pie',
                        radius : [20, 40],
                        center: ['50%','40%'],
                        roseType : 'radius',
                        data:[
                            {value:150, name:'热销期',itemStyle:{color: '#2e65fd'}},
                            {value:100, name:'复购率',itemStyle:{color: '#8abe78'}},
                            {value:60, name:'平销期',itemStyle:{color: '#feb23a'}},
                            {value:100, name:'旺销期',itemStyle:{color: '#69c0fe'}},
                            {value:40, name:'滞销期',itemStyle:{color: '#d0e3fe'}},
                        ]
                    }
                ]
            };
            this.chartLife.setOption(option);
        },
        sales: function(){
            this.chartSales = echarts.init(document.getElementById("chartSales"));
            var option = {
                tooltip : {
                    trigger: 'none',
                },
                legend: {
                  itemWidth: 10,
                  itemHeight: 10,
                  itemGap:20,
                    x : 'center',
                    y : 'bottom',
                    data:['0-2天','2-5天','5-8天','8天以上']
                },
                calculable : true,
                series : [
                    {
                        type:'pie',
                        radius : [20, 40],
                        center: ['50%','40%'],
                        roseType : 'radius',
                        data:[
                            {value:130, name:'0-2天',itemStyle:{color: '#2e65fd'}},
                            {value:30, name:'2-5天',itemStyle:{color: '#d0e3fe'}},
                            {value:80, name:'5-8天',itemStyle:{color: '#feb23a'}},
                            {value:100, name:'8天以上',itemStyle:{color: '#8abe78'}},
                        ]
                    }
                ]
            };
            this.chartSales.setOption(option);
        },
        team: function(){
            this.chartTeam = echarts.init(document.getElementById("chartTeam"));
            var option = {
                grid:{
                  x:40,
                  y:40,
                  x2:20,
                  y2:40,
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    silent: false,
                    splitLine: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    data: ['30.05', '31.05', '01.06', '02.06', '03.06', '04.06', '05.06','06.06','07.06','08.06','09.06']
                },
                yAxis: {
                    type: 'value',
                    boundaryGap: true,
                    axisLine:{
                      show: false,
                    },
                    axisTick:{
                      show: false,
                    },
                    splitLine:{
                      show: true,
                    },
                },
                series: [{
                    data: [{value:42.5,symbol:'none'},
                      {value:39,symbol:'none'},
                      {value:45,symbol:'none'},
                      {value:30,symbol:'none'},
                      {value:38,symbol:'none'},
                      {value:45,symbol:'none'},
                      {value:30,symbol:'none'},
                      {value:36,symbol:'none'},
                      {value:46,symbol:'circle',symbolSize:10,itemStyle:{borderColor:'#0099ff',color:'#ffe',borderWidth:4}},
                      {value:28,symbol:'none'},
                      {value:45,symbol:'none'}],
                    type: 'line',
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                        ]
                    },
                    smooth: 0.5,
                    lineStyle:{
                        color: '#0099ff',
                        width: 6,
                    },
                    itemStyle:{
                        color: '#0099ff',
                        width: 5,
                    },
                }]
            };
            this.chartTeam.setOption(option);
        },
    },
    mounted(){
      var that = this;
      that.$nextTick(function () {
        that.list();
      });
    },
  })
  window.addEventListener("resize", function () {
    mainVue.chartTeam.resize();
    mainVue.chartFinance.resize();
    mainVue.chartAdvertising.resize();
    mainVue.chartLife.resize();
    mainVue.chartSales.resize();
  });
  window.onload = function () {
    mainVue.chartAdvertising.resize();
    mainVue.chartLife.resize();
    mainVue.chartSales.resize();
    mainVue.chartTeam.resize();
    mainVue.chartFinance.resize();
    mainVue.chartAdvertising.resize();
    mainVue.chartLife.resize();
  }
</script>
<style>
  html{
    overflow: hidden;
  }
  #main .ms-container{
    display: flex;
    flex-direction: row;
    height: 100vh;
    margin: 0px !important;
 }
  #main{
    min-width: 1200px;
 }
 #main .left{
   display: flex;
   flex-direction: column;
   width: 25%;
 }
 #main .left .real-time-data{
   flex: 2;
   margin: 9px;
 }
 #main .right-top .right-top-box{
   width: 30%;
   margin: 9px;
 }
 #main .right{
   width: 75%;
   display: flex;
   flex-direction: column;
 }
 #main .right-top{
   display: flex;
   flex-direction: row;
   flex: 4;
 }
  #main .real-time-data{
    box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
  }
  #main .iconfont{
    padding-top: 5px;
    font-size: 20px;
    color: #0099ff;
  }
  #main .header{
    font-size: 16px;
    color: #333;
    padding-top: 10px;
  }
  #main .box{
    padding: 0 10px;
    text-align: center;
    padding-bottom: 17px;
  }
  #main .box-detail{
    color: #3c5175;
    padding-top: 24px;
    font-size: 14px;
  }
  #main .box-number{
    color: #0099ff;
    padding-top: 24px;
    font-size: 19px;
    font-weight: bolder;
  }
  #main .box-percentage{
    color: #3c5175;
    padding-top: 24px;
    font-size: 14px;
  }
  #main .box-number .money{
    color: #feb23a;
  }
  #main .font{
    font-size: 16px;
  }
  #main .backgroundImage{
    background: url('../images/background.png') no-repeat center!important;
    background-size: 132% 80%!important;
  }
</style>
<script>
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?f9a6362fff0e5ef420e8566f15e5806e";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
  })();
</script>