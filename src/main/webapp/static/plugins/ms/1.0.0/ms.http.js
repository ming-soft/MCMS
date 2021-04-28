/**
 * 封装http请求
 */
(function () {

    axios.defaults.timeout = 1000 * 60;
    axios.defaults.baseURL = '';

    //http request 拦截器
    axios.interceptors.request.use(
        function (config) {
            config.headers = {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'X-Requested-With': 'XMLHttpRequest'
            }
            if (config.method === 'post' && config.headers["Content-Type"] === "application/x-www-form-urlencoded") {
                config.data = Qs.stringify(config.data, {
                    allowDots: true
                });
            }
            return config;
        },
        function (error) {
            return Promise.reject(error);
        }
    );


    //http response 拦截器
    axios.interceptors.response.use(
        function (response) {
            return response;
        },
        function (error) {
            if (error.response) {
                let msg;
                if (error.response.status == 401) {
                    msg = "登录失败";
                } else if (error.response.status == 400) {
                    msg = "客户端错误";
                } else if (error.response.status == 403) {
                    msg = "您的权限不足";
                } else if (error.response.status == 404) {
                    msg = "请求不存在";
                } else if (error.response.status == 423) {
                    msg = "账号被锁定！";
                } else if (error.response.status == 500) {
                    msg = "服务器异常";

                } else if (error.response.status == 501) {
                    msg = "您的操作被取消或不允许提交";
                } else if (error.response.status == 423) {
                    msg = "服务器正在开小差....";
                }
                if(error.response.data && error.response.data.msg) {
                    msg = error.response.data.msg;
                }
                if (msg) {
                    var tempVue = document.createElement('div');
                    tempVue.id = "tempVue";
                    document.body.appendChild(tempVue)
                    new Vue({el: '#tempVue',}).$notify.error({
                        title: '错误',
                        message: msg,
                        type: 'warning'
                    });
                    if (error.response.status == 401) {
                        window.location.reload();
                    }
                    document.body.removeChild(tempVue);
                }

            }

            return Promise.reject(error)
        }
    )

    function ajax(conf) {
        if (conf != undefined) {
            var _axios = axios.create({
                baseURL: conf.baseURL == undefined ? axios.defaults.baseURL : conf.baseURL,
                timeout: conf.timeout == undefined ? axios.defaults.timeout : conf.timeout,
                headers: conf.headers == undefined ? null : conf.headers,
            });
            _axios.interceptors.request.use(
                function (config) {
                    if (config.method === 'post' && config.headers["Content-Type"] === "application/x-www-form-urlencoded") {
                        config.data = Qs.stringify(config.data, {
                            allowDots: true
                        });
                    }
                    return config;
                },
                function (error) {
                    return Promise.reject(error);
                }
            );
            return _axios;
        }
        return axios;
    }


    /**
     * 封装get方法
     * @param url
     * @param data
     * @returns {Promise}
     */

    function get(url, params) {
        if (params == undefined) {
            params = {}
        }
        return new Promise(function (resolve, reject) {
            ajax().get(url, {
                params: params
            })
                .then(function (response) {
                    resolve(response.data);
                })
                .catch(function (err) {
                    reject(err)
                })
        })
    }


    /**
     * 封装post请求
     * @param url
     * @param data
     * @returns {Promise}
     */

    function post(url, data, conf) {

        if (data == undefined) {
            data = {}
        }

        return new Promise(function (resolve, reject) {
            ajax(conf).post(url, data, conf)
                .then(function (response) {
                    resolve(response.data);
                }, function (err) {
                    reject(err)
                })
        })
    }

    /**
     * 封装patch请求
     * @param url
     * @param data
     * @returns {Promise}
     */

    function patch(url, data, conf) {

        if (data == undefined) {
            data = {}
        }
        return new Promise(function (resolve, reject) {
            ajax(conf).patch(url, data, conf)
                .then(function (response) {
                    resolve(response);
                }, function (err) {
                    reject(err)
                })
        })
    }

    /**
     * 封装put请求
     * @param url
     * @param data
     * @returns {Promise}
     */
    function put(url, data, conf) {

        if (data == undefined) {
            data = {}
        }
        return new Promise(function (resolve, reject) {
            ajax(conf).put(url, data, conf)
                .then(function (response) {
                    resolve(response.data);
                }, function (err) {
                    reject(err)
                })
        })
    }

    /**
     * 下载资源
     * @param url
     * @param data
     * @returns {Promise}
     */
    function download(url, data) {

        if (data == undefined) {
            data = {}
        }

        return new Promise(function (resolve, reject) {
            axios({
                method: 'post',
                // 请求地址
                url: url,
                // 参数
                data: data,
                // 表明返回服务器返回的数据类型
                responseType: 'blob',
                headers: {Accept: 'application/vnd.openxmlformats-officedocument'}
            }).then((res) => { // 处理返回的文件流
                const content = res.data
                const blob = new Blob([content])
                const fileName = res.headers["filename"];
                if ('download' in document.createElement('a')) { // 非IE下载
                    const elink = document.createElement('a')
                    elink.download = fileName
                    elink.style.display = 'none'
                    elink.href = URL.createObjectURL(blob)
                    document.body.appendChild(elink)
                    elink.click()
                    URL.revokeObjectURL(elink.href) // 释放URL 对象
                    document.body.removeChild(elink)
                } else { // IE10+下载
                    navigator.msSaveBlob(blob, fileName)
                }
                resolve(res);
            }, function (err) {
                reject(err)
            })

        })
    }


    var http = {
        get: get,
        post: post,
        put: put,
        patch: patch,
        download: download

    }

    if (typeof ms != "object") {
        window.ms = {};
    }
    window.ms.http = http;
    window.ms.isLoginRedirect = true;
}());
