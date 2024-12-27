(function(t,o){typeof exports=="object"&&typeof module<"u"?o(exports,require("axios"),require("vue"),require("vue3-sfc-loader"),require("element-plus")):typeof define=="function"&&define.amd?define(["exports","axios","vue","vue3-sfc-loader","element-plus"],o):(t=typeof globalThis<"u"?globalThis:t||self,o(t.MsElForm={},t.axios,t.Vue,t.vue3SfcLoader))})(this,function(exports,axios,Vue,vue3SfcLoader){"use strict";function _interopNamespaceDefault(t){const o=Object.create(null,{[Symbol.toStringTag]:{value:"Module"}});if(t){for(const n in t)if(n!=="default"){const l=Object.getOwnPropertyDescriptor(t,n);Object.defineProperty(o,n,l.get?l:{enumerable:!0,get:()=>t[n]})}}return o.default=t,Object.freeze(o)}const Vue__namespace=_interopNamespaceDefault(Vue),msIcon_vue_vue_type_style_index_0_scoped_15364228_lang="",_export_sfc=(t,o)=>{const n=t.__vccOpts||t;for(const[l,d]of o)n[l]=d;return n},_sfc_main$2={name:"ms-icon",props:["value"],data:function(){return{dialogVisible:!1,icons:[],mark:-1}},methods:{openIconList:function(){this.dialogVisible=!0},selected:function(t,o){this.$emit("update:value","icon-"+t),this.mark=o},select:function(){this.dialogVisible=!1},iconList:function(){var t=this;axios.create().get(ms.base+"/static/plugins/iconfont/1.0.0/iconfont.json",{}).then(function(o){t.icons=o.data.glyphs}).catch(function(o){console.log(o)})}},created:function(){this.iconList()}},_hoisted_1$2={class:"list"},_hoisted_2$1=["onClick"];function _sfc_render$2(t,o,n,l,d,u){const s=Vue.resolveComponent("el-button"),r=Vue.resolveComponent("el-input"),i=Vue.resolveComponent("el-scrollbar"),p=Vue.resolveComponent("el-main"),f=Vue.resolveComponent("el-dialog");return Vue.openBlock(),Vue.createElementBlock("div",null,[Vue.createVNode(r,{modelValue:n.value,disabled:""},{prepend:Vue.withCtx(()=>[Vue.createElementVNode("i",{style:{"line-height":"1"},class:Vue.normalizeClass(["iconfont",n.value])},null,2)]),append:Vue.withCtx(()=>[Vue.createVNode(s,{class:"el-icon-search",onClick:u.openIconList},null,8,["onClick"])]),_:1},8,["modelValue"]),Vue.createVNode(f,{title:"选择图标",modelValue:t.dialogVisible,"onUpdate:modelValue":o[1]||(o[1]=c=>t.dialogVisible=c),width:"80%",class:"ms-Icons","close-on-click-modal":!1,"append-to-body":""},{footer:Vue.withCtx(()=>[Vue.createElementVNode("div",null,[Vue.createVNode(s,{size:"default",onClick:o[0]||(o[0]=c=>t.dialogVisible=!1)},{default:Vue.withCtx(()=>[Vue.createTextVNode("取 消")]),_:1}),Vue.createVNode(s,{size:"default",type:"primary",onClick:u.select},{default:Vue.withCtx(()=>[Vue.createTextVNode("确 定")]),_:1},8,["onClick"])])]),default:Vue.withCtx(()=>[Vue.createVNode(p,null,{default:Vue.withCtx(()=>[Vue.createVNode(i,{style:{height:"100%"}},{default:Vue.withCtx(()=>[Vue.createElementVNode("div",_hoisted_1$2,[(Vue.openBlock(!0),Vue.createElementBlock(Vue.Fragment,null,Vue.renderList(t.icons,(c,m)=>(Vue.openBlock(),Vue.createElementBlock("div",{key:m,class:Vue.normalizeClass(t.mark==m?"select":""),onClick:_=>u.selected(c.font_class,m)},[Vue.createElementVNode("i",{class:Vue.normalizeClass(["iconfont","icon-"+c.font_class])},null,2),Vue.createTextVNode("icon-"+Vue.toDisplayString(c.font_class),1)],10,_hoisted_2$1))),128))])]),_:1})]),_:1})]),_:1},8,["modelValue"])])}const MsIcon=_export_sfc(_sfc_main$2,[["render",_sfc_render$2],["__scopeId","data-v-15364228"]]),msMdiyForm_vue_vue_type_style_index_0_scoped_fd54ea7e_lang="",_sfc_main$1={props:{modelId:String,id:String,type:"",disabled:!1},name:"ms-mdiy-form",data:function(){return{loading:!1,modelComp:null,searchJson:null,mdiyForm:{update:{url:ms.manager+"/mdiy/form/data/update.do",params:{}},save:{url:ms.manager+"/mdiy/form/data/save.do",params:{}},get:{url:ms.manager+"/mdiy/form/data/getData.do",params:{}}},mdiyConfig:{update:{url:ms.manager+"/mdiy/config/data/update.do",params:{}},save:{url:ms.manager+"/mdiy/config/data/update.do",params:{}},get:{url:ms.manager+"/mdiy/config/data/get.do",params:{}}},mdiyModel:{update:{url:ms.manager+"/mdiy/model/data/update.do",params:{}},save:{url:ms.manager+"/mdiy/model/data/save.do",params:{}},get:{url:ms.manager+"/mdiy/model/data.do",params:{}}},mdiyTag:{update:{url:ms.manager+"/mdiy/tag/globalTag/update.do",params:{}},save:{url:ms.manager+"/mdiy/tag/globalTag/update.do",params:{}},get:{url:ms.manager+"/mdiy/tag/globalTag/get.do",params:{}}},qa:{update:{url:ms.manager+"/qa/data/update.do",params:{}},save:{url:ms.manager+"/qa/data/save.do",params:{}},get:{url:ms.manager+"/qa/data/getData.do",params:{}}},formURL:null}},watch:{modelId:function(t){debugger;this.render()}},methods:{getForm:function(){return this.$refs.form},render:function(){let that=this;that.loading=!0;let getUrl="/mdiy/form/get.do";that.type==="form"?this.formURL=this.mdiyForm:that.type==="config"?(this.formURL=this.mdiyConfig,getUrl="/mdiy/config/get.do"):that.type==="model"?(this.formURL=this.mdiyModel,getUrl="/mdiy/model/get.do"):that.type==="tag"?(this.formURL=this.mdiyTag,getUrl="/mdiy/tag/globalTag/getModel.do"):that.type==="qa"&&(this.formURL=this.qa,getUrl="/qa/qa/get.do");const render=t=>{try{const o={moduleCache:{vue:Vue__namespace},async getFile(){return t},addStyle(l){const d=Object.assign(document.createElement("style"),{textContent:l}),u=document.head.getElementsByTagName("style")[0]||null;document.head.insertBefore(d,u)}},n=Vue.defineAsyncComponent(()=>vue3SfcLoader.loadModule("modelComp.vue",o));that.modelComp=Vue.shallowRef(n),that.loading=!1}catch(o){console.error(o)}};ms.http.get(ms.manager+getUrl,{id:this.modelId}).then(function(res){if(res.result&&res.data){var data=JSON.parse(res.data.modelJson);that.searchJson=eval(data.searchJson);var data=JSON.parse(res.data.modelJson),html=data.html,script="";data.script&&(script="<script>"+data.script.replace(`\r
});\r
`,`\r
}`)+"<\/script>");let code=html+script;code=code.replace('var custom_model = Vue.component("custom-model",{',"export default{"),code=code.replace("el: '#custom-model',",""),that.formURL.get.params=Object.assign({id:that.id,linkId:that.id},that.formURL.get.params),!that.id&&that.type!="config"&&(code=code.replace("that.get();","")),code=code.replace(/\}\);\s*<\/script>/,"};<\/script>"),code=code.replace("save:function(callback) {","save:function(callback) { debugger;"),code=code.replace("modelId:0,","formURL:"+JSON.stringify(that.formURL)+`,
 modelId:'`+res.data.id+"',"),that.disabled&&(code=code.replace("disabled:false,","disabled:"+that.disabled+",")),window.ms.debug&&console.log(code),render(code)}else console.log(res),alert(res.msg)})}},created:function(){this.render()}},_hoisted_1$1={style:{height:"100%"}};function _sfc_render$1(t,o,n,l,d,u){const s=Vue.resolveDirective("loading");return Vue.withDirectives((Vue.openBlock(),Vue.createElementBlock("div",_hoisted_1$1,[(Vue.openBlock(),Vue.createBlock(Vue.resolveDynamicComponent(t.modelComp),{ref:"form"},null,512))])),[[s,t.loading]])}const MsMdiyForm=_export_sfc(_sfc_main$1,[["render",_sfc_render$1],["__scopeId","data-v-fd54ea7e"]]),msSearch_vue_vue_type_style_index_0_scoped_45bdb999_lang="",_sfc_main={name:"ms-search",props:{searchJson:{type:Array,default:[]},searchKey:{type:String}},data:function(){return{visible:!1,list:[]}},methods:{delField:function(t){this.list.splice(t,1)},select:function(t){this.list.push(Object.assign({},this.searchJson[t],{value:this.searchJson[t].type=="switch"?!1:""}))},dateChange:function(t){t.el==="range"?t.value=[]:t.value=""},search:function(){var t=this;this.visible=!1;var o=[];JSON.parse(JSON.stringify(t.list)).forEach(function(l){l.type=="province_id"&&l.attachFields.length>0&&l.attachFields.forEach((d,u)=>{o.push({action:"and",field:d,el:"eq",value:l.value[u+1]})}),l.el==="range"?l.value.length&&o.push(x):l.value&&(Array.isArray(l.value)&&(l.value=l.value[0]),o.push(l))}),t.$emit("search",o)},save:function(){}}},_hoisted_1={key:3},_hoisted_2={class:"dialog-footer"};function _sfc_render(t,o,n,l,d,u){const s=Vue.resolveComponent("el-button"),r=Vue.resolveComponent("el-option"),i=Vue.resolveComponent("el-select"),p=Vue.resolveComponent("el-form-item"),f=Vue.resolveComponent("el-form"),c=Vue.resolveComponent("el-scrollbar"),m=Vue.resolveComponent("el-col"),_=Vue.resolveComponent("el-row"),V=Vue.resolveComponent("el-table-column"),v=Vue.resolveComponent("el-input"),y=Vue.resolveComponent("el-switch"),h=Vue.resolveComponent("el-time-picker"),g=Vue.resolveComponent("el-date-picker"),w=Vue.resolveComponent("el-cascader"),k=Vue.resolveComponent("el-link"),C=Vue.resolveComponent("el-table"),b=Vue.resolveComponent("el-dialog");return Vue.openBlock(),Vue.createElementBlock("div",null,[Vue.createVNode(s,{type:"primary",class:"el-icon-s-operation",size:"default",onClick:o[0]||(o[0]=e=>t.visible=!0)},{default:Vue.withCtx(()=>[Vue.createTextVNode("筛选")]),_:1}),Vue.createVNode(b,{id:"search",title:"筛选",modelValue:t.visible,"onUpdate:modelValue":o[1]||(o[1]=e=>t.visible=e),"close-on-click-modal":!1,width:"40%"},{footer:Vue.withCtx(()=>[Vue.createElementVNode("span",_hoisted_2,[Vue.createVNode(s,{type:"primary",size:"default",onClick:u.search},{default:Vue.withCtx(()=>[Vue.createTextVNode("查询")]),_:1},8,["onClick"])])]),default:Vue.withCtx(()=>[Vue.createVNode(_,null,{default:Vue.withCtx(()=>[Vue.createVNode(m,{span:24},{default:Vue.withCtx(()=>[Vue.createVNode(c,{class:"ms-scrollbar",style:{height:"100%"}},{default:Vue.withCtx(()=>[Vue.createVNode(f,{"label-width":"120px",size:"default"},{default:Vue.withCtx(()=>[Vue.createVNode(p,{label:"添加筛选条件:"},{default:Vue.withCtx(()=>[Vue.createVNode(i,{onChange:u.select},{default:Vue.withCtx(()=>[(Vue.openBlock(!0),Vue.createElementBlock(Vue.Fragment,null,Vue.renderList(n.searchJson,(e,a)=>(Vue.openBlock(),Vue.createBlock(r,{key:e.index,value:a,label:e.name},null,8,["value","label"]))),128))]),_:1},8,["onChange"])]),_:1})]),_:1})]),_:1})]),_:1})]),_:1}),Vue.createVNode(C,{size:"default","show-header":!1,data:t.list,style:{width:"100%"}},{default:Vue.withCtx(()=>[Vue.createVNode(V,{prop:"name",width:"110"}),Vue.createVNode(V,{width:"130"},{default:Vue.withCtx(e=>[e.row.type=="input"||e.row.type=="textarea"?(Vue.openBlock(),Vue.createBlock(i,{key:0,modelValue:e.row.el,"onUpdate:modelValue":a=>e.row.el=a,size:"default"},{default:Vue.withCtx(()=>[Vue.createVNode(r,{label:"等于",value:"eq"}),Vue.createVNode(r,{label:"包含",value:"like"}),Vue.createVNode(r,{label:"左等于",value:"likeLeft"}),Vue.createVNode(r,{label:"右等于",value:"likeRight"})]),_:2},1032,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0),e.row.type=="number"?(Vue.openBlock(),Vue.createBlock(i,{key:1,modelValue:e.row.el,"onUpdate:modelValue":a=>e.row.el=a,size:"default"},{default:Vue.withCtx(()=>[Vue.createVNode(r,{label:"大于",value:"gt"}),Vue.createVNode(r,{label:"小于",value:"lt"}),Vue.createVNode(r,{label:"等于",value:"eq"}),Vue.createVNode(r,{label:"大于等于",value:"gte"}),Vue.createVNode(r,{label:"小于等于",value:"lte"})]),_:2},1032,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0),e.row.type=="date"||e.row.type=="time"?(Vue.openBlock(),Vue.createBlock(i,{key:2,modelValue:e.row.el,"onUpdate:modelValue":a=>e.row.el=a,size:"default",onChange:a=>u.dateChange(e.row)},{default:Vue.withCtx(()=>[Vue.createVNode(r,{label:"大于",value:"gt"}),Vue.createVNode(r,{label:"等于",value:"eq"}),Vue.createVNode(r,{label:"小于",value:"lt"}),Vue.createVNode(r,{label:"范围",value:"range"})]),_:2},1032,["modelValue","onUpdate:modelValue","onChange"])):Vue.createCommentVNode("",!0),e.row.hasOwnProperty("multiple")||e.row.type=="switch"||e.row.type=="role"||e.row.type=="province_id"?(Vue.openBlock(),Vue.createElementBlock("span",_hoisted_1,"是")):Vue.createCommentVNode("",!0)]),_:1}),Vue.createVNode(V,null,{default:Vue.withCtx(e=>[e.row.type=="input"||e.row.type=="number"||e.row.type=="textarea"?(Vue.openBlock(),Vue.createBlock(v,{key:0,style:{width:"200px"},modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a,size:"default"},null,8,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0),e.row.hasOwnProperty("multiple")?(Vue.openBlock(),Vue.createBlock(i,{key:1,style:{width:"200px"},modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a,size:"default"},{default:Vue.withCtx(()=>[(Vue.openBlock(!0),Vue.createElementBlock(Vue.Fragment,null,Vue.renderList(t.$parent[e.row.model+"Options"],a=>(Vue.openBlock(),Vue.createBlock(r,{key:a[e.row.key],value:a[e.row.key],label:a[e.row.title]},null,8,["value","label"]))),128))]),_:2},1032,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0),e.row.type=="switch"?(Vue.openBlock(),Vue.createBlock(y,{key:2,modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a},null,8,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0),e.row.type=="time"?(Vue.openBlock(),Vue.createElementBlock(Vue.Fragment,{key:3},[e.row.el=="range"?(Vue.openBlock(),Vue.createBlock(h,{key:0,size:"default",clearable:"","is-range":"","value-format":"HH:mm:ss","range-separator":"至","start-placeholder":"请选择开始时间","end-placeholder":"请选择结束时间",modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a},null,8,["modelValue","onUpdate:modelValue"])):(Vue.openBlock(),Vue.createBlock(h,{key:1,size:"default",clearable:"","value-format":"HH:mm:ss",modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a},null,8,["modelValue","onUpdate:modelValue"]))],64)):Vue.createCommentVNode("",!0),e.row.type=="date"?(Vue.openBlock(),Vue.createElementBlock(Vue.Fragment,{key:4},[e.row.el=="range"?(Vue.openBlock(),Vue.createBlock(g,{key:0,size:"default",modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a,type:"datetimerange","value-format":"yyyy-MM-dd HH:mm:ss","start-placeholder":"请选择开始日期","end-placeholder":"请选择结束日期"},null,8,["modelValue","onUpdate:modelValue"])):(Vue.openBlock(),Vue.createBlock(g,{key:1,size:"default",clearable:"","value-format":"yyyy-MM-dd HH:mm:ss",modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a},null,8,["modelValue","onUpdate:modelValue"]))],64)):Vue.createCommentVNode("",!0),e.row.type=="province_id"?(Vue.openBlock(),Vue.createBlock(w,{key:5,modelValue:e.row.value,"onUpdate:modelValue":a=>e.row.value=a,props:t.$parent.$parent.$refs.modelForm.$refs.form[e.row.model+"Props"]},null,8,["modelValue","onUpdate:modelValue","props"])):Vue.createCommentVNode("",!0)]),_:1}),Vue.createVNode(V,{align:"center",width:"130"},{default:Vue.withCtx(e=>[e.$index!=t.list.length-1?(Vue.openBlock(),Vue.createBlock(i,{key:0,modelValue:e.row.action,"onUpdate:modelValue":a=>e.row.action=a,size:"default"},{default:Vue.withCtx(()=>[Vue.createVNode(r,{label:"与",value:"and"}),Vue.createVNode(r,{label:"或",value:"or"})]),_:2},1032,["modelValue","onUpdate:modelValue"])):Vue.createCommentVNode("",!0)]),_:1}),Vue.createVNode(V,{align:"center",width:"60"},{default:Vue.withCtx(e=>[Vue.createVNode(k,{type:"primary",underline:!1,onClick:a=>u.delField(e.$index)},{default:Vue.withCtx(()=>[Vue.createTextVNode("删除")]),_:2},1032,["onClick"])]),_:1})]),_:1},8,["data"])]),_:1},8,["modelValue"])])}const MsSearch=_export_sfc(_sfc_main,[["render",_sfc_render],["__scopeId","data-v-45bdb999"]]),components=[MsIcon,MsMdiyForm,MsSearch],install=(t,o)=>{components.forEach(n=>{n.install=l=>{l.component(n.name,n),o&&o.debug&&console.log("注册",n.name)},t.use((n.name,n))})},index={install};exports.MsIcon=MsIcon,exports.MsMdiyForm=MsMdiyForm,exports.MsSearch=MsSearch,exports.default=index,exports.install=install,Object.defineProperties(exports,{__esModule:{value:!0},[Symbol.toStringTag]:{value:"Module"}})});
