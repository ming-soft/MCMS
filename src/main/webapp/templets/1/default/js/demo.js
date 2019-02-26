define(function(require, exports, module) {
	var ms = require("ms");
	var ajaxCfg = {
		"type": "post",
		"dataType": "json",
	};
	var mstore = "http://mstore.mingsoft.net/";//
	return {
		"version": "1.0.0",
		mstore: {
			list: function(data, func) {
				if(validator.isNull(data)) {
					return;
				}
				ajaxCfg.url = mstore + "/mstore/list.do";
				ajaxCfg.params = data;
				ms.ajax(ajaxCfg, func);
			}
		},
	}
})
