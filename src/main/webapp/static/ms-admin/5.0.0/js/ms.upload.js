/**
 * 上传js
 * 官方插件文档：https://www.plupload.com
 * 参数方法文档：https://www.cnblogs.com/2050/p/3913184.html
 */
(function() {

  

    // 默认支持上传的文件类型
    var mimeTypes = {
        "image": {
            title: "Image files",
            extensions: "jpg,JPG,jpeg,PNG,gif,png"
        },
        "file": {
            title: "Zip files",
            extensions: "ZIP,zip,DOC,doc,docx,xls,XLS,xlsx,RAR,rar"
        },
        "video": {
            title: "video files",
            extensions: "MP3,MP4"
        },
        "all": {
            title: "all files",
            extensions: "jpg,JPG,jpeg,PNG,gif,png,ZIP,zip,DOC,doc,docx,xls,XLS,xlsx,RAR,rar"
        }
    };

    /**
     * 文件上传

     * id: id属性
     * {
     * url:"", //(可选)默认ms.base + "/file/upload.do" 
     * mime_types:"image", //(可选)默认图片，支持image、file、video、all(表示包含前三种)，也可以设置allowedFile参数覆盖
     * allowedFile:""//(可选)自定义上传文件后缀例如：jpg,gif
     * max_file_size:"1mb", //(可选)默认1mb,单位kb,mb,gb,tb，注意后端ms.properties文件也有配置上传大小，优先上传控件大小 
     * multi_selection:false, //(可选)默认单文件 
     * uploadPath:"", //(可选)默认上传upload文件夹下面(如果非upload，需要设置uploadFloderPath参数)对应的站点下面，例如uload/1/xxxxx.jpg 
     * uploadFloderPath:"", //(可选)自定义上传文件夹路径，最终文件路径格式 uploadFloderPath/uploadPath/xxxxxx.jpg,注意这里的uploadPath已经没有了upload文件夹与站点id
     * diyPath:"", //(可选)自定义上传文件夹路径，可以定义盘符路径
     * isRename:true,//(可选)文件重命名,默认根据时间命名
     * fileFiltered:function //每次选择一个文件都会触发
     * filesAdded:function //每次选择好文件后都会触发
     * beforeUpload:function //上传文件之前触发，确认上传 业务的情况下有用
     * uploadProgress:function //处理进度条
     * fileUploaded:function //（必填）上传成功返回，主要会用到第三个参数的response，这个值是上传成功后返回的数据
     * }
     */
    function upload(id, cfg) { 
        var uploadCfg = {
            url: basePath+"/file/upload.do",
            mime_types: mimeTypes["image"],
            max_file_size: "1mb",
            multi_selection: false,
            uploadPath: "",
            diyPath:"",
            uploadFloderPath: "",
            chunk: "",
            chunks: "",
            prevent_duplicates: true,
            isRename: true, 
            fileFiltered: function(uploader, file) {},
            filesAdded: function(uploader, files) {},
            beforeUpload: function(uploader, file) {},
            uploadProgress: function(uploader, file) {},
            fileUploaded: function(uploader, file, responseObject) {},

            error: function(uploader, errObject) {
                if (errObject.code == -600) {
                	 $('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "文件超过" +
	                        uploadCfg.max_file_size + "大小" }
					 }).show();	
                } else if (errObject.code == -601) {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "格式错误" }
					 }).show();	
                } else if (errObject.code == -700) {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "格式错误"}
					 }).show();	
                } else if (errObject.code == -300) {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "发生磁盘读写错误时的错误代码，例如本地上某个文件不可读"}
					 }).show();	
                } else if (errObject.code == -602) {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "文件已上传过，不能重复上传。"}
					 }).show();	
                } else if (errObject.code == -702) {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.file.name + "文件网页上传不支持，太大的文件请通过其他途径上传。"}
					 }).show();	
                } else {
                	$('.ms-notifications').offset({top:43}).notify({
		    		    type:'warning',
					    message: { text:errObject.code + errObject.file.name}
					 }).show();	
                }
            },
        };
        var multipart_params = {}; // 上传表单参数
        multipart_params.maxSize = calculationMaxSize();
        multipart_params.allowedFile = uploadCfg.mime_types.extensions;

        // 判断cfg是否为json格式，不是则将默认参数传给cfg
        if (cfg != undefined && validator.isJSON(JSON.stringify(cfg))) {

            // 重新定义后台上传路径
            if (cfg.url != undefined && cfg.url != "") {
                uploadCfg.url = cfg.url;
            }
            // 允许上传的后缀
            if (cfg.allowedFile != undefined && cfg.allowedFile != "") {
            	uploadCfg.mime_types = 
                    {
                        title: "all files",
                        extensions: cfg.allowedFile
                    };
                multipart_params.allowedFile = cfg.allowedFile;
            }

            //组织后台需要的参数
            if (cfg.max_file_size != undefined && cfg.max_file_size != "") {
                uploadCfg.max_file_size = cfg.max_file_size;
                multipart_params.maxSize = calculationMaxSize();
            }

            if (cfg.path != undefined && cfg.path != "") {
                uploadCfg.uploadPath = cfg.path;
                multipart_params.uploadPath = cfg.path;
            }
            if (cfg.diyPath != undefined && cfg.diyPath != "") {
            	uploadCfg.diyPath = cfg.diyPath;
            	multipart_params.diyPath = cfg.diyPath;
            }
            if (cfg.uploadFloderPath != undefined && cfg.uploadFloderPath != "") {
                uploadCfg.uploadFloderPath = cfg.uploadFloderPath;
                multipart_params.uploadFloderPath = cfg.uploadFloderPath;
            }
            if (cfg.chunk != undefined && cfg.chunk != "") {
                multipart_params.chunk = cfg.chunk;
            }
            if (cfg.chunks != undefined && cfg.chunks != "") {
                multipart_params.chunks = cfg.chunks;
            }

            if (cfg.name != undefined && cfg.name != "") {
                multipart_params.name = cfg.name;
            }

            if (cfg.isRename != undefined) {
                multipart_params.isRename = cfg.isRename;
            }

            if (cfg.multi_selection != undefined ) {
                uploadCfg.multi_selection = cfg.multi_selection;
            }
            if (cfg.prevent_duplicates != undefined) {
            	uploadCfg.prevent_duplicates = cfg.prevent_duplicates;
            }


            //回调事件
            if (cfg.fileUploaded != undefined && cfg.fileUploaded != "") {
                uploadCfg.fileUploaded = cfg.fileUploaded;
            }
            if (cfg.filesAdded != undefined && cfg.filesAdded != "") {
                uploadCfg.filesAdded = cfg.filesAdded;
            }
            if (cfg.fileFiltered != undefined && cfg.fileFiltered != "") {
                uploadCfg.fileFiltered = cfg.fileFiltered;
            }
            if (cfg.beforeUpload != undefined && cfg.beforeUpload != "") {
                uploadCfg.beforeUpload = cfg.beforeUpload;
            }
            if (cfg.uploadProgress != undefined && cfg.uploadProgress != "") {
                uploadCfg.uploadProgress = cfg.uploadProgress;
            }
            if (cfg.error != undefined && cfg.error != "") {
                uploadCfg.error = cfg.error;
            }
           
        }

        // 实例化一个plupload上传对象
        var uploader = new plupload.Uploader({
            browse_button: id, // 预览按钮元素
            url: uploadCfg.url, // 上传地址
            flash_swf_url: 'js/Moxie.swf',
            silverlight_xap_url: 'js/Moxie.xap',
            multi_selection: uploadCfg.multi_selection, // 禁止浏览框多选
            multipart_params: multipart_params,
            filters: { // 文件类型 大小设置,对不同场景的文件上传配置此参数
                mime_types: [uploadCfg.mime_types],
                max_file_size: uploadCfg.max_file_size, // 最大只能上传400kb的文件
                prevent_duplicates: uploadCfg.prevent_duplicates //布尔类型
                // 不允许选取重复文件
            },
        });

        uploader.init();

        /**
         * 选择了多少文件就会触发多少次
         *uploader为当前的plupload实例对象，file为触发此事件的文件对象
         */
        uploader.bind('FileFiltered', function(uploader, file) {
            eval(uploadCfg.fileFiltered(uploader, file));
        });

        /**
         * 当文件添加到上传队列后触发
         * uploader为当前的plupload实例对象，files为一个数组，里面的元素为本次添加到上传队列里的文件对象
         * 每一次选择文件都会触发，不管选择多个文件还是单个文件都只会触发一次
         */
        uploader.bind('FilesAdded', function(uploader, files) {
            eval(uploadCfg.filesAdded(uploader, files));
        });

        /** 
         * 当队列中的某一个文件正要开始上传前触发
         * uploader为当前的plupload实例对象，file为触发此事件的文件对象
         */
        uploader.bind('BeforeUpload', function(uploader, file) {
            eval(uploadCfg.beforeUpload(uploader, file));
        });

        /**
         * 会在文件上传过程中不断触发，可以用此事件来显示上传进度
         * uploader为当前的plupload实例对象，file为触发此事件的文件对象
         */
        uploader.bind('UploadProgress', function(uploader, file) {
            eval(uploadCfg.uploadProgress(uploader, file));
        });

        /**
         * 当队列中的某一个文件上传完成后触发监听函数参数：(uploader,file,responseObject)
         * uploader为当前的plupload实例对象，
         * file为触发此事件的文件对象，
         * responseObject为服务器返回的信息对象，它有以下3个属性：
         *    response：服务器返回的文本
         *    responseHeaders：服务器返回的头信息
         *    status：服务器返回的http状态码，比如200
         */
        uploader.bind('FileUploaded', function(uploader, file, responseObject) {
            eval(uploadCfg.fileUploaded(uploader, file, responseObject));
        });

        /**        
         * 当发生错误时触发监听函数参数：(uploader,errObject)
         * uploader为当前的plupload实例对象，
         * errObject为错误对象，它至少包含以下3个属性(因为不同类型的错误，属性可能会不同)：
         * code：错误代码，具体请参考plupload上定义的表示错误代码的常量属性
         * file：与该错误相关的文件对象
         * message：错误信息
         */
        uploader.bind('Error', function(uploader, errObject) {
            eval(uploadCfg.error(uploader, errObject));
        });

        /**
         * 计算后台的上传大小，因为前端上传空间与后端的大小单位不一致
         */
        function calculationMaxSize() {
            var size = parseInt(uploadCfg.max_file_size);

            if (uploadCfg.max_file_size.indexOf("kb") > -1) {
                return parseInt(size) / 1024;
            } else if (uploadCfg.max_file_size.indexOf("mb") > -1) {
                return size;
            } else if (uploadCfg.max_file_size.indexOf("gb") > -1) {
                return size * 1024;
            } else if (uploadCfg.max_file_size.indexOf("tb") > -1) {
                return size * 1024 * 1024;
            }
        }
        return uploader;

    }

    if (ms == undefined) {
        ms = {};
    }

    window.ms.upload = upload;
}());