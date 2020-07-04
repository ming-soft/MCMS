/**
 * 字典
 * 初始化：ms.dict.list("A类型,B类型,C类型","子业务类型")
 * 获取值：ms.dict.getDictValue("A类型标签") ；ms.dict.getDictValue("C类型标签",3)
 * 获取值：ms.dict.getDictLabel("B类型值",2)
 */
(function() {

    var dictData;

    /**
     *  获取所有字典类型的数组集合
     * @param dictType 字典类型 支持多个类型用英文逗号隔开
     * @param isChild 子业务类型 可选
     */
    function list(dictType,isChild) {
        var _dict={
            dictType:dictType,
            isChild:isChild,
        }
        ms.http.get(ms.manager+'/mdiy/dict/dictList.do', _dict).then(function (res) {
            if(res.code==200){
                dict.dictData = res.data;
            }
        }).catch(function (err) {
            console.log(err);
        });
    }
    function get(index, dictLabel, dictValue,isChild){
        var dicts= (dict.dictData?dict.dictData[index-1]:[]).filter(function(element,index,self){
            if(dictLabel&&dictLabel!=element.dictLabel){
                return false
            }else  if(dictValue&&dictValue!=element.dictValue){
                return false
            }
            return true
        })
        if(dicts.length){
            return dicts[0];
        }else {
            return null;
        }
    }

    /**
     *  获取字典列表
     * @param index list方法中dictType的索引值 从1开始
     * @returns {*}
     */
    function getList(index){
        if(index){
            return dict.dictData[0]
        }else {
            return dict.dictData[index-1]
        }

    }

    /**
     *  获取字典值
     * @param dictLabel 字典标签值
     * @param index list方法中dictType的索引值 从1开始
     * @param defaultValue 默认值
     * @returns {string|string|rules.dictValue|{message, required}}
     */
    function getDictValue( dictLabel, index, defaultValue) {
        if (!defaultValue) {
            defaultValue="";
        }
        var dictEntity = ''
        if (index && dictLabel) {
            dictEntity = get(index, dictLabel, null);
        }
        if (!index && dictLabel) {
            dictEntity = get(1, dictLabel, null);
        }
        if(dictEntity){
            return dictEntity.dictValue;
        }
        return defaultValue;
    }

    /**
     * 获取字典标签
     * @param dictValue 字典值
     * @param index list方法中dictType的索引值 从1开始
     * @param defaultValue 默认值
     * @returns {string|string|rules.dictLabel|{message, required}|data.mdiyFormRule.dictLabel|{trigger, message, required}}
     */
    function getDictLabel( dictValue, index, defaultValue) {
        if (!defaultValue) {
            defaultValue = "";
        }
        var dictEntity = ''
        if(!index && dictValue){
            dictEntity = get(1,"", dictValue, null);
        }
        if (index && dictValue) {
            dictEntity = get(index,"", dictValue, null);
        }
        if(dictEntity){
            return dictEntity.dictLabel;
        }
        return defaultValue;
    }

    var dict = {
        list: list,
        dictData: dictData,
        getList:getList,
        getDictValue:getDictValue,
        getDictLabel:getDictLabel,
    }

    if (typeof ms != "object") {
        window.ms = {};
    }
    window.ms.dict = dict;
}());
