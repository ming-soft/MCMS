<#--
  SEO内链接组件
  ------------------------------------------------------------
  功能说明：
    点击按钮后，根据自定义字典「SEO内链接」中的相关词，
    自动将富文本正文中的匹配词替换为内链 <a> 标签。
    - dictLabel：相关词（正文中要匹配的关键词）
    - dictValue：内链地址（替换后 a 标签的 href）

  替换规则：
    1. 仅替换文本节点，不破坏原有 HTML 标签结构
    2. 已在 <a>、<script>、<style>、<code>、<pre> 内的文本不再替换，防止重复套链
    3. 每个相关词只替换首次出现，避免同一词反复加链，重复加链会影响SEO判断
    4. 长词优先匹配，避免短词抢占长词（如「铭飞」抢在「铭飞CMS」之前）
    5. target 自动判断：地址以 / 开头或 host 与当前页相同 → _self，否则 → _blank

  使用方式：
    1. 页面引入：<#include "/cms/component/ms-seo-inner-link.ftl">
    2. 注册组件：components: { MsSeoInnerLink }
    3. 模板中：
       <ms-seo-inner-link v-model="form.contentDetails"></ms-seo-inner-link>
-->
<template type="text/x-template" id="ms-seo-inner-link">
    <el-button type="primary"  size="small" dashed
               :loading="loading"
               @click="seoInnerLinkReplace">
        一键插入SEO内链
    </el-button>
