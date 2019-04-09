(function() {

    axios.defaults.timeout = 1000 * 60;
    axios.defaults.baseURL = ''; 

    //http request 拦截器
    axios.interceptors.request.use(

        function(config) {
            config.headers = {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            }
            if (config.method === 'post' && config.headers["Content-Type"] === "application/x-www-form-urlencoded") {
                config.data = Qs.stringify(config.data, {
                    allowDots: true
                });
            }
            return config;
        },
        function(error) {
            return Promise.reject(err);
        }
    );


    //http response 拦截器
    axios.interceptors.response.use(
        function(response) {
            //登录失效
            if (response.data.bizCode == "401") {
                window.parent.location.href = ms.base + "/" + ms.login + "?backurl=" + encodeURIComponent(window.parent.location.href);
                return;
            }
            return response;
        },
        function(error) {
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
                function(config) {
                    if (config.method === 'post' && config.headers["Content-Type"] === "application/x-www-form-urlencoded") {
                        config.data = Qs.stringify(config.data, {
                            allowDots: true
                        });
                    }
                    return config;
                },
                function(error) {
                    return Promise.reject(err);
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
        return new Promise(function(resolve, reject) {
            ajax().get(url, {
                    params: params
                })
                .then(function(response) {
                    resolve(response.data);
                })
                .catch(function(err) {
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

        return new Promise(function(resolve, reject) {
            ajax(conf).post(url, data, conf)
                .then(function(response) {
                    resolve(response.data);
                }, function(err) {
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
        return new Promise(function(resolve, reject) {
            ajax(conf).patch(url, data, conf)
                .then(function(response) {
                    resolve(response);
                }, function(err) {
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
        return new Promise(function(resolve, reject) {
            ajax(conf).put(url, data, conf)
                .then(function(response) {
                    resolve(response.data);
                }, function(err) {
                    reject(err)
                })
        })
    }


    var http = {
        get: get,
        post: post,
        put: put,
        patch: patch

    }

    if (typeof ms != "object") {
        window.ms = {};
    }
    window.ms.http = http;
}());