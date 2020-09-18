<#list localMessages as item>
    <script src="${base}/static/locale/lang/${modeldir}/${item}.js"></script>
</#list>
<script>
    (function(window) {
        var defaultLocal = '${localDefault}'  //默认语言

        var localeMessage = [] //添加语言
         <#list localMessages as item>
           localeMessage.push('${item}')
        </#list>
        window.indexlocale = {
            language:defaultLocal
        }
        //获取后台index的语言
        if(parent!=null&&parent.indexVue!=undefined&&parent.indexVue.locale!=undefined){
            window.indexlocale = parent.indexVue.locale
        }
        window.i18n = new VueI18n({
            locale:  window.indexlocale.language, // 设置地区
            fallbackLocale: defaultLocal,

        })
        //加载语言
        localeMessage.forEach(function (value) {
            if(window[value]!=undefined){
                var message = window[value]
                if(window['base_'+value]!=undefined){
                    message = Object.assign({},message,window['base_'+value])
                }
                i18n.setLocaleMessage(value,message)
            }
        })
        var localElement = i18n.getLocaleMessage(i18n.locale)
        if(Object.keys(localElement).indexOf("el")!=-1){
            ELEMENT.locale(localElement)
        }
    })(window);
</script>