</template>
<script>
    var MsSeoInnerLink = Vue.defineComponent({
        name: 'MsSeoInnerLink',
        template: '#ms-seo-inner-link',
        props: {
            // 富文本 HTML 内容，支持 v-model 双向绑定
            modelValue: {
                type: String,
                default: ''
            }
        },
        emits: ['update:modelValue'],
        data: function () {
            return {
                // 请求字典 / 执行替换过程中的 loading 状态
                loading: false
            };
        },
        methods: {
            /**
             * 转义正则特殊字符，避免相关词中的 . * + ? 等破坏正则
             * 注意：${'$'} 是 FreeMarker 写法，输出字面量 $，防止 FTL 把 $\\{\\} 当表达式解析
             */
            escapeRegExp: function (str) {
                return String(str).replace(/[.*+?^${'$'}{}()|[\]\\]/g, '\\${'$'}&');
            },
            /**
             * 根据链接地址自动判断打开方式
             * - 以 / 开头的站内相对路径（不含协议相对 //）：当前页打开 _self
             * - 解析后 host 与当前页面 host 相同：当前页打开 _self
             * - 其他外链：新窗口打开 _blank
             */
            linkTargetGet: function (url) {
                var href = String(url || '').trim();
                if (!href) {
                    return '_blank';
                }
                // 站内相对路径，如 /cms/about.html
                if (href.charAt(0) === '/' && href.charAt(1) !== '/') {
                    return '_self';
                }
                try {
                    var linkUrl = new URL(href, window.location.href);
                    if (linkUrl.host === window.location.host) {
                        return '_self';
                    }
                } catch (e) {
                    // 无法解析的地址按外链处理
                }
                return '_blank';
            },
            /**
             * 判断文本节点是否应跳过替换
             * 向上查找父节点，若落在 a/script/style/code/pre 内则跳过
             * （已加链的不再套链；代码块内关键词也不应加链）
             */
            isSkipTextNode: function (node) {
                var el = node.parentElement || node.parentNode;
                while (el && el.nodeType === 1) {
                    var tag = (el.tagName || '').toLowerCase();
                    if (tag === 'a' || tag === 'script' || tag === 'style' || tag === 'code' || tag === 'pre') {
                        return true;
                    }
                    el = el.parentElement || el.parentNode;
                }
                return false;
            },
            /**
             * 收集容器内所有可参与替换的文本节点
             * 使用 TreeWalker 遍历，过滤空文本和需跳过的节点
             */
            textNodeListGet: function (root) {
                var list = [];
                var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, null);
                var node = walker.nextNode();
                while (node) {
                    if (node.nodeValue && node.nodeValue.trim() && !this.isSkipTextNode(node)) {
                        list.push(node);
                    }
                    node = walker.nextNode();
                }
                return list;
            },
            /**
             * 将 HTML 正文中的相关词替换为内链
             * @param html 原始富文本 HTML
             * @param dictList 字典列表，项含 dictLabel（相关词）、dictValue（链接）
             * @return { html: 替换后的 HTML, count: 实际替换次数 }
             *
             * 采用 DOM 方式而非字符串正则直接改 HTML：
             * 避免破坏 <p> 等标签属性
             */
            contentKeywordReplace: function (html, dictList) {
                var that = this;
                if (!html || !dictList || !dictList.length) {
                    return {html: html || '', count: 0};
                }

                // 放入临时容器，基于 DOM 文本节点做替换
                var container = document.createElement('div');
                container.innerHTML = html;

                // 按相关词长度降序，长词优先，避免短词先匹配导致长词无法命中
                var sorted = dictList.slice().sort(function (a, b) {
                    return (b.dictLabel || '').length - (a.dictLabel || '').length;
                });

                var total = 0;
                sorted.forEach(function (item) {
                    var word = item.dictLabel;
                    var url = item.dictValue;
                    if (!word || !url) {
                        return;
                    }
                    var pattern = that.escapeRegExp(word);
                    // 忽略大小写
                    var re = new RegExp(pattern, 'i');;
                    // 每个词处理前重新收集文本节点（前面的替换可能已拆分节点）
                    var textNodes = that.textNodeListGet(container);

                    for (var i = 0; i < textNodes.length; i++) {
                        var textNode = textNodes[i];
                        // 节点可能已被前面替换拆掉，或父级已变成 a
                        if (!textNode.parentNode || that.isSkipTextNode(textNode)) {
                            continue;
                        }
                        var text = textNode.nodeValue;
                        var match = re.exec(text);
                        if (!match) {
                            continue;
                        }

                        // 每个相关词只替换首次出现：普通文本 + 链接 + 剩余文本
                        var frag = document.createDocumentFragment();
                        var start = match.index;
                        var matched = match[0];
                        if (start > 0) {
                            frag.appendChild(document.createTextNode(text.slice(0, start)));
                        }
                        // 生成内链节点（setAttribute 自动处理属性转义；target 按地址自动判断）
                        var a = document.createElement('a');
                        a.setAttribute('href', url);
                        a.setAttribute('title', word);
                        a.setAttribute('target', that.linkTargetGet(url));
                        a.appendChild(document.createTextNode(matched));
                        frag.appendChild(a);
                        if (start + matched.length < text.length) {
                            frag.appendChild(document.createTextNode(text.slice(start + matched.length)));
                        }
                        textNode.parentNode.replaceChild(frag, textNode);
                        total++;
                        // 本词已完成首次替换，处理下一个相关词
                        break;
                    }
                });

                return {html: container.innerHTML, count: total};
            },
            /**
             * 一键插入 SEO 内链（按钮点击入口）
             * 流程：请求字典 → 校验正文 → DOM 替换相关词 → 写回
             */
            seoInnerLinkReplace: function () {
                var that = this;
                if (that.loading) {
                    return;
                }
                that.loading = true;
                // 拉取 SEO 内链接字典（dictLabel=相关词，dictValue=链接地址）
                ms.http.get(ms.manager + '/mdiy/dict/list.do', {
                    dictType: 'SEO内链接',
                    pageSize: 99999
                }).then(function (data) {
                    var dictList = [];
                    if (data.result) {
                        data = data.data;
                        // 过滤无效项：相关词和地址都必须有值
                        dictList = (data.rows || []).filter(function (item) {
                            return item.dictLabel && item.dictValue;
                        });
                    }
                    if (!dictList.length) {
                        that.$notify({
                            title: '提示',
                            message: '字典类型【SEO内链接】暂无数据，请先在自定义字典中配置',
                            type: 'warning'
                        });
                        return;
                    }
                    // 校验正文是否为空（去掉标签后判断）
                    var source = that.modelValue || '';
                    if (!source || !String(source).replace(/<[^>]+>/g, '').trim()) {
                        that.$notify({
                            title: '提示',
                            message: '请先填写文章内容',
                            type: 'warning'
                        });
                        return;
                    }
                    // 执行关键词 → 内链替换
                    var result = that.contentKeywordReplace(source, dictList);
                    if (!result.count) {
                        that.$notify({
                            title: '提示',
                            message: '未匹配到可替换的相关词（可能已全部加链）',
                            type: 'info'
                        });
                        return;
                    }
                    // 写回正文
                    that.$emit('update:modelValue', result.html);
                    that.$notify({
                        title: '成功',
                        message: '已插入 ' + result.count + ' 处 SEO 内链',
                        type: 'success'
                    });
                }).catch(function (err) {
                    console.log(err);
                    that.$notify({
                        title: '失败',
                        message: '获取 SEO 内链字典失败',
                        type: 'warning'
                    });
                }).finally(function () {
                    that.loading = false;
                });
            }
        }
    });
</script>
