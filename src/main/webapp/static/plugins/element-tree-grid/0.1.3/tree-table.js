(function (global, factory) {
	typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
	typeof define === 'function' && define.amd ? define(factory) :
	(global.ElTableTreeColumn = factory());
}(this, (function () { 'use strict';

var nestRE = /^(attrs|props|on|nativeOn|class|style|hook)$/;

var index = function mergeJSXProps(objs) {
  return objs.reduce(function (a, b) {
    var aa, bb, key, nestedKey, temp;
    for (key in b) {
      aa = a[key];
      bb = b[key];
      if (aa && nestRE.test(key)) {
        // normalize class
        if (key === 'class') {
          if (typeof aa === 'string') {
            temp = aa;
            a[key] = aa = {};
            aa[temp] = true;
          }
          if (typeof bb === 'string') {
            temp = bb;
            b[key] = bb = {};
            bb[temp] = true;
          }
        }
        if (key === 'on' || key === 'nativeOn' || key === 'hook') {
          // merge functions
          for (nestedKey in bb) {
            aa[nestedKey] = mergeFn(aa[nestedKey], bb[nestedKey]);
          }
        } else if (Array.isArray(aa)) {
          a[key] = aa.concat(bb);
        } else if (Array.isArray(bb)) {
          a[key] = [aa].concat(bb);
        } else {
          for (nestedKey in bb) {
            aa[nestedKey] = bb[nestedKey];
          }
        }
      } else {
        a[key] = b[key];
      }
    }
    return a;
  }, {});
};

function mergeFn(a, b) {
  return function () {
    a.apply(this, arguments);
    b.apply(this, arguments);
  };
}

var ElTableTreeColumnPropDefine = {
    prop: {
        type: String
    },
    label: String,
    className: String,
    labelClassName: String,
    property: String,
    width: {},
    minWidth: {},
    renderHeader: Function,
    sortable: {
        type: [String, Boolean],
        default: false
    },
    sortMethod: Function,
    resizable: {
        type: Boolean,
        default: true
    },
    context: {},
    columnKey: String,
    align: String,
    headerAlign: String,
    showTooltipWhenOverflow: Boolean,
    showOverflowTooltip: Boolean,
    fixed: [Boolean, String],
    formatter: Function,
    selectable: Function,
    reserveSelection: Boolean,
    filterMethod: Function,
    filteredValue: Array,
    filters: Array,
    filterMultiple: {
        type: Boolean,
        default: true
    },
    treeKey: {
        type: String,
        default: 'id'
    },
    childNumKey: {
        type: String,
        default: 'child_num'
    },
    parentKey: {
        type: String,
        default: 'parent_id'
    },
    levelKey: {
        type: String,
        default: 'depth'
    },
    childKey: {
        type: String,
        default: 'children'
    },
    fileIcon: {
        type: String,
        default: 'el-icon-file'
    },
    folderIcon: {
        type: String,
        default: 'el-icon-folder'
    },
    remote: {
        type: Function,
        default: null
    },
    allRemote: {
        type: Boolean,
        default: false
    },
    indentSize: {
        type: Number,
        default: 14
    },
    expandAll: {
        type: Boolean,
        default: false
    },
    expandKey: {
        type: String,
        default: 'expanded'
    }
};

function hasChild(context, scope) {
    var _a = context.props,
        childNumKey = _a.childNumKey,
        childKey = _a.childKey,
        row = scope.row;
    if (row[childNumKey] != undefined) {
        return row[childNumKey] > 0 ? true : false;
    }
    if (row[childKey] != undefined) {
        return row[childKey].length > 0 ? true : false;
    } else {
        return false;
    }
}
function paddingLeft(context, scope) {
    return parseInt(scope.row[context.props.levelKey]) * parseInt(context.props.indentSize.toString()) + 'px';
}
function removeCachedExpanedRow(context, scope) {
    var _treeCachedExpanded = scope.store.states._treeCachedExpanded,
        treeKey = context.props.treeKey,
        row = scope.row;
    scope.store.states._treeCachedExpanded = _treeCachedExpanded.filter(function (crow) {
        return crow[treeKey] != row[treeKey];
    });
}
function isCachedExpanedRow(context, scope) {
    var _treeCachedExpanded = scope.store.states._treeCachedExpanded,
        treeKey = context.props.treeKey,
        row = scope.row;
    return _treeCachedExpanded.map(function (row) {
        return row[treeKey];
    }).filter(function (_treeKey) {
        return _treeKey == row[treeKey];
    }).length > 0;
}
function isNeedExpanedRow(context, scope) {
    if (context.props.expandAll && !scope.store.states._treeInitedExpanded.some(function (treeKey) {
        return treeKey == scope.row[context.props.treeKey];
    })) {
        scope.store.states._treeInitedExpanded.push(scope.row[context.props.treeKey]);
        return true;
    }
    var expandKey = context.props.expandKey,
        row = scope.row;
    if (expandKey && row[expandKey] && !scope.store.states._treeInitedExpanded.some(function (treeKey) {
        return treeKey == row[context.props.treeKey];
    })) {
        scope.store.states._treeInitedExpanded.push(scope.row[context.props.treeKey]);
        return true;
    }
    var result = isCachedExpanedRow(context, scope);
    if (result) removeCachedExpanedRow(context, scope);
    return result;
}
function isLoadingRow(context, scope) {
    var _treeRowLoading = scope.store.states._treeRowLoading,
        treeKey = context.props.treeKey,
        row = scope.row;
    return _treeRowLoading.map(function (row) {
        return row[treeKey];
    }).filter(function (_treeKey) {
        return _treeKey == row[treeKey];
    }).length > 0;
}
function isExpandedRow(context, scope) {
    var _treeRowExpanded = scope.store.states._treeRowExpanded,
        treeKey = context.props.treeKey,
        row = scope.row;
    return _treeRowExpanded.map(function (row) {
        return row[treeKey];
    }).filter(function (_treeKey) {
        return _treeKey == row[treeKey];
    }).length > 0;
}
function icon(scope, context) {
    if (isLoadingRow(context, scope)) return 'el-icon-loading';
    if (isExpandedRow(context, scope)) return 'el-icon-caret-bottom';
    return 'el-icon-caret-right';
}
function folderIcon(context, scope) {
    var floder = context.props.folderIcon,
        floder_open = context.props.folderIcon + '-open';
    return isExpandedRow(context, scope) ? floder_open : floder;
}
function renderDetail(h, context, scope) {
    if (context.data.scopedSlots && context.data.scopedSlots.default) {
        return context.data.scopedSlots.default(scope);
    }
    if (context.props.formatter) {
        return h(
            'span',
            null,
            [context.props.formatter(scope.row, scope.column)]
        );
    }
    return h(
        'span',
        null,
        [scope.row[context.props.prop]]
    );
}

var clone = function clone(data) {
    return JSON.parse(JSON.stringify(data));
};
var indexOf = function indexOf(val, arr) {
    var has = -1;
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == val) {
            has = i;
            break;
        }
    }
    return has;
};
var descendantsIds = function descendantsIds(id, data, parentKey, treeKey) {
    var result = [],
        compare = [id],
        length = -1;
    while (length != compare.length) {
        length = compare.length;
        data.forEach(function (item) {
            if (indexOf(item[parentKey], compare) > -1 && indexOf(item[treeKey], compare) == -1) {
                result.push(item[treeKey]);
                compare.push(item[treeKey]);
            }
        });
    }
    return result;
};
var toggleExpanded = function toggleExpanded(context, scope, isExpended) {
    var treeKey = context.props.treeKey,
        states = scope.store.states;
    states._treeCachedExpanded = states._treeCachedExpanded.filter(function (r) {
        return r[treeKey] != scope.row[treeKey];
    });
    if (isExpended) {
        states._treeRowExpanded = states._treeRowExpanded.filter(function (r) {
            return r[treeKey] != scope.row[treeKey];
        });
    } else {
        states._treeRowExpanded.push(scope.row);
    }
};
var toggleLoading = function toggleLoading(context, scope, isloading) {
    var treeKey = context.props.treeKey;
    if (isloading) {
        scope.store.states._treeRowLoading = scope.store.states._treeRowLoading.filter(function (r) {
            return r[treeKey] != scope.row[treeKey];
        });
    } else {
        scope.store.states._treeRowLoading.push(scope.row);
    }
};
var commit = function commit(context, scope, list) {
    var owner = scope.store.table; //methods.owner(context.parent);
    var states = scope.store.states;
    // let selection = states.selection;
    owner.store.commit('setData', list);
    /* owner.clearSelection();
    let data = owner.store.states._data;
    data.forEach(row => {
      if (has(context, row, selection)) {
        owner.toggleRowSelection(row)
      }
    }); */
};
var getIndex = function getIndex(context, scope, data) {
    var index = -1,
        treeKey = context.props.treeKey;
    data.forEach(function (r, i) {
        if (r[treeKey] == scope.row[treeKey]) {
            index = i;
        }
    });
    return index;
};
var Colspand = function Colspand(context, scope, data) {
    var _a = context.props,
        parentKey = _a.parentKey,
        treeKey = _a.treeKey,
        states = scope.store.states,
        row = scope.row,
        result = [];
    var removeIds = descendantsIds(row[treeKey], data, parentKey, treeKey);
    data = data.filter(function (item) {
        return !removeIds.some(function (id) {
            return id == item[treeKey];
        });
    });
    var NeedToCached = states._treeRowExpanded.filter(function (item) {
        return removeIds.some(function (id) {
            return id == item[treeKey];
        });
    });
    var _treeCachedExpanded = states._treeCachedExpanded;
    NeedToCached.forEach(function (item) {
        if (!_treeCachedExpanded.some(function (i) {
            return i[treeKey] == item[treeKey];
        })) {
            states._treeCachedExpanded.push(item);
        }
    });
    states._treeRowExpanded = states._treeRowExpanded.filter(function (item) {
        return !removeIds.some(function (id) {
            return id == item[treeKey];
        });
    });
    commit(context, scope, data);
};
var insertRows = function insertRows(context, scope, children, updateChild) {
    if (updateChild === void 0) {
        updateChild = false;
    }
    var _data = clone(scope.store.states._data);
    var _index = getIndex(context, scope, _data);
    var prefix = _data.slice(0, _index + 1);
    var i = 0;
    while (i < _index + 1) {
        _data.shift();
        i++;
    }
    if (updateChild) prefix[_index][context.props.childKey] = children;
    _data = prefix.concat(children).concat(_data);
    return _data;
};
var ExpandRemote = function ExpandRemote(context, scope, data) {
    var _a = context.props,
        treeKey = _a.treeKey,
        remote = _a.remote;
    toggleLoading(context, scope, false);
    var CallBack = function CallBack(children) {
        var childNumKey = context.props.childNumKey;
        toggleLoading(context, scope, true);
        var _data;
        if (children && children.length > 0) {
            var updateChild = !context.props.allRemote;
            _data = insertRows(context, scope, children, updateChild);
        } else {
            _data = clone(scope.store.states._data);
            var _index = getIndex(context, scope, _data);
            _data[_index][childNumKey] = 0;
        }
        commit(context, scope, _data);
    };
    commit(context, scope, data);
    remote(scope.row, CallBack);
    // console.info(scope.store.states._treeCachedExpanded)
};
var Expand = function Expand(context, scope, data) {
    var childKey = context.props.childKey;
    data = insertRows(context, scope, scope.row[childKey]);
    commit(context, scope, data);
};
function doExpand(context, scope) {
    var data = clone(scope.store.states._data),
        childKey = context.props.childKey;
    // line is loading
    if (isLoadingRow(context, scope)) return;
    var isExpended = isExpandedRow(context, scope);
    toggleExpanded(context, scope, isExpended);
    if (isExpended) {
        return Colspand(context, scope, data);
    }
    var _a = context.props,
        remote = _a.remote,
        allRemote = _a.allRemote;
    if (remote && allRemote) {
        return ExpandRemote(context, scope, data);
    }
    if (scope.row[childKey]) {
        return Expand(context, scope, data);
    } else if (remote) {
        return ExpandRemote(context, scope, data);
    }
    Expand(context, scope, data);
}

var ElTableInject = /** @class */function () {
    function ElTableInject() {
        this.Injected = {};
    }
    ElTableInject.prototype.isInjected = function (scope) {
        return this.Injected[scope.store.table.tableId];
    };
    ElTableInject.prototype.Inject = function (scope) {
        if (this.isInjected(scope)) return;
        this.Injected[scope.store.table.tableId] = true;
        scope.store.states._treeRowExpanded = [];
        scope.store.states._treeRowLoading = [];
        scope.store.states._treeCachedExpanded = [];
        scope.store.states._treeInitedExpanded = [];
        // scope.store.mutations
    };
    return ElTableInject;
}();
var ElTableInjecter = new ElTableInject();

var RenderFolder = function RenderFolder(h, context, scope) {
    if (isNeedExpanedRow(context, scope)) {
        setTimeout(function () {
            doExpand(context, scope);
        }, 15);
    }
    return h(
        'span',
        {
            on: {
                'click': function click(e) {
                    e.preventDefault();
                    doExpand(context, scope);
                }
            }
        },
        [h(
            'span',
            { style: { paddingLeft: paddingLeft(context, scope) } },
            [h(
                'i',
                { 'class': icon(scope, context) },
                []
            ), h(
                'i',
                { 'class': folderIcon(context, scope) },
                []
            )]
        ), renderDetail(h, context, scope)]
    );
};
var RenderLeaf = function RenderLeaf(h, context, scope) {
    return h(
        'span',
        { style: { paddingLeft: paddingLeft(context, scope) } },
        [h(
            'i',
            { 'class': context.props.fileIcon },
            []
        ), renderDetail(h, context, scope)]
    );
};
var RenderContext = function RenderContext(h, context, scope) {
    ElTableInjecter.Inject(scope);
    var hasChild$$1 = hasChild(context, scope);
    if (hasChild$$1) return RenderFolder(h, context, scope);
    return RenderLeaf(h, context, scope);
};
var ElTableTreeColumn = {
    name: 'el-table-tree-column',
    functional: true,
    props: ElTableTreeColumnPropDefine,
    render: function render(h, context) {
        // props will be lost when `scopedSlots` is rendering
        var attr = {};
        Object.keys(context.props).map(function (k) {
            attr[k] = context.props[k];
        });
        var attrs = { attrs: attr };
        return h(
            'el-table-column',
            index([attrs, { scopedSlots: { default: function _default(scope) {
                        return RenderContext(h, context, scope);
                    } } }]),
            []
        );
    }
};
if (typeof window !== 'undefined' && window.Vue) {
    window.Vue.component('el-table-tree-column', ElTableTreeColumn);
}

return ElTableTreeColumn;

})));
