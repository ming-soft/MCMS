import { ref as me, watch as ve, onMounted as be, openBlock as we, createElementBlock as ye, createCommentVNode as Ce } from "vue";
function St(o) {
  return o === "" ? o : o === "true" || o == "1";
}
function xe(o, t) {
  return new Promise((e, r) => {
    var n = new XMLHttpRequest();
    n.responseType = "blob", n.onload = function() {
      var i = new FileReader();
      i.onloadend = function() {
        e(i.result);
      }, i.readAsArrayBuffer(n.response);
    }, n.open("GET", o), n.send();
  });
}
function et(o) {
  if (typeof o != "string")
    throw new TypeError("Path must be a string. Received " + JSON.stringify(o));
}
function Zt(o, t) {
  for (var e = "", r = 0, n = -1, i = 0, a, s = 0; s <= o.length; ++s) {
    if (s < o.length)
      a = o.charCodeAt(s);
    else {
      if (a === 47)
        break;
      a = 47;
    }
    if (a === 47) {
      if (!(n === s - 1 || i === 1)) if (n !== s - 1 && i === 2) {
        if (e.length < 2 || r !== 2 || e.charCodeAt(e.length - 1) !== 46 || e.charCodeAt(e.length - 2) !== 46) {
          if (e.length > 2) {
            var l = e.lastIndexOf("/");
            if (l !== e.length - 1) {
              l === -1 ? (e = "", r = 0) : (e = e.slice(0, l), r = e.length - 1 - e.lastIndexOf("/")), n = s, i = 0;
              continue;
            }
          } else if (e.length === 2 || e.length === 1) {
            e = "", r = 0, n = s, i = 0;
            continue;
          }
        }
        t && (e.length > 0 ? e += "/.." : e = "..", r = 2);
      } else
        e.length > 0 ? e += "/" + o.slice(n + 1, s) : e = o.slice(n + 1, s), r = s - n - 1;
      n = s, i = 0;
    } else a === 46 && i !== -1 ? ++i : i = -1;
  }
  return e;
}
function Ae(o, t) {
  var e = t.dir || t.root, r = t.base || (t.name || "") + (t.ext || "");
  return e ? e === t.root ? e + r : e + o + r : r;
}
var ht = {
  // path.resolve([from ...], to)
  resolve: function() {
    for (var t = "", e = !1, r, n = arguments.length - 1; n >= -1 && !e; n--) {
      var i;
      n >= 0 ? i = arguments[n] : (r === void 0 && (r = process.cwd()), i = r), et(i), i.length !== 0 && (t = i + "/" + t, e = i.charCodeAt(0) === 47);
    }
    return t = Zt(t, !e), e ? t.length > 0 ? "/" + t : "/" : t.length > 0 ? t : ".";
  },
  normalize: function(t) {
    if (et(t), t.length === 0) return ".";
    var e = t.charCodeAt(0) === 47, r = t.charCodeAt(t.length - 1) === 47;
    return t = Zt(t, !e), t.length === 0 && !e && (t = "."), t.length > 0 && r && (t += "/"), e ? "/" + t : t;
  },
  isAbsolute: function(t) {
    return et(t), t.length > 0 && t.charCodeAt(0) === 47;
  },
  join: function() {
    if (arguments.length === 0)
      return ".";
    for (var t, e = 0; e < arguments.length; ++e) {
      var r = arguments[e];
      et(r), r.length > 0 && (t === void 0 ? t = r : t += "/" + r);
    }
    return t === void 0 ? "." : ht.normalize(t);
  },
  relative: function(t, e) {
    if (et(t), et(e), t === e || (t = ht.resolve(t), e = ht.resolve(e), t === e)) return "";
    for (var r = 1; r < t.length && t.charCodeAt(r) === 47; ++r)
      ;
    for (var n = t.length, i = n - r, a = 1; a < e.length && e.charCodeAt(a) === 47; ++a)
      ;
    for (var s = e.length, l = s - a, c = i < l ? i : l, u = -1, h = 0; h <= c; ++h) {
      if (h === c) {
        if (l > c) {
          if (e.charCodeAt(a + h) === 47)
            return e.slice(a + h + 1);
          if (h === 0)
            return e.slice(a + h);
        } else i > c && (t.charCodeAt(r + h) === 47 ? u = h : h === 0 && (u = 0));
        break;
      }
      var b = t.charCodeAt(r + h), x = e.charCodeAt(a + h);
      if (b !== x)
        break;
      b === 47 && (u = h);
    }
    var D = "";
    for (h = r + u + 1; h <= n; ++h)
      (h === n || t.charCodeAt(h) === 47) && (D.length === 0 ? D += ".." : D += "/..");
    return D.length > 0 ? D + e.slice(a + u) : (a += u, e.charCodeAt(a) === 47 && ++a, e.slice(a));
  },
  _makeLong: function(t) {
    return t;
  },
  dirname: function(t) {
    if (et(t), t.length === 0) return ".";
    for (var e = t.charCodeAt(0), r = e === 47, n = -1, i = !0, a = t.length - 1; a >= 1; --a)
      if (e = t.charCodeAt(a), e === 47) {
        if (!i) {
          n = a;
          break;
        }
      } else
        i = !1;
    return n === -1 ? r ? "/" : "." : r && n === 1 ? "//" : t.slice(0, n);
  },
  basename: function(t, e) {
    if (e !== void 0 && typeof e != "string") throw new TypeError('"ext" argument must be a string');
    et(t);
    var r = 0, n = -1, i = !0, a;
    if (e !== void 0 && e.length > 0 && e.length <= t.length) {
      if (e.length === t.length && e === t) return "";
      var s = e.length - 1, l = -1;
      for (a = t.length - 1; a >= 0; --a) {
        var c = t.charCodeAt(a);
        if (c === 47) {
          if (!i) {
            r = a + 1;
            break;
          }
        } else
          l === -1 && (i = !1, l = a + 1), s >= 0 && (c === e.charCodeAt(s) ? --s === -1 && (n = a) : (s = -1, n = l));
      }
      return r === n ? n = l : n === -1 && (n = t.length), t.slice(r, n);
    } else {
      for (a = t.length - 1; a >= 0; --a)
        if (t.charCodeAt(a) === 47) {
          if (!i) {
            r = a + 1;
            break;
          }
        } else n === -1 && (i = !1, n = a + 1);
      return n === -1 ? "" : t.slice(r, n);
    }
  },
  extname: function(t) {
    et(t);
    for (var e = -1, r = 0, n = -1, i = !0, a = 0, s = t.length - 1; s >= 0; --s) {
      var l = t.charCodeAt(s);
      if (l === 47) {
        if (!i) {
          r = s + 1;
          break;
        }
        continue;
      }
      n === -1 && (i = !1, n = s + 1), l === 46 ? e === -1 ? e = s : a !== 1 && (a = 1) : e !== -1 && (a = -1);
    }
    return e === -1 || n === -1 || // We saw a non-dot character immediately before the dot
    a === 0 || // The (right-most) trimmed path component is exactly '..'
    a === 1 && e === n - 1 && e === r + 1 ? "" : t.slice(e, n);
  },
  format: function(t) {
    if (t === null || typeof t != "object")
      throw new TypeError('The "pathObject" argument must be of type Object. Received type ' + typeof t);
    return Ae("/", t);
  },
  parse: function(t) {
    et(t);
    var e = { root: "", dir: "", base: "", ext: "", name: "" };
    if (t.length === 0) return e;
    var r = t.charCodeAt(0), n = r === 47, i;
    n ? (e.root = "/", i = 1) : i = 0;
    for (var a = -1, s = 0, l = -1, c = !0, u = t.length - 1, h = 0; u >= i; --u) {
      if (r = t.charCodeAt(u), r === 47) {
        if (!c) {
          s = u + 1;
          break;
        }
        continue;
      }
      l === -1 && (c = !1, l = u + 1), r === 46 ? a === -1 ? a = u : h !== 1 && (h = 1) : a !== -1 && (h = -1);
    }
    return a === -1 || l === -1 || // We saw a non-dot character immediately before the dot
    h === 0 || // The (right-most) trimmed path component is exactly '..'
    h === 1 && a === l - 1 && a === s + 1 ? l !== -1 && (s === 0 && n ? e.base = e.name = t.slice(1, l) : e.base = e.name = t.slice(s, l)) : (s === 0 && n ? (e.name = t.slice(1, a), e.base = t.slice(1, l)) : (e.name = t.slice(s, a), e.base = t.slice(s, l)), e.ext = t.slice(a, l)), s > 0 ? e.dir = t.slice(0, s - 1) : n && (e.dir = "/"), e;
  },
  sep: "/",
  delimiter: ":",
  win32: null,
  posix: null
};
ht.posix = ht;
const Pe = ht.extname, ne = ht.basename;
class Be {
  constructor() {
    let t = typeof global > "u", e = "image/png", r = "image/jpeg", n = "image/jpeg", i = "image/webp", a = "application/pdf", s = "image/svg+xml";
    Object.assign(this, {
      toMime: this.toMime.bind(this),
      fromMime: this.fromMime.bind(this),
      expected: t ? '"png", "jpg", or "webp"' : '"png", "jpg", "pdf", or "svg"',
      formats: t ? { png: e, jpg: r, jpeg: n, webp: i } : { png: e, jpg: r, jpeg: n, pdf: a, svg: s },
      mimes: t ? { [e]: "png", [r]: "jpg", [i]: "webp" } : { [e]: "png", [r]: "jpg", [a]: "pdf", [s]: "svg" }
    });
  }
  toMime(t) {
    return this.formats[(t || "").replace(/^\./, "").toLowerCase()];
  }
  fromMime(t) {
    return this.mimes[t];
  }
}
function ke(o, {
  filename: t = "",
  extension: e = "",
  format: T,
  page: n,
  quality: i,
  matte: a,
  density: s,
  outline: l,
  archive: x
} = {}) {
  var { fromMime: u, toMime: h, expected: b } = new Be(), x = x || "canvas", D = T || e.replace(/@\d+x$/i, "") || Pe(t), T = u(h(D) || D), z = h(T), g = o.length;
  if (!D)
    throw new Error(
      "Cannot determine image format (use a filename extension or 'format' argument)"
    );
  if (!T)
    throw new Error(`Unsupported file format "${D}" (expected ${b})`);
  if (!g)
    throw new RangeError(
      "Canvas has no associated contexts (try calling getContext or newPage first)"
    );
  let p, A, d = t.replace(/{(\d*)}/g, (m, y) => (A = !0, y = parseInt(y, 10), p = isFinite(y) ? y : isFinite(p) ? p : -1, "{}")), w = n > 0 ? n - 1 : n < 0 ? g + n : void 0;
  if (isFinite(w) && w < 0 || w >= g)
    throw new RangeError(
      g == 1 ? `Canvas only has a ‘page 1’ (${w} is out of bounds)` : `Canvas has pages 1–${g} (${w} is out of bounds)`
    );
  if (o = isFinite(w) ? [o[w]] : A || T == "pdf" ? o : o.slice(-1), i === void 0)
    i = 0.92;
  else if (typeof i != "number" || !isFinite(i) || i < 0 || i > 1)
    throw new TypeError(
      "The quality option must be an number in the 0.0–1.0 range"
    );
  if (s === void 0) {
    let m = (e || ne(t, D)).match(/@(\d+)x$/i);
    s = m ? parseInt(m[1], 10) : 1;
  } else if (typeof s != "number" || !Number.isInteger(s) || s < 1)
    throw new TypeError("The density option must be a non-negative integer");
  return l === void 0 ? l = !0 : T == "svg" && (l = !!l), {
    filename: t,
    pattern: d,
    format: T,
    mime: z,
    pages: o,
    padding: p,
    quality: i,
    matte: a,
    density: s,
    outline: l,
    archive: x
  };
}
class Pt {
  static for(t) {
    return new Pt().append(t).get();
  }
  constructor() {
    this.crc = -1;
  }
  get() {
    return ~this.crc;
  }
  append(t) {
    for (var e = this.crc | 0, r = this.table, n = 0, i = t.length | 0; n < i; n++)
      e = e >>> 8 ^ r[(e ^ t[n]) & 255];
    return this.crc = e, this;
  }
}
Pt.prototype.table = (() => {
  var o, t, e, r = [];
  for (o = 0; o < 256; o++) {
    for (e = o, t = 0; t < 8; t++)
      e = e & 1 ? e >>> 1 ^ 3988292384 : e >>> 1;
    r[o] = e;
  }
  return r;
})();
function It(o) {
  let t = new Uint8Array(o), e = new DataView(t.buffer), r = {
    array: t,
    view: e,
    size: o,
    set8(n, i) {
      return e.setUint8(n, i), r;
    },
    set16(n, i) {
      return e.setUint16(n, i, !0), r;
    },
    set32(n, i) {
      return e.setUint32(n, i, !0), r;
    },
    bytes(n, i) {
      return t.set(i, n), r;
    }
  };
  return r;
}
class Bt {
  constructor(t) {
    let e = /* @__PURE__ */ new Date();
    Object.assign(this, {
      directory: t,
      offset: 0,
      files: [],
      time: (e.getHours() << 6 | e.getMinutes()) << 5 | e.getSeconds() / 2,
      date: (e.getFullYear() - 1980 << 4 | e.getMonth() + 1) << 5 | e.getDate()
    }), this.add(t);
  }
  async add(t, e) {
    let r = !e, n = Bt.encoder.encode(`${this.directory}/${r ? "" : t}`), i = new Uint8Array(r ? 0 : await e.arrayBuffer()), a = 30 + n.length, s = a + i.length, l = 16, { offset: c } = this, u = It(26).set32(0, 134742036).set16(6, this.time).set16(8, this.date).set32(10, Pt.for(i)).set32(14, i.length).set32(18, i.length).set16(22, n.length);
    c += a;
    let h = It(a + i.length + l).set32(0, 67324752).bytes(4, u.array).bytes(30, n).bytes(a, i);
    c += i.length, h.set32(s, 134695760).bytes(s + 4, u.array.slice(10, 22)), c += l, this.files.push({ offset: c, folder: r, name: n, header: u, payload: h }), this.offset = c;
  }
  toBuffer() {
    let t = this.files.reduce(
      (h, { name: b }) => 46 + b.length + h,
      0
    ), e = It(t + 22), r = 0;
    for (var { offset: n, name: i, header: a, folder: s } of this.files)
      e.set32(r, 33639248).set16(r + 4, 20).bytes(r + 6, a.array).set8(r + 38, s ? 16 : 0).set32(r + 42, n).bytes(r + 46, i), r += 46 + i.length;
    e.set32(r, 101010256).set16(r + 8, this.files.length).set16(r + 10, this.files.length).set32(r + 12, t).set32(r + 16, this.offset);
    let l = new Uint8Array(this.offset + e.size), c = 0;
    for (var { payload: u } of this.files)
      l.set(u.array, c), c += u.size;
    return l.set(e.array, c), l;
  }
  get blob() {
    return new Blob([this.toBuffer()], { type: "application/zip" });
  }
}
Bt.encoder = new TextEncoder();
const Rt = (o, t, e, r) => {
  if (r) {
    let { width: n, height: i } = o, a = Object.assign(document.createElement("canvas"), { width: n, height: i }), s = a.getContext("2d");
    s.fillStyle = r, s.fillRect(0, 0, n, i), s.drawImage(o, 0, 0), o = a;
  }
  return new Promise((n, i) => o.toBlob(n, t, e));
}, De = (...o) => Rt(...o).then((t) => t.arrayBuffer()), Te = async (o, t, e, r, n) => {
  ie(n, await Rt(o, t, e, r));
}, Ee = async (o, t, e, r, n, i, a) => {
  let s = (u) => i.replace("{}", String(u + 1).padStart(a, "0")), l = ne(n, ".zip") || "archive", c = new Bt(l);
  await Promise.all(
    o.map(async (u, h) => {
      let b = s(h);
      await c.add(b, await Rt(u, t, e, r));
    })
  ), ie(`${l}.zip`, c.blob);
}, ie = (o, t) => {
  const e = window.URL.createObjectURL(t), r = document.createElement("a");
  r.style.display = "none", r.href = e, r.setAttribute("download", o), typeof r.download > "u" && r.setAttribute("target", "_blank"), document.body.appendChild(r), r.click(), document.body.removeChild(r), setTimeout(() => window.URL.revokeObjectURL(e), 100);
}, Se = (o, t, e) => o.map((r) => {
  if (t == 1 && !e) return r.canvas;
  let n = document.createElement("canvas"), i = n.getContext("2d"), a = r.canvas ? r.canvas : r;
  return n.width = a.width * t, n.height = a.height * t, e && (i.fillStyle = e, i.fillRect(0, 0, n.width, n.height)), i.scale(t, t), i.drawImage(a, 0, 0), n;
}), Ie = { asBuffer: De, asDownload: Te, asZipDownload: Ee, atScale: Se, options: ke }, { asBuffer: Lt, asDownload: Le, asZipDownload: Me, atScale: Mt, options: _t } = Ie, Vt = Symbol.for("toDataURL");
let _e = class {
  constructor(t, e) {
    let r = document.createElement("canvas"), n = [];
    Object.defineProperty(r, "async", {
      value: !0,
      writable: !1,
      enumerable: !0
    });
    for (var [i, a] of Object.entries({
      png: () => Lt(r, "image/png"),
      jpg: () => Lt(r, "image/jpeg"),
      pages: () => n.concat(r).map((s) => s.getContext("2d"))
    }))
      Object.defineProperty(r, i, { get: a });
    return Object.assign(r, {
      width: t,
      height: e,
      newPage(...s) {
        var { width: c, height: u } = r, l = Object.assign(document.createElement("canvas"), {
          width: c,
          height: u
        });
        l.getContext("2d").drawImage(r, 0, 0), n.push(l);
        var [c, u] = s.length ? s : [c, u];
        return Object.assign(r, { width: c, height: u }).getContext("2d");
      },
      saveAs(s, l) {
        l = typeof l == "number" ? { quality: l } : l;
        let c = _t(this.pages, { filename: s, ...l }), { pattern: u, padding: h, mime: b, quality: x, matte: D, density: T, archive: z } = c, g = Mt(c.pages, T);
        return h == null ? Le(g[0], b, x, D, s) : Me(
          g,
          b,
          x,
          D,
          z,
          u,
          h
        );
      },
      toBuffer(s = "png", l = {}) {
        l = typeof l == "number" ? { quality: l } : l;
        let c = _t(this.pages, { extension: s, ...l }), { mime: u, quality: h, matte: b, pages: x, density: D } = c, T = Mt(x, D, b)[0];
        return Lt(T, u, h, b);
      },
      [Vt]: r.toDataURL.bind(r),
      toDataURL(s = "png", l = {}) {
        l = typeof l == "number" ? { quality: l } : l;
        let c = _t(this.pages, { extension: s, ...l }), { mime: u, quality: h, matte: b, pages: x, density: D } = c, T = Mt(x, D, b)[0], z = T[T === r ? Vt : "toDataURL"](u, h);
        return Promise.resolve(z);
      }
    });
  }
};
const Fe = {
  Canvas: _e
}, bt = (o, t, e = {}, r = e) => {
  if (Array.isArray(t))
    t.forEach((n) => bt(o, n, e, r));
  else if (typeof t == "function")
    t(o, e, r, bt);
  else {
    const n = Object.keys(t)[0];
    Array.isArray(t[n]) ? (r[n] = {}, bt(o, t[n], e, r[n])) : r[n] = t[n](o, e, r, bt);
  }
  return e;
}, dt = (o, t) => (e, r, n, i) => {
  t(e, r, n) && i(e, o, r, n);
}, Ne = (o, t) => (e, r, n, i) => {
  const a = [];
  let s = e.pos;
  for (; t(e, r, n); ) {
    const l = {};
    if (i(e, o, r, l), e.pos === s)
      break;
    s = e.pos, a.push(l);
  }
  return a;
}, Oe = (o) => ({
  data: o,
  pos: 0
}), Y = () => (o) => o.data[o.pos++], oe = (o = 0) => (t) => t.data[t.pos + o], nt = (o) => (t) => t.data.subarray(t.pos, t.pos += o), kt = (o) => (t) => t.data.subarray(t.pos, t.pos + o), Ft = (o) => (t) => Array.from(nt(o)(t)).map((e) => String.fromCharCode(e)).join(""), ut = (o) => (t) => {
  const e = nt(2)(t);
  return (e[1] << 8) + e[0];
}, ae = (o, t) => (e, r, n) => {
  const i = typeof t == "function" ? t(e, r, n) : t, a = nt(o), s = new Array(i);
  for (var l = 0; l < i; l++)
    s[l] = a(e);
  return s;
}, Re = (o, t, e) => {
  for (var r = 0, n = 0; n < e; n++)
    r += o[t + n] && 2 ** (e - n - 1);
  return r;
}, $t = (o) => (t) => {
  const e = Y()(t), r = new Array(8);
  for (var n = 0; n < 8; n++)
    r[7 - n] = !!(e & 1 << n);
  return Object.keys(o).reduce((i, a) => {
    const s = o[a];
    return s.length ? i[a] = Re(r, s.index, s.length) : i[a] = r[s.index], i;
  }, {});
};
var Dt = {
  blocks: (o) => {
    const e = [], r = o.data.length;
    for (var n = 0, i = Y()(o); i !== 0 && i; i = Y()(o)) {
      if (o.pos + i >= r) {
        const c = r - o.pos;
        e.push(nt(c)(o)), n += c;
        break;
      }
      e.push(nt(i)(o)), n += i;
    }
    const a = new Uint8Array(n);
    for (var s = 0, l = 0; l < e.length; l++)
      a.set(e[l], s), s += e[l].length;
    return a;
  }
};
const $e = dt(
  {
    gce: [
      { codes: nt(2) },
      { byteSize: Y() },
      {
        extras: $t({
          future: { index: 0, length: 3 },
          disposal: { index: 3, length: 3 },
          userInput: { index: 6 },
          transparentColorGiven: { index: 7 }
        })
      },
      { delay: ut() },
      { transparentColorIndex: Y() },
      { terminator: Y() }
    ]
  },
  (o) => {
    var t = kt(2)(o);
    return t[0] === 33 && t[1] === 249;
  }
), ze = dt(
  {
    image: [
      { code: Y() },
      {
        descriptor: [
          { left: ut() },
          { top: ut() },
          { width: ut() },
          { height: ut() },
          {
            lct: $t({
              exists: { index: 0 },
              interlaced: { index: 1 },
              sort: { index: 2 },
              future: { index: 3, length: 2 },
              size: { index: 5, length: 3 }
            })
          }
        ]
      },
      dt(
        {
          lct: ae(3, (o, t, e) => Math.pow(2, e.descriptor.lct.size + 1))
        },
        (o, t, e) => e.descriptor.lct.exists
      ),
      { data: [{ minCodeSize: Y() }, Dt] }
    ]
  },
  (o) => oe()(o) === 44
), je = dt(
  {
    text: [
      { codes: nt(2) },
      { blockSize: Y() },
      {
        preData: (o, t, e) => nt(e.text.blockSize)(o)
      },
      Dt
    ]
  },
  (o) => {
    var t = kt(2)(o);
    return t[0] === 33 && t[1] === 1;
  }
), Ge = dt(
  {
    application: [
      { codes: nt(2) },
      { blockSize: Y() },
      { id: (o, t, e) => Ft(e.blockSize)(o) },
      Dt
    ]
  },
  (o) => {
    var t = kt(2)(o);
    return t[0] === 33 && t[1] === 255;
  }
), Ue = dt(
  {
    comment: [{ codes: nt(2) }, Dt]
  },
  (o) => {
    var t = kt(2)(o);
    return t[0] === 33 && t[1] === 254;
  }
), He = [
  { header: [{ signature: Ft(3) }, { version: Ft(3) }] },
  {
    lsd: [
      { width: ut() },
      { height: ut() },
      {
        gct: $t({
          exists: { index: 0 },
          resolution: { index: 1, length: 3 },
          sort: { index: 4 },
          size: { index: 5, length: 3 }
        })
      },
      { backgroundColorIndex: Y() },
      { pixelAspectRatio: Y() }
    ]
  },
  dt(
    {
      gct: ae(
        3,
        (o, t) => Math.pow(2, t.lsd.gct.size + 1)
      )
    },
    (o, t) => t.lsd.gct.exists
  ),
  // content frames
  {
    frames: Ne(
      [$e, Ge, Ue, ze, je],
      (o) => {
        var t = oe()(o);
        return t === 33 || t === 44;
      }
    )
  }
], Ke = (o, t) => {
  const e = new Array(o.length), r = o.length / t, n = function(u, h) {
    const b = o.slice(h * t, (h + 1) * t);
    e.splice.apply(e, [u * t, t].concat(b));
  }, i = [0, 4, 2, 1], a = [8, 8, 4, 2];
  for (var s = 0, l = 0; l < 4; l++)
    for (var c = i[l]; c < r; c += a[l])
      n(c, s), s++;
  return e;
}, Xe = (o, t, e) => {
  const i = e;
  var a, s, l, c, u, h, b, w, x, D, d, T, m, y, E, P;
  const z = new Array(e), g = new Array(4096), p = new Array(4096), A = new Array(4097);
  for (T = o, s = 1 << T, u = s + 1, a = s + 2, b = -1, c = T + 1, l = (1 << c) - 1, x = 0; x < s; x++)
    g[x] = 0, p[x] = x;
  var d, w, m, y, P, E;
  for (d = w = m = y = P = E = 0, D = 0; D < i; ) {
    if (y === 0) {
      if (w < c) {
        d += t[E] << w, w += 8, E++;
        continue;
      }
      if (x = d & l, d >>= c, w -= c, x > a || x == u)
        break;
      if (x == s) {
        c = T + 1, l = (1 << c) - 1, a = s + 2, b = -1;
        continue;
      }
      if (b == -1) {
        A[y++] = p[x], b = x, m = x;
        continue;
      }
      for (h = x, x == a && (A[y++] = m, x = b); x > s; )
        A[y++] = p[x], x = g[x];
      m = p[x] & 255, A[y++] = m, a < 4096 && (g[a] = b, p[a] = m, a++, !(a & l) && a < 4096 && (c++, l += a)), b = h;
    }
    y--, z[P++] = A[y], D++;
  }
  for (D = P; D < i; D++)
    z[D] = 0;
  return z;
}, Ze = (o) => {
  const t = new Uint8Array(o);
  return bt(Oe(t), He);
}, Ve = (o) => {
  const t = o.pixels.length, e = new Uint8ClampedArray(t * 4);
  for (var r = 0; r < t; r++) {
    const n = r * 4, i = o.pixels[r], a = o.colorTable[i];
    e[n] = a[0], e[n + 1] = a[1], e[n + 2] = a[2], e[n + 3] = i !== o.transparentIndex ? 255 : 0;
  }
  return e;
}, Je = (o, t, e) => {
  if (!o.image) {
    console.warn("gif frame does not have associated image.");
    return;
  }
  const { image: r } = o, n = r.descriptor.width * r.descriptor.height;
  var i = Xe(r.data.minCodeSize, r.data.blocks, n);
  r.descriptor.lct.interlaced && (i = Ke(i, r.descriptor.width));
  const a = {
    pixels: i,
    dims: {
      top: o.image.descriptor.top,
      left: o.image.descriptor.left,
      width: o.image.descriptor.width,
      height: o.image.descriptor.height
    }
  };
  return r.descriptor.lct && r.descriptor.lct.exists ? a.colorTable = r.lct : a.colorTable = t, o.gce && (a.delay = (o.gce.delay || 10) * 10, a.disposalType = o.gce.extras.disposal, o.gce.extras.transparentColorGiven && (a.transparentIndex = o.gce.transparentColorIndex)), a.patch = Ve(a), a;
}, We = (o, t) => o.frames.filter((e) => e.image).map((e) => Je(e, o.gct));
function Ye(o, t, e) {
  const r = se(t), n = o - 1;
  let i = 0;
  switch (e) {
    case Z.L:
      i = rt[n][0];
      break;
    case Z.M:
      i = rt[n][1];
      break;
    case Z.Q:
      i = rt[n][2];
      break;
    case Z.H:
      i = rt[n][3];
      break;
  }
  return r <= i;
}
function qe(o, t) {
  for (var e = 1, r = se(o), n = 0, i = rt.length; n < i; n++) {
    var a = 0;
    switch (t) {
      case Z.L:
        a = rt[n][0];
        break;
      case Z.M:
        a = rt[n][1];
        break;
      case Z.Q:
        a = rt[n][2];
        break;
      case Z.H:
        a = rt[n][3];
        break;
    }
    if (r <= a)
      break;
    e++;
  }
  if (e > rt.length)
    throw new Error("Too long data");
  return e;
}
function se(o) {
  var t = encodeURI(o).toString().replace(/\%[0-9a-fA-F]{2}/g, "a");
  return t.length + (t.length != Number(o) ? 3 : 0);
}
class Qe {
  constructor(t) {
    this.mode = J.MODE_8BIT_BYTE, this.parsedData = [], this.data = t;
    const e = [];
    for (let r = 0, n = this.data.length; r < n; r++) {
      const i = [], a = this.data.charCodeAt(r);
      a > 65536 ? (i[0] = 240 | (a & 1835008) >>> 18, i[1] = 128 | (a & 258048) >>> 12, i[2] = 128 | (a & 4032) >>> 6, i[3] = 128 | a & 63) : a > 2048 ? (i[0] = 224 | (a & 61440) >>> 12, i[1] = 128 | (a & 4032) >>> 6, i[2] = 128 | a & 63) : a > 128 ? (i[0] = 192 | (a & 1984) >>> 6, i[1] = 128 | a & 63) : i[0] = a, e.push(i);
    }
    this.parsedData = Array.prototype.concat.apply([], e), this.parsedData.length != this.data.length && (this.parsedData.unshift(191), this.parsedData.unshift(187), this.parsedData.unshift(239));
  }
  getLength() {
    return this.parsedData.length;
  }
  write(t) {
    for (let e = 0, r = this.parsedData.length; e < r; e++)
      t.put(this.parsedData[e], 8);
  }
}
class ct {
  constructor(t = -1, e = Z.L) {
    this.moduleCount = 0, this.dataList = [], this.typeNumber = t, this.errorCorrectLevel = e, this.moduleCount = 0, this.dataList = [];
  }
  addData(t) {
    if (this.typeNumber <= 0)
      this.typeNumber = qe(t, this.errorCorrectLevel);
    else {
      if (this.typeNumber > 40)
        throw new Error(`Invalid QR version: ${this.typeNumber}`);
      if (!Ye(this.typeNumber, t, this.errorCorrectLevel))
        throw new Error(`Data is too long for QR version: ${this.typeNumber}`);
    }
    const e = new Qe(t);
    this.dataList.push(e), this.dataCache = void 0;
  }
  isDark(t, e) {
    if (t < 0 || this.moduleCount <= t || e < 0 || this.moduleCount <= e)
      throw new Error(`${t},${e}`);
    return this.modules[t][e];
  }
  getModuleCount() {
    return this.moduleCount;
  }
  make() {
    this.makeImpl(!1, this.getBestMaskPattern());
  }
  makeImpl(t, e) {
    this.moduleCount = this.typeNumber * 4 + 17, this.modules = new Array(this.moduleCount);
    for (let r = 0; r < this.moduleCount; r++) {
      this.modules[r] = new Array(this.moduleCount);
      for (let n = 0; n < this.moduleCount; n++)
        this.modules[r][n] = null;
    }
    this.setupPositionProbePattern(0, 0), this.setupPositionProbePattern(this.moduleCount - 7, 0), this.setupPositionProbePattern(0, this.moduleCount - 7), this.setupPositionAdjustPattern(), this.setupTimingPattern(), this.setupTypeInfo(t, e), this.typeNumber >= 7 && this.setupTypeNumber(t), this.dataCache == null && (this.dataCache = ct.createData(this.typeNumber, this.errorCorrectLevel, this.dataList)), this.mapData(this.dataCache, e);
  }
  setupPositionProbePattern(t, e) {
    for (let r = -1; r <= 7; r++)
      if (!(t + r <= -1 || this.moduleCount <= t + r))
        for (let n = -1; n <= 7; n++)
          e + n <= -1 || this.moduleCount <= e + n || (0 <= r && r <= 6 && (n == 0 || n == 6) || 0 <= n && n <= 6 && (r == 0 || r == 6) || 2 <= r && r <= 4 && 2 <= n && n <= 4 ? this.modules[t + r][e + n] = !0 : this.modules[t + r][e + n] = !1);
  }
  getBestMaskPattern() {
    if (Number.isInteger(this.maskPattern) && Object.values(ot).includes(this.maskPattern))
      return this.maskPattern;
    let t = 0, e = 0;
    for (let r = 0; r < 8; r++) {
      this.makeImpl(!0, r);
      const n = M.getLostPoint(this);
      (r == 0 || t > n) && (t = n, e = r);
    }
    return e;
  }
  setupTimingPattern() {
    for (let t = 8; t < this.moduleCount - 8; t++)
      this.modules[t][6] == null && (this.modules[t][6] = t % 2 == 0);
    for (let t = 8; t < this.moduleCount - 8; t++)
      this.modules[6][t] == null && (this.modules[6][t] = t % 2 == 0);
  }
  setupPositionAdjustPattern() {
    const t = M.getPatternPosition(this.typeNumber);
    for (let e = 0; e < t.length; e++)
      for (let r = 0; r < t.length; r++) {
        const n = t[e], i = t[r];
        if (this.modules[n][i] == null)
          for (let a = -2; a <= 2; a++)
            for (let s = -2; s <= 2; s++)
              a == -2 || a == 2 || s == -2 || s == 2 || a == 0 && s == 0 ? this.modules[n + a][i + s] = !0 : this.modules[n + a][i + s] = !1;
      }
  }
  setupTypeNumber(t) {
    const e = M.getBCHTypeNumber(this.typeNumber);
    for (var r = 0; r < 18; r++) {
      var n = !t && (e >> r & 1) == 1;
      this.modules[Math.floor(r / 3)][r % 3 + this.moduleCount - 8 - 3] = n;
    }
    for (var r = 0; r < 18; r++) {
      var n = !t && (e >> r & 1) == 1;
      this.modules[r % 3 + this.moduleCount - 8 - 3][Math.floor(r / 3)] = n;
    }
  }
  setupTypeInfo(t, e) {
    const r = this.errorCorrectLevel << 3 | e, n = M.getBCHTypeInfo(r);
    for (var i = 0; i < 15; i++) {
      var a = !t && (n >> i & 1) == 1;
      i < 6 ? this.modules[i][8] = a : i < 8 ? this.modules[i + 1][8] = a : this.modules[this.moduleCount - 15 + i][8] = a;
    }
    for (var i = 0; i < 15; i++) {
      var a = !t && (n >> i & 1) == 1;
      i < 8 ? this.modules[8][this.moduleCount - i - 1] = a : i < 9 ? this.modules[8][15 - i - 1 + 1] = a : this.modules[8][15 - i - 1] = a;
    }
    this.modules[this.moduleCount - 8][8] = !t;
  }
  mapData(t, e) {
    let r = -1, n = this.moduleCount - 1, i = 7, a = 0;
    for (let s = this.moduleCount - 1; s > 0; s -= 2)
      for (s == 6 && s--; ; ) {
        for (let l = 0; l < 2; l++)
          if (this.modules[n][s - l] == null) {
            let c = !1;
            a < t.length && (c = (t[a] >>> i & 1) == 1), M.getMask(e, n, s - l) && (c = !c), this.modules[n][s - l] = c, i--, i == -1 && (a++, i = 7);
          }
        if (n += r, n < 0 || this.moduleCount <= n) {
          n -= r, r = -r;
          break;
        }
      }
  }
  static createData(t, e, r) {
    const n = at.getRSBlocks(t, e), i = new tr();
    for (var a = 0; a < r.length; a++) {
      const l = r[a];
      i.put(l.mode, 4), i.put(l.getLength(), M.getLengthInBits(l.mode, t)), l.write(i);
    }
    let s = 0;
    for (var a = 0; a < n.length; a++)
      s += n[a].dataCount;
    if (i.getLengthInBits() > s * 8)
      throw new Error(`code length overflow. (${i.getLengthInBits()}>${s * 8})`);
    for (i.getLengthInBits() + 4 <= s * 8 && i.put(0, 4); i.getLengthInBits() % 8 != 0; )
      i.putBit(!1);
    for (; !(i.getLengthInBits() >= s * 8 || (i.put(ct.PAD0, 8), i.getLengthInBits() >= s * 8)); )
      i.put(ct.PAD1, 8);
    return ct.createBytes(i, n);
  }
  static createBytes(t, e) {
    let r = 0, n = 0, i = 0;
    const a = new Array(e.length), s = new Array(e.length);
    for (var l = 0; l < e.length; l++) {
      const x = e[l].dataCount, D = e[l].totalCount - x;
      n = Math.max(n, x), i = Math.max(i, D), a[l] = new Array(x);
      for (var c = 0; c < a[l].length; c++)
        a[l][c] = 255 & t.buffer[c + r];
      r += x;
      const T = M.getErrorCorrectPolynomial(D), g = new pt(a[l], T.getLength() - 1).mod(T);
      s[l] = new Array(T.getLength() - 1);
      for (var c = 0; c < s[l].length; c++) {
        const A = c + g.getLength() - s[l].length;
        s[l][c] = A >= 0 ? g.get(A) : 0;
      }
    }
    let u = 0;
    for (var c = 0; c < e.length; c++)
      u += e[c].totalCount;
    const h = new Array(u);
    let b = 0;
    for (var c = 0; c < n; c++)
      for (var l = 0; l < e.length; l++)
        c < a[l].length && (h[b++] = a[l][c]);
    for (var c = 0; c < i; c++)
      for (var l = 0; l < e.length; l++)
        c < s[l].length && (h[b++] = s[l][c]);
    return h;
  }
}
ct.PAD0 = 236;
ct.PAD1 = 17;
const Z = { L: 1, M: 0, Q: 3, H: 2 }, J = { MODE_NUMBER: 1, MODE_ALPHA_NUM: 2, MODE_8BIT_BYTE: 4, MODE_KANJI: 8 }, ot = {
  PATTERN000: 0,
  PATTERN001: 1,
  PATTERN010: 2,
  PATTERN011: 3,
  PATTERN100: 4,
  PATTERN101: 5,
  PATTERN110: 6,
  PATTERN111: 7
};
class M {
  static getBCHTypeInfo(t) {
    let e = t << 10;
    for (; M.getBCHDigit(e) - M.getBCHDigit(M.G15) >= 0; )
      e ^= M.G15 << M.getBCHDigit(e) - M.getBCHDigit(M.G15);
    return (t << 10 | e) ^ M.G15_MASK;
  }
  static getBCHTypeNumber(t) {
    let e = t << 12;
    for (; M.getBCHDigit(e) - M.getBCHDigit(M.G18) >= 0; )
      e ^= M.G18 << M.getBCHDigit(e) - M.getBCHDigit(M.G18);
    return t << 12 | e;
  }
  static getBCHDigit(t) {
    let e = 0;
    for (; t != 0; )
      e++, t >>>= 1;
    return e;
  }
  static getPatternPosition(t) {
    return M.PATTERN_POSITION_TABLE[t - 1];
  }
  static getMask(t, e, r) {
    switch (t) {
      case ot.PATTERN000:
        return (e + r) % 2 == 0;
      case ot.PATTERN001:
        return e % 2 == 0;
      case ot.PATTERN010:
        return r % 3 == 0;
      case ot.PATTERN011:
        return (e + r) % 3 == 0;
      case ot.PATTERN100:
        return (Math.floor(e / 2) + Math.floor(r / 3)) % 2 == 0;
      case ot.PATTERN101:
        return e * r % 2 + e * r % 3 == 0;
      case ot.PATTERN110:
        return (e * r % 2 + e * r % 3) % 2 == 0;
      case ot.PATTERN111:
        return (e * r % 3 + (e + r) % 2) % 2 == 0;
      default:
        throw new Error(`bad maskPattern:${t}`);
    }
  }
  static getErrorCorrectPolynomial(t) {
    let e = new pt([1], 0);
    for (let r = 0; r < t; r++)
      e = e.multiply(new pt([1, G.gexp(r)], 0));
    return e;
  }
  static getLengthInBits(t, e) {
    if (1 <= e && e < 10)
      switch (t) {
        case J.MODE_NUMBER:
          return 10;
        case J.MODE_ALPHA_NUM:
          return 9;
        case J.MODE_8BIT_BYTE:
          return 8;
        case J.MODE_KANJI:
          return 8;
        default:
          throw new Error(`mode:${t}`);
      }
    else if (e < 27)
      switch (t) {
        case J.MODE_NUMBER:
          return 12;
        case J.MODE_ALPHA_NUM:
          return 11;
        case J.MODE_8BIT_BYTE:
          return 16;
        case J.MODE_KANJI:
          return 10;
        default:
          throw new Error(`mode:${t}`);
      }
    else if (e < 41)
      switch (t) {
        case J.MODE_NUMBER:
          return 14;
        case J.MODE_ALPHA_NUM:
          return 13;
        case J.MODE_8BIT_BYTE:
          return 16;
        case J.MODE_KANJI:
          return 12;
        default:
          throw new Error(`mode:${t}`);
      }
    else
      throw new Error(`type:${e}`);
  }
  static getLostPoint(t) {
    const e = t.getModuleCount();
    let r = 0;
    for (var n = 0; n < e; n++)
      for (var i = 0; i < e; i++) {
        let l = 0;
        const c = t.isDark(n, i);
        for (let u = -1; u <= 1; u++)
          if (!(n + u < 0 || e <= n + u))
            for (let h = -1; h <= 1; h++)
              i + h < 0 || e <= i + h || u == 0 && h == 0 || c == t.isDark(n + u, i + h) && l++;
        l > 5 && (r += 3 + l - 5);
      }
    for (var n = 0; n < e - 1; n++)
      for (var i = 0; i < e - 1; i++) {
        let u = 0;
        t.isDark(n, i) && u++, t.isDark(n + 1, i) && u++, t.isDark(n, i + 1) && u++, t.isDark(n + 1, i + 1) && u++, (u == 0 || u == 4) && (r += 3);
      }
    for (var n = 0; n < e; n++)
      for (var i = 0; i < e - 6; i++)
        t.isDark(n, i) && !t.isDark(n, i + 1) && t.isDark(n, i + 2) && t.isDark(n, i + 3) && t.isDark(n, i + 4) && !t.isDark(n, i + 5) && t.isDark(n, i + 6) && (r += 40);
    for (var i = 0; i < e; i++)
      for (var n = 0; n < e - 6; n++)
        t.isDark(n, i) && !t.isDark(n + 1, i) && t.isDark(n + 2, i) && t.isDark(n + 3, i) && t.isDark(n + 4, i) && !t.isDark(n + 5, i) && t.isDark(n + 6, i) && (r += 40);
    let a = 0;
    for (var i = 0; i < e; i++)
      for (var n = 0; n < e; n++)
        t.isDark(n, i) && a++;
    const s = Math.abs(100 * a / e / e - 50) / 5;
    return r += s * 10, r;
  }
}
M.PATTERN_POSITION_TABLE = [
  [],
  [6, 18],
  [6, 22],
  [6, 26],
  [6, 30],
  [6, 34],
  [6, 22, 38],
  [6, 24, 42],
  [6, 26, 46],
  [6, 28, 50],
  [6, 30, 54],
  [6, 32, 58],
  [6, 34, 62],
  [6, 26, 46, 66],
  [6, 26, 48, 70],
  [6, 26, 50, 74],
  [6, 30, 54, 78],
  [6, 30, 56, 82],
  [6, 30, 58, 86],
  [6, 34, 62, 90],
  [6, 28, 50, 72, 94],
  [6, 26, 50, 74, 98],
  [6, 30, 54, 78, 102],
  [6, 28, 54, 80, 106],
  [6, 32, 58, 84, 110],
  [6, 30, 58, 86, 114],
  [6, 34, 62, 90, 118],
  [6, 26, 50, 74, 98, 122],
  [6, 30, 54, 78, 102, 126],
  [6, 26, 52, 78, 104, 130],
  [6, 30, 56, 82, 108, 134],
  [6, 34, 60, 86, 112, 138],
  [6, 30, 58, 86, 114, 142],
  [6, 34, 62, 90, 118, 146],
  [6, 30, 54, 78, 102, 126, 150],
  [6, 24, 50, 76, 102, 128, 154],
  [6, 28, 54, 80, 106, 132, 158],
  [6, 32, 58, 84, 110, 136, 162],
  [6, 26, 54, 82, 110, 138, 166],
  [6, 30, 58, 86, 114, 142, 170]
];
M.G15 = 1335;
M.G18 = 7973;
M.G15_MASK = 21522;
class G {
  static glog(t) {
    if (t < 1)
      throw new Error(`glog(${t})`);
    return G.LOG_TABLE[t];
  }
  static gexp(t) {
    for (; t < 0; )
      t += 255;
    for (; t >= 256; )
      t -= 255;
    return G.EXP_TABLE[t];
  }
}
G.EXP_TABLE = new Array(256);
G.LOG_TABLE = new Array(256);
G._constructor = function() {
  for (var o = 0; o < 8; o++)
    G.EXP_TABLE[o] = 1 << o;
  for (var o = 8; o < 256; o++)
    G.EXP_TABLE[o] = G.EXP_TABLE[o - 4] ^ G.EXP_TABLE[o - 5] ^ G.EXP_TABLE[o - 6] ^ G.EXP_TABLE[o - 8];
  for (var o = 0; o < 255; o++)
    G.LOG_TABLE[G.EXP_TABLE[o]] = o;
}();
class pt {
  constructor(t, e) {
    if (t.length == null)
      throw new Error(`${t.length}/${e}`);
    let r = 0;
    for (; r < t.length && t[r] == 0; )
      r++;
    this.num = new Array(t.length - r + e);
    for (let n = 0; n < t.length - r; n++)
      this.num[n] = t[n + r];
  }
  get(t) {
    return this.num[t];
  }
  getLength() {
    return this.num.length;
  }
  multiply(t) {
    const e = new Array(this.getLength() + t.getLength() - 1);
    for (let r = 0; r < this.getLength(); r++)
      for (let n = 0; n < t.getLength(); n++)
        e[r + n] ^= G.gexp(G.glog(this.get(r)) + G.glog(t.get(n)));
    return new pt(e, 0);
  }
  mod(t) {
    if (this.getLength() - t.getLength() < 0)
      return this;
    const e = G.glog(this.get(0)) - G.glog(t.get(0)), r = new Array(this.getLength());
    for (var n = 0; n < this.getLength(); n++)
      r[n] = this.get(n);
    for (var n = 0; n < t.getLength(); n++)
      r[n] ^= G.gexp(G.glog(t.get(n)) + e);
    return new pt(r, 0).mod(t);
  }
}
class at {
  constructor(t, e) {
    this.totalCount = t, this.dataCount = e;
  }
  static getRSBlocks(t, e) {
    const r = at.getRsBlockTable(t, e);
    if (r == null)
      throw new Error(`bad rs block @ typeNumber:${t}/errorCorrectLevel:${e}`);
    const n = r.length / 3, i = [];
    for (let a = 0; a < n; a++) {
      const s = r[a * 3 + 0], l = r[a * 3 + 1], c = r[a * 3 + 2];
      for (let u = 0; u < s; u++)
        i.push(new at(l, c));
    }
    return i;
  }
  static getRsBlockTable(t, e) {
    switch (e) {
      case Z.L:
        return at.RS_BLOCK_TABLE[(t - 1) * 4 + 0];
      case Z.M:
        return at.RS_BLOCK_TABLE[(t - 1) * 4 + 1];
      case Z.Q:
        return at.RS_BLOCK_TABLE[(t - 1) * 4 + 2];
      case Z.H:
        return at.RS_BLOCK_TABLE[(t - 1) * 4 + 3];
      default:
        return;
    }
  }
}
at.RS_BLOCK_TABLE = [
  [1, 26, 19],
  [1, 26, 16],
  [1, 26, 13],
  [1, 26, 9],
  [1, 44, 34],
  [1, 44, 28],
  [1, 44, 22],
  [1, 44, 16],
  [1, 70, 55],
  [1, 70, 44],
  [2, 35, 17],
  [2, 35, 13],
  [1, 100, 80],
  [2, 50, 32],
  [2, 50, 24],
  [4, 25, 9],
  [1, 134, 108],
  [2, 67, 43],
  [2, 33, 15, 2, 34, 16],
  [2, 33, 11, 2, 34, 12],
  [2, 86, 68],
  [4, 43, 27],
  [4, 43, 19],
  [4, 43, 15],
  [2, 98, 78],
  [4, 49, 31],
  [2, 32, 14, 4, 33, 15],
  [4, 39, 13, 1, 40, 14],
  [2, 121, 97],
  [2, 60, 38, 2, 61, 39],
  [4, 40, 18, 2, 41, 19],
  [4, 40, 14, 2, 41, 15],
  [2, 146, 116],
  [3, 58, 36, 2, 59, 37],
  [4, 36, 16, 4, 37, 17],
  [4, 36, 12, 4, 37, 13],
  [2, 86, 68, 2, 87, 69],
  [4, 69, 43, 1, 70, 44],
  [6, 43, 19, 2, 44, 20],
  [6, 43, 15, 2, 44, 16],
  [4, 101, 81],
  [1, 80, 50, 4, 81, 51],
  [4, 50, 22, 4, 51, 23],
  [3, 36, 12, 8, 37, 13],
  [2, 116, 92, 2, 117, 93],
  [6, 58, 36, 2, 59, 37],
  [4, 46, 20, 6, 47, 21],
  [7, 42, 14, 4, 43, 15],
  [4, 133, 107],
  [8, 59, 37, 1, 60, 38],
  [8, 44, 20, 4, 45, 21],
  [12, 33, 11, 4, 34, 12],
  [3, 145, 115, 1, 146, 116],
  [4, 64, 40, 5, 65, 41],
  [11, 36, 16, 5, 37, 17],
  [11, 36, 12, 5, 37, 13],
  [5, 109, 87, 1, 110, 88],
  [5, 65, 41, 5, 66, 42],
  [5, 54, 24, 7, 55, 25],
  [11, 36, 12],
  [5, 122, 98, 1, 123, 99],
  [7, 73, 45, 3, 74, 46],
  [15, 43, 19, 2, 44, 20],
  [3, 45, 15, 13, 46, 16],
  [1, 135, 107, 5, 136, 108],
  [10, 74, 46, 1, 75, 47],
  [1, 50, 22, 15, 51, 23],
  [2, 42, 14, 17, 43, 15],
  [5, 150, 120, 1, 151, 121],
  [9, 69, 43, 4, 70, 44],
  [17, 50, 22, 1, 51, 23],
  [2, 42, 14, 19, 43, 15],
  [3, 141, 113, 4, 142, 114],
  [3, 70, 44, 11, 71, 45],
  [17, 47, 21, 4, 48, 22],
  [9, 39, 13, 16, 40, 14],
  [3, 135, 107, 5, 136, 108],
  [3, 67, 41, 13, 68, 42],
  [15, 54, 24, 5, 55, 25],
  [15, 43, 15, 10, 44, 16],
  [4, 144, 116, 4, 145, 117],
  [17, 68, 42],
  [17, 50, 22, 6, 51, 23],
  [19, 46, 16, 6, 47, 17],
  [2, 139, 111, 7, 140, 112],
  [17, 74, 46],
  [7, 54, 24, 16, 55, 25],
  [34, 37, 13],
  [4, 151, 121, 5, 152, 122],
  [4, 75, 47, 14, 76, 48],
  [11, 54, 24, 14, 55, 25],
  [16, 45, 15, 14, 46, 16],
  [6, 147, 117, 4, 148, 118],
  [6, 73, 45, 14, 74, 46],
  [11, 54, 24, 16, 55, 25],
  [30, 46, 16, 2, 47, 17],
  [8, 132, 106, 4, 133, 107],
  [8, 75, 47, 13, 76, 48],
  [7, 54, 24, 22, 55, 25],
  [22, 45, 15, 13, 46, 16],
  [10, 142, 114, 2, 143, 115],
  [19, 74, 46, 4, 75, 47],
  [28, 50, 22, 6, 51, 23],
  [33, 46, 16, 4, 47, 17],
  [8, 152, 122, 4, 153, 123],
  [22, 73, 45, 3, 74, 46],
  [8, 53, 23, 26, 54, 24],
  [12, 45, 15, 28, 46, 16],
  [3, 147, 117, 10, 148, 118],
  [3, 73, 45, 23, 74, 46],
  [4, 54, 24, 31, 55, 25],
  [11, 45, 15, 31, 46, 16],
  [7, 146, 116, 7, 147, 117],
  [21, 73, 45, 7, 74, 46],
  [1, 53, 23, 37, 54, 24],
  [19, 45, 15, 26, 46, 16],
  [5, 145, 115, 10, 146, 116],
  [19, 75, 47, 10, 76, 48],
  [15, 54, 24, 25, 55, 25],
  [23, 45, 15, 25, 46, 16],
  [13, 145, 115, 3, 146, 116],
  [2, 74, 46, 29, 75, 47],
  [42, 54, 24, 1, 55, 25],
  [23, 45, 15, 28, 46, 16],
  [17, 145, 115],
  [10, 74, 46, 23, 75, 47],
  [10, 54, 24, 35, 55, 25],
  [19, 45, 15, 35, 46, 16],
  [17, 145, 115, 1, 146, 116],
  [14, 74, 46, 21, 75, 47],
  [29, 54, 24, 19, 55, 25],
  [11, 45, 15, 46, 46, 16],
  [13, 145, 115, 6, 146, 116],
  [14, 74, 46, 23, 75, 47],
  [44, 54, 24, 7, 55, 25],
  [59, 46, 16, 1, 47, 17],
  [12, 151, 121, 7, 152, 122],
  [12, 75, 47, 26, 76, 48],
  [39, 54, 24, 14, 55, 25],
  [22, 45, 15, 41, 46, 16],
  [6, 151, 121, 14, 152, 122],
  [6, 75, 47, 34, 76, 48],
  [46, 54, 24, 10, 55, 25],
  [2, 45, 15, 64, 46, 16],
  [17, 152, 122, 4, 153, 123],
  [29, 74, 46, 14, 75, 47],
  [49, 54, 24, 10, 55, 25],
  [24, 45, 15, 46, 46, 16],
  [4, 152, 122, 18, 153, 123],
  [13, 74, 46, 32, 75, 47],
  [48, 54, 24, 14, 55, 25],
  [42, 45, 15, 32, 46, 16],
  [20, 147, 117, 4, 148, 118],
  [40, 75, 47, 7, 76, 48],
  [43, 54, 24, 22, 55, 25],
  [10, 45, 15, 67, 46, 16],
  [19, 148, 118, 6, 149, 119],
  [18, 75, 47, 31, 76, 48],
  [34, 54, 24, 34, 55, 25],
  [20, 45, 15, 61, 46, 16]
];
class tr {
  constructor() {
    this.buffer = [], this.length = 0;
  }
  get(t) {
    const e = Math.floor(t / 8);
    return (this.buffer[e] >>> 7 - t % 8 & 1) == 1;
  }
  put(t, e) {
    for (let r = 0; r < e; r++)
      this.putBit((t >>> e - r - 1 & 1) == 1);
  }
  getLengthInBits() {
    return this.length;
  }
  putBit(t) {
    const e = Math.floor(this.length / 8);
    this.buffer.length <= e && this.buffer.push(0), t && (this.buffer[e] |= 128 >>> this.length % 8), this.length++;
  }
}
const rt = [
  [17, 14, 11, 7],
  [32, 26, 20, 14],
  [53, 42, 32, 24],
  [78, 62, 46, 34],
  [106, 84, 60, 44],
  [134, 106, 74, 58],
  [154, 122, 86, 64],
  [192, 152, 108, 84],
  [230, 180, 130, 98],
  [271, 213, 151, 119],
  [321, 251, 177, 137],
  [367, 287, 203, 155],
  [425, 331, 241, 177],
  [458, 362, 258, 194],
  [520, 412, 292, 220],
  [586, 450, 322, 250],
  [644, 504, 364, 280],
  [718, 560, 394, 310],
  [792, 624, 442, 338],
  [858, 666, 482, 382],
  [929, 711, 509, 403],
  [1003, 779, 565, 439],
  [1091, 857, 611, 461],
  [1171, 911, 661, 511],
  [1273, 997, 715, 535],
  [1367, 1059, 751, 593],
  [1465, 1125, 805, 625],
  [1528, 1190, 868, 658],
  [1628, 1264, 908, 698],
  [1732, 1370, 982, 742],
  [1840, 1452, 1030, 790],
  [1952, 1538, 1112, 842],
  [2068, 1628, 1168, 898],
  [2188, 1722, 1228, 958],
  [2303, 1809, 1283, 983],
  [2431, 1911, 1351, 1051],
  [2563, 1989, 1423, 1093],
  [2699, 2099, 1499, 1139],
  [2809, 2213, 1579, 1219],
  [2953, 2331, 1663, 1273]
];
var er = 100, K = 256, Jt = K - 1, lt = 4, le = 16, zt = 1 << le, ce = 10, jt = 10, rr = zt >> jt, nr = zt << ce - jt, ir = K >> 3, Nt = 6, or = 1 << Nt, ar = ir * or, sr = 30, fe = 10, yt = 1 << fe, ue = 8, Wt = 1 << ue, lr = fe + ue, gt = 1 << lr, Yt = 499, qt = 491, Qt = 487, he = 503, cr = 3 * he;
function fr(o, t) {
  var e, r, n, i, a;
  function s() {
    e = [], r = new Int32Array(256), n = new Int32Array(K), i = new Int32Array(K), a = new Int32Array(K >> 3);
    var g, p;
    for (g = 0; g < K; g++)
      p = (g << lt + 8) / K, e[g] = new Float64Array([p, p, p, 0]), i[g] = zt / K, n[g] = 0;
  }
  function l() {
    for (var g = 0; g < K; g++)
      e[g][0] >>= lt, e[g][1] >>= lt, e[g][2] >>= lt, e[g][3] = g;
  }
  function c(g, p, A, d, w) {
    e[p][0] -= g * (e[p][0] - A) / yt, e[p][1] -= g * (e[p][1] - d) / yt, e[p][2] -= g * (e[p][2] - w) / yt;
  }
  function u(g, p, A, d, w) {
    for (var m = Math.abs(p - g), y = Math.min(p + g, K), P = p + 1, E = p - 1, _ = 1, f, F; P < y || E > m; )
      F = a[_++], P < y && (f = e[P++], f[0] -= F * (f[0] - A) / gt, f[1] -= F * (f[1] - d) / gt, f[2] -= F * (f[2] - w) / gt), E > m && (f = e[E--], f[0] -= F * (f[0] - A) / gt, f[1] -= F * (f[1] - d) / gt, f[2] -= F * (f[2] - w) / gt);
  }
  function h(g, p, A) {
    var d = 2147483647, w = d, m = -1, y = m, P, E, _, f, F;
    for (P = 0; P < K; P++)
      E = e[P], _ = Math.abs(E[0] - g) + Math.abs(E[1] - p) + Math.abs(E[2] - A), _ < d && (d = _, m = P), f = _ - (n[P] >> le - lt), f < w && (w = f, y = P), F = i[P] >> jt, i[P] -= F, n[P] += F << ce;
    return i[m] += rr, n[m] -= nr, y;
  }
  function b() {
    var g, p, A, d, w, m, y = 0, P = 0;
    for (g = 0; g < K; g++) {
      for (A = e[g], w = g, m = A[1], p = g + 1; p < K; p++)
        d = e[p], d[1] < m && (w = p, m = d[1]);
      if (d = e[w], g != w && (p = d[0], d[0] = A[0], A[0] = p, p = d[1], d[1] = A[1], A[1] = p, p = d[2], d[2] = A[2], A[2] = p, p = d[3], d[3] = A[3], A[3] = p), m != y) {
        for (r[y] = P + g >> 1, p = y + 1; p < m; p++)
          r[p] = g;
        y = m, P = g;
      }
    }
    for (r[y] = P + Jt >> 1, p = y + 1; p < 256; p++)
      r[p] = Jt;
  }
  function x(g, p, A) {
    for (var d, w, m, y = 1e3, P = -1, E = r[p], _ = E - 1; E < K || _ >= 0; )
      E < K && (w = e[E], m = w[1] - p, m >= y ? E = K : (E++, m < 0 && (m = -m), d = w[0] - g, d < 0 && (d = -d), m += d, m < y && (d = w[2] - A, d < 0 && (d = -d), m += d, m < y && (y = m, P = w[3])))), _ >= 0 && (w = e[_], m = p - w[1], m >= y ? _ = -1 : (_--, m < 0 && (m = -m), d = w[0] - g, d < 0 && (d = -d), m += d, m < y && (d = w[2] - A, d < 0 && (d = -d), m += d, m < y && (y = m, P = w[3]))));
    return P;
  }
  function D() {
    var g, p = o.length, A = 30 + (t - 1) / 3, d = p / (3 * t), w = ~~(d / er), m = yt, y = ar, P = y >> Nt;
    for (P <= 1 && (P = 0), g = 0; g < P; g++)
      a[g] = m * ((P * P - g * g) * Wt / (P * P));
    var E;
    p < cr ? (t = 1, E = 3) : p % Yt !== 0 ? E = 3 * Yt : p % qt !== 0 ? E = 3 * qt : p % Qt !== 0 ? E = 3 * Qt : E = 3 * he;
    var _, f, F, C, N = 0;
    for (g = 0; g < d; )
      if (_ = (o[N] & 255) << lt, f = (o[N + 1] & 255) << lt, F = (o[N + 2] & 255) << lt, C = h(_, f, F), c(m, C, _, f, F), P !== 0 && u(P, C, _, f, F), N += E, N >= p && (N -= p), g++, w === 0 && (w = 1), g % w === 0)
        for (m -= m / A, y -= y / sr, P = y >> Nt, P <= 1 && (P = 0), C = 0; C < P; C++)
          a[C] = m * ((P * P - C * C) * Wt / (P * P));
  }
  function T() {
    s(), D(), l(), b();
  }
  this.buildColormap = T;
  function z() {
    for (var g = [], p = [], A = 0; A < K; A++)
      p[e[A][3]] = A;
    for (var d = 0, w = 0; w < K; w++) {
      var m = p[w];
      g[d++] = e[m][0], g[d++] = e[m][1], g[d++] = e[m][2];
    }
    return g;
  }
  this.getColormap = z, this.lookupRGB = x;
}
var te = -1, Ct = 12, vt = 5003, ur = [
  0,
  1,
  3,
  7,
  15,
  31,
  63,
  127,
  255,
  511,
  1023,
  2047,
  4095,
  8191,
  16383,
  32767,
  65535
];
function hr(o, t, e, r) {
  var n = Math.max(2, r), i = new Uint8Array(256), a = new Int32Array(vt), s = new Int32Array(vt), l, c = 0, u, h = 0, b, x = !1, D, T, z, g, p, A;
  function d(C, N) {
    i[u++] = C, u >= 254 && E(N);
  }
  function w(C) {
    m(vt), h = T + 2, x = !0, F(T, C);
  }
  function m(C) {
    for (var N = 0; N < C; ++N)
      a[N] = -1;
  }
  function y(C, N) {
    var v, ft, j, q, st, U, Q;
    for (D = C, x = !1, A = D, b = _(A), T = 1 << C - 1, z = T + 1, h = T + 2, u = 0, q = f(), Q = 0, v = vt; v < 65536; v *= 2)
      ++Q;
    Q = 8 - Q, U = vt, m(U), F(T, N);
    t: for (; (ft = f()) != te; ) {
      if (v = (ft << Ct) + q, j = ft << Q ^ q, a[j] === v) {
        q = s[j];
        continue;
      } else if (a[j] >= 0) {
        st = U - j, j === 0 && (st = 1);
        do
          if ((j -= st) < 0 && (j += U), a[j] === v) {
            q = s[j];
            continue t;
          }
        while (a[j] >= 0);
      }
      F(q, N), q = ft, h < 1 << Ct ? (s[j] = h++, a[j] = v) : w(N);
    }
    F(q, N), F(z, N);
  }
  function P(C) {
    C.writeByte(n), g = o * t, p = 0, y(n + 1, C), C.writeByte(0);
  }
  function E(C) {
    u > 0 && (C.writeByte(u), C.writeBytes(i, 0, u), u = 0);
  }
  function _(C) {
    return (1 << C) - 1;
  }
  function f() {
    if (g === 0)
      return te;
    --g;
    var C = e[p++];
    return C & 255;
  }
  function F(C, N) {
    for (l &= ur[c], c > 0 ? l |= C << c : l = C, c += A; c >= 8; )
      d(l & 255, N), l >>= 8, c -= 8;
    if ((h > b || x) && (x ? (b = _(A = D), x = !1) : (++A, A == Ct ? b = 1 << Ct : b = _(A))), C == z) {
      for (; c > 0; )
        d(l & 255, N), l >>= 8, c -= 8;
      E(N);
    }
  }
  this.encode = P;
}
function V() {
  this.page = -1, this.pages = [], this.newPage();
}
V.pageSize = 4096;
V.charMap = {};
for (var xt = 0; xt < 256; xt++)
  V.charMap[xt] = String.fromCharCode(xt);
V.prototype.newPage = function() {
  this.pages[++this.page] = new Uint8Array(V.pageSize), this.cursor = 0;
};
V.prototype.getData = function() {
  for (var o = "", t = 0; t < this.pages.length; t++)
    for (var e = 0; e < V.pageSize; e++)
      o += V.charMap[this.pages[t][e]];
  return o;
};
V.prototype.toFlattenUint8Array = function() {
  const o = [];
  for (var t = 0; t < this.pages.length; t++)
    if (t === this.pages.length - 1) {
      const r = Uint8Array.from(this.pages[t].slice(0, this.cursor));
      o.push(r);
    } else
      o.push(this.pages[t]);
  const e = new Uint8Array(o.reduce((r, n) => r + n.length, 0));
  return o.reduce((r, n) => (e.set(n, r), r + n.length), 0), e;
};
V.prototype.writeByte = function(o) {
  this.cursor >= V.pageSize && this.newPage(), this.pages[this.page][this.cursor++] = o;
};
V.prototype.writeUTFBytes = function(o) {
  for (var t = o.length, e = 0; e < t; e++)
    this.writeByte(o.charCodeAt(e));
};
V.prototype.writeBytes = function(o, t, e) {
  for (var r = e || o.length, n = t || 0; n < r; n++)
    this.writeByte(o[n]);
};
function O(o, t) {
  this.width = ~~o, this.height = ~~t, this.transparent = null, this.transIndex = 0, this.repeat = -1, this.delay = 0, this.image = null, this.pixels = null, this.indexedPixels = null, this.colorDepth = null, this.colorTab = null, this.neuQuant = null, this.usedEntry = new Array(), this.palSize = 7, this.dispose = -1, this.firstFrame = !0, this.sample = 10, this.dither = !1, this.globalPalette = !1, this.out = new V();
}
O.prototype.setDelay = function(o) {
  this.delay = Math.round(o / 10);
};
O.prototype.setFrameRate = function(o) {
  this.delay = Math.round(100 / o);
};
O.prototype.setDispose = function(o) {
  o >= 0 && (this.dispose = o);
};
O.prototype.setRepeat = function(o) {
  this.repeat = o;
};
O.prototype.setTransparent = function(o) {
  this.transparent = o;
};
O.prototype.addFrame = function(o) {
  this.image = o, this.colorTab = this.globalPalette && this.globalPalette.slice ? this.globalPalette : null, this.getImagePixels(), this.analyzePixels(), this.globalPalette === !0 && (this.globalPalette = this.colorTab), this.firstFrame && (this.writeHeader(), this.writeLSD(), this.writePalette(), this.repeat >= 0 && this.writeNetscapeExt()), this.writeGraphicCtrlExt(), this.writeImageDesc(), !this.firstFrame && !this.globalPalette && this.writePalette(), this.writePixels(), this.firstFrame = !1;
};
O.prototype.finish = function() {
  this.out.writeByte(59);
};
O.prototype.setQuality = function(o) {
  o < 1 && (o = 1), this.sample = o;
};
O.prototype.setDither = function(o) {
  o === !0 && (o = "FloydSteinberg"), this.dither = o;
};
O.prototype.setGlobalPalette = function(o) {
  this.globalPalette = o;
};
O.prototype.getGlobalPalette = function() {
  return this.globalPalette && this.globalPalette.slice && this.globalPalette.slice(0) || this.globalPalette;
};
O.prototype.writeHeader = function() {
  this.out.writeUTFBytes("GIF89a");
};
O.prototype.analyzePixels = function() {
  this.colorTab || (this.neuQuant = new fr(this.pixels, this.sample), this.neuQuant.buildColormap(), this.colorTab = this.neuQuant.getColormap()), this.dither ? this.ditherPixels(this.dither.replace("-serpentine", ""), this.dither.match(/-serpentine/) !== null) : this.indexPixels(), this.pixels = null, this.colorDepth = 8, this.palSize = 7, this.transparent !== null && (this.transIndex = this.findClosest(this.transparent, !0));
};
O.prototype.indexPixels = function(o) {
  var t = this.pixels.length / 3;
  this.indexedPixels = new Uint8Array(t);
  for (var e = 0, r = 0; r < t; r++) {
    var n = this.findClosestRGB(this.pixels[e++] & 255, this.pixels[e++] & 255, this.pixels[e++] & 255);
    this.usedEntry[n] = !0, this.indexedPixels[r] = n;
  }
};
O.prototype.ditherPixels = function(o, t) {
  var e = {
    FalseFloydSteinberg: [
      [0.375, 1, 0],
      [0.375, 0, 1],
      [0.25, 1, 1]
    ],
    FloydSteinberg: [
      [0.4375, 1, 0],
      [0.1875, -1, 1],
      [0.3125, 0, 1],
      [0.0625, 1, 1]
    ],
    Stucki: [
      [0.19047619047619047, 1, 0],
      [0.09523809523809523, 2, 0],
      [0.047619047619047616, -2, 1],
      [0.09523809523809523, -1, 1],
      [0.19047619047619047, 0, 1],
      [0.09523809523809523, 1, 1],
      [0.047619047619047616, 2, 1],
      [0.023809523809523808, -2, 2],
      [0.047619047619047616, -1, 2],
      [0.09523809523809523, 0, 2],
      [0.047619047619047616, 1, 2],
      [0.023809523809523808, 2, 2]
    ],
    Atkinson: [
      [0.125, 1, 0],
      [0.125, 2, 0],
      [0.125, -1, 1],
      [0.125, 0, 1],
      [0.125, 1, 1],
      [0.125, 0, 2]
    ]
  };
  if (!o || !e[o])
    throw "Unknown dithering kernel: " + o;
  var r = e[o], n = 0, i = this.height, a = this.width, s = this.pixels, l = t ? -1 : 1;
  this.indexedPixels = new Uint8Array(this.pixels.length / 3);
  for (var c = 0; c < i; c++) {
    t && (l = l * -1);
    for (var u = l == 1 ? 0 : a - 1, h = l == 1 ? a : 0; u !== h; u += l) {
      n = c * a + u;
      var b = n * 3, x = s[b], D = s[b + 1], T = s[b + 2];
      b = this.findClosestRGB(x, D, T), this.usedEntry[b] = !0, this.indexedPixels[n] = b, b *= 3;
      for (var z = this.colorTab[b], g = this.colorTab[b + 1], p = this.colorTab[b + 2], A = x - z, d = D - g, w = T - p, m = l == 1 ? 0 : r.length - 1, y = l == 1 ? r.length : 0; m !== y; m += l) {
        var P = r[m][1], E = r[m][2];
        if (P + u >= 0 && P + u < a && E + c >= 0 && E + c < i) {
          var _ = r[m][0];
          b = n + P + E * a, b *= 3, s[b] = Math.max(0, Math.min(255, s[b] + A * _)), s[b + 1] = Math.max(0, Math.min(255, s[b + 1] + d * _)), s[b + 2] = Math.max(0, Math.min(255, s[b + 2] + w * _));
        }
      }
    }
  }
};
O.prototype.findClosest = function(o, t) {
  return this.findClosestRGB((o & 16711680) >> 16, (o & 65280) >> 8, o & 255, t);
};
O.prototype.findClosestRGB = function(o, t, e, r) {
  if (this.colorTab === null)
    return -1;
  if (this.neuQuant && !r)
    return this.neuQuant.lookupRGB(o, t, e);
  for (var n = 0, i = 256 * 256 * 256, a = this.colorTab.length, s = 0, l = 0; s < a; l++) {
    var c = o - (this.colorTab[s++] & 255), u = t - (this.colorTab[s++] & 255), h = e - (this.colorTab[s++] & 255), b = c * c + u * u + h * h;
    (!r || this.usedEntry[l]) && b < i && (i = b, n = l);
  }
  return n;
};
O.prototype.getImagePixels = function() {
  var o = this.width, t = this.height;
  this.pixels = new Uint8Array(o * t * 3);
  for (var e = this.image, r = 0, n = 0, i = 0; i < t; i++)
    for (var a = 0; a < o; a++)
      this.pixels[n++] = e[r++], this.pixels[n++] = e[r++], this.pixels[n++] = e[r++], r++;
};
O.prototype.writeGraphicCtrlExt = function() {
  this.out.writeByte(33), this.out.writeByte(249), this.out.writeByte(4);
  var o, t;
  this.transparent === null ? (o = 0, t = 0) : (o = 1, t = 2), this.dispose >= 0 && (t = this.dispose & 7), t <<= 2, this.out.writeByte(
    0 | // 1:3 reserved
    t | // 4:6 disposal
    0 | // 7 user input - 0 = none
    o
    // 8 transparency flag
  ), this.writeShort(this.delay), this.out.writeByte(this.transIndex), this.out.writeByte(0);
};
O.prototype.writeImageDesc = function() {
  this.out.writeByte(44), this.writeShort(0), this.writeShort(0), this.writeShort(this.width), this.writeShort(this.height), this.firstFrame || this.globalPalette ? this.out.writeByte(0) : this.out.writeByte(
    128 | // 4-5 reserved
    this.palSize
    // 6-8 size of color table
  );
};
O.prototype.writeLSD = function() {
  this.writeShort(this.width), this.writeShort(this.height), this.out.writeByte(
    240 | // 5 : gct sort flag = 0
    this.palSize
    // 6-8 : gct size
  ), this.out.writeByte(0), this.out.writeByte(0);
};
O.prototype.writeNetscapeExt = function() {
  this.out.writeByte(33), this.out.writeByte(255), this.out.writeByte(11), this.out.writeUTFBytes("NETSCAPE2.0"), this.out.writeByte(3), this.out.writeByte(1), this.writeShort(this.repeat), this.out.writeByte(0);
};
O.prototype.writePalette = function() {
  this.out.writeBytes(this.colorTab);
  for (var o = 3 * 256 - this.colorTab.length, t = 0; t < o; t++)
    this.out.writeByte(0);
};
O.prototype.writeShort = function(o) {
  this.out.writeByte(o & 255), this.out.writeByte(o >> 8 & 255);
};
O.prototype.writePixels = function() {
  var o = new hr(this.width, this.height, this.indexedPixels, this.colorDepth);
  o.encode(this.out);
};
O.prototype.stream = function() {
  return this.out;
};
var dr = function(o, t, e, r) {
  function n(i) {
    return i instanceof e ? i : new e(function(a) {
      a(i);
    });
  }
  return new (e || (e = Promise))(function(i, a) {
    function s(u) {
      try {
        c(r.next(u));
      } catch (h) {
        a(h);
      }
    }
    function l(u) {
      try {
        c(r.throw(u));
      } catch (h) {
        a(h);
      }
    }
    function c(u) {
      u.done ? i(u.value) : n(u.value).then(s, l);
    }
    c((r = r.apply(o, t || [])).next());
  });
};
const { Canvas: it } = Fe, At = 0.4;
function ee(o) {
  if (!o)
    return;
  function t(e) {
    e.onload = null, e.onerror = null;
  }
  return new Promise(function(e, r) {
    if (o.slice(0, 4) == "data") {
      let i = new Image();
      i.onload = function() {
        e(i), t(i);
      }, i.onerror = function() {
        r("Image load error"), t(i);
      }, i.src = o;
      return;
    }
    let n = new Image();
    n.setAttribute("crossOrigin", "Anonymous"), n.onload = function() {
      e(n);
    }, n.onerror = function() {
      r("Image load error");
    }, n.src = o;
  });
}
class L {
  constructor(t) {
    const e = Object.assign({}, t);
    if (Object.keys(L.defaultOptions).forEach((r) => {
      r in e || Object.defineProperty(e, r, { value: L.defaultOptions[r], enumerable: !0, writable: !0 });
    }), e.components ? typeof e.components == "object" && Object.keys(L.defaultComponentOptions).forEach((r) => {
      r in e.components ? Object.defineProperty(e.components, r, {
        value: Object.assign(Object.assign({}, L.defaultComponentOptions[r]), e.components[r]),
        enumerable: !0,
        writable: !0
      }) : Object.defineProperty(e.components, r, {
        value: L.defaultComponentOptions[r],
        enumerable: !0,
        writable: !0
      });
    }) : e.components = L.defaultComponentOptions, e.dotScale !== null && e.dotScale !== void 0) {
      if (e.dotScale <= 0 || e.dotScale > 1)
        throw new Error("dotScale should be in range (0, 1].");
      e.components.data.scale = e.dotScale, e.components.timing.scale = e.dotScale, e.components.alignment.scale = e.dotScale;
    }
    this.options = e, this.canvas = new it(t.size, t.size), this.canvasContext = this.canvas.getContext("2d"), this.qrCode = new ct(-1, this.options.correctLevel), Number.isInteger(this.options.maskPattern) && (this.qrCode.maskPattern = this.options.maskPattern), Number.isInteger(this.options.version) && (this.qrCode.typeNumber = this.options.version), this.qrCode.addData(this.options.text), this.qrCode.make();
  }
  draw() {
    return new Promise((t) => this._draw().then(t));
  }
  _clear() {
    this.canvasContext.clearRect(0, 0, this.canvas.width, this.canvas.height);
  }
  static _prepareRoundedCornerClip(t, e, r, n, i, a) {
    t.beginPath(), t.moveTo(e, r), t.arcTo(e + n, r, e + n, r + i, a), t.arcTo(e + n, r + i, e, r + i, a), t.arcTo(e, r + i, e, r, a), t.arcTo(e, r, e + n, r, a), t.closePath();
  }
  static _getAverageRGB(t) {
    const r = {
      r: 0,
      g: 0,
      b: 0
    };
    let n, i, a = -4;
    const s = {
      r: 0,
      g: 0,
      b: 0
    };
    let l = 0;
    i = t.naturalHeight || t.height, n = t.naturalWidth || t.width;
    const u = new it(n, i).getContext("2d");
    if (!u)
      return r;
    u.drawImage(t, 0, 0);
    let h;
    try {
      h = u.getImageData(0, 0, n, i);
    } catch {
      return r;
    }
    for (; (a += 5 * 4) < h.data.length; )
      h.data[a] > 200 || h.data[a + 1] > 200 || h.data[a + 2] > 200 || (++l, s.r += h.data[a], s.g += h.data[a + 1], s.b += h.data[a + 2]);
    return s.r = ~~(s.r / l), s.g = ~~(s.g / l), s.b = ~~(s.b / l), s;
  }
  static _drawDot(t, e, r, n, i = 0, a = 1) {
    t.fillRect((e + i) * n, (r + i) * n, a * n, a * n);
  }
  static _drawAlignProtector(t, e, r, n) {
    t.clearRect((e - 2) * n, (r - 2) * n, 5 * n, 5 * n), t.fillRect((e - 2) * n, (r - 2) * n, 5 * n, 5 * n);
  }
  static _drawAlign(t, e, r, n, i = 0, a = 1, s, l) {
    const c = t.fillStyle;
    t.fillStyle = s, new Array(4).fill(0).map((u, h) => {
      L._drawDot(t, e - 2 + h, r - 2, n, i, a), L._drawDot(t, e + 2, r - 2 + h, n, i, a), L._drawDot(t, e + 2 - h, r + 2, n, i, a), L._drawDot(t, e - 2, r + 2 - h, n, i, a);
    }), L._drawDot(t, e, r, n, i, a), l || (t.fillStyle = "rgba(255, 255, 255, 0.6)", new Array(2).fill(0).map((u, h) => {
      L._drawDot(t, e - 1 + h, r - 1, n, i, a), L._drawDot(t, e + 1, r - 1 + h, n, i, a), L._drawDot(t, e + 1 - h, r + 1, n, i, a), L._drawDot(t, e - 1, r + 1 - h, n, i, a);
    })), t.fillStyle = c;
  }
  _draw() {
    var t, e, r, n, i, a, s, l, c, u, h, b, x, D, T, z, g, p, A;
    return dr(this, void 0, void 0, function* () {
      const d = (t = this.qrCode) === null || t === void 0 ? void 0 : t.moduleCount, w = this.options.size;
      let m = this.options.margin;
      (m < 0 || m * 2 >= w) && (m = 0);
      const y = Math.ceil(m), P = w - 2 * m, E = this.options.whiteMargin, _ = this.options.backgroundDimming, f = Math.ceil(P / d), F = f * d, C = F + 2 * y, N = new it(C, C), v = N.getContext("2d");
      this._clear(), v.save(), v.translate(y, y);
      const ft = new it(C, C), j = ft.getContext("2d");
      let q = null, st = [];
      if (this.options.gifBackground) {
        const B = Ze(this.options.gifBackground);
        if (q = B, st = We(B), this.options.autoColor) {
          let k = 0, S = 0, I = 0, H = 0;
          for (let R = 0; R < st[0].colorTable.length; R++) {
            const $ = st[0].colorTable[R];
            $[0] > 200 || $[1] > 200 || $[2] > 200 || $[0] === 0 && $[1] === 0 && $[2] === 0 || (H++, k += $[0], S += $[1], I += $[2]);
          }
          k = ~~(k / H), S = ~~(S / H), I = ~~(I / H), this.options.colorDark = `rgb(${k},${S},${I})`;
        }
      } else if (this.options.backgroundImage) {
        const B = yield ee(this.options.backgroundImage);
        if (this.options.autoColor) {
          const k = L._getAverageRGB(B);
          this.options.colorDark = `rgb(${k.r},${k.g},${k.b})`;
        }
        j.drawImage(B, 0, 0, B.width, B.height, 0, 0, C, C), j.rect(0, 0, C, C), j.fillStyle = _, j.fill();
      } else
        j.rect(0, 0, C, C), j.fillStyle = this.options.colorLight, j.fill();
      const U = M.getPatternPosition(this.qrCode.typeNumber), Q = ((r = (e = this.options.components) === null || e === void 0 ? void 0 : e.data) === null || r === void 0 ? void 0 : r.scale) || At, Gt = (1 - Q) * 0.5;
      for (let B = 0; B < d; B++)
        for (let k = 0; k < d; k++) {
          const S = this.qrCode.isDark(B, k), I = k < 8 && (B < 8 || B >= d - 8) || k >= d - 8 && B < 8, H = B == 6 && k >= 8 && k <= d - 8 || k == 6 && B >= 8 && B <= d - 8;
          let R = I || H;
          for (let X = 1; X < U.length - 1; X++)
            R = R || B >= U[X] - 2 && B <= U[X] + 2 && k >= U[X] - 2 && k <= U[X] + 2;
          const $ = k * f + (R ? 0 : Gt * f), tt = B * f + (R ? 0 : Gt * f);
          if (v.strokeStyle = S ? this.options.colorDark : this.options.colorLight, v.lineWidth = 0.5, v.fillStyle = S ? this.options.colorDark : this.options.colorLight, U.length === 0)
            R || v.fillRect($, tt, (R ? 1 : Q) * f, (R ? 1 : Q) * f);
          else {
            const X = k < d - 4 && k >= d - 4 - 5 && B < d - 4 && B >= d - 4 - 5;
            !R && !X && v.fillRect($, tt, (R ? 1 : Q) * f, (R ? 1 : Q) * f);
          }
        }
      const W = U[U.length - 1], de = this.options.colorLight;
      if (v.fillStyle = de, v.fillRect(0, 0, 8 * f, 8 * f), v.fillRect(0, (d - 8) * f, 8 * f, 8 * f), v.fillRect((d - 8) * f, 0, 8 * f, 8 * f), !((i = (n = this.options.components) === null || n === void 0 ? void 0 : n.timing) === null || i === void 0) && i.protectors && (v.fillRect(8 * f, 6 * f, (d - 8 - 8) * f, f), v.fillRect(6 * f, 8 * f, f, (d - 8 - 8) * f)), !((s = (a = this.options.components) === null || a === void 0 ? void 0 : a.cornerAlignment) === null || s === void 0) && s.protectors && L._drawAlignProtector(v, W, W, f), !((c = (l = this.options.components) === null || l === void 0 ? void 0 : l.alignment) === null || c === void 0) && c.protectors)
        for (let B = 0; B < U.length; B++)
          for (let k = 0; k < U.length; k++) {
            const S = U[k], I = U[B];
            if (!(S === 6 && (I === 6 || I === W))) {
              if (I === 6 && (S === 6 || S === W))
                continue;
              if (S === W && I === W)
                continue;
              L._drawAlignProtector(v, S, I, f);
            }
          }
      v.fillStyle = this.options.colorDark, v.fillRect(0, 0, 7 * f, f), v.fillRect((d - 7) * f, 0, 7 * f, f), v.fillRect(0, 6 * f, 7 * f, f), v.fillRect((d - 7) * f, 6 * f, 7 * f, f), v.fillRect(0, (d - 7) * f, 7 * f, f), v.fillRect(0, (d - 7 + 6) * f, 7 * f, f), v.fillRect(0, 0, f, 7 * f), v.fillRect(6 * f, 0, f, 7 * f), v.fillRect((d - 7) * f, 0, f, 7 * f), v.fillRect((d - 7 + 6) * f, 0, f, 7 * f), v.fillRect(0, (d - 7) * f, f, 7 * f), v.fillRect(6 * f, (d - 7) * f, f, 7 * f), v.fillRect(2 * f, 2 * f, 3 * f, 3 * f), v.fillRect((d - 7 + 2) * f, 2 * f, 3 * f, 3 * f), v.fillRect(2 * f, (d - 7 + 2) * f, 3 * f, 3 * f);
      const Tt = ((h = (u = this.options.components) === null || u === void 0 ? void 0 : u.timing) === null || h === void 0 ? void 0 : h.scale) || At, Ut = (1 - Tt) * 0.5;
      for (let B = 0; B < d - 8; B += 2)
        L._drawDot(v, 8 + B, 6, f, Ut, Tt), L._drawDot(v, 6, 8 + B, f, Ut, Tt);
      const Ht = ((x = (b = this.options.components) === null || b === void 0 ? void 0 : b.cornerAlignment) === null || x === void 0 ? void 0 : x.scale) || At, ge = (1 - Ht) * 0.5;
      L._drawAlign(v, W, W, f, ge, Ht, this.options.colorDark, ((T = (D = this.options.components) === null || D === void 0 ? void 0 : D.cornerAlignment) === null || T === void 0 ? void 0 : T.protectors) || !1);
      const Kt = ((g = (z = this.options.components) === null || z === void 0 ? void 0 : z.alignment) === null || g === void 0 ? void 0 : g.scale) || At, pe = (1 - Kt) * 0.5;
      for (let B = 0; B < U.length; B++)
        for (let k = 0; k < U.length; k++) {
          const S = U[k], I = U[B];
          if (!(S === 6 && (I === 6 || I === W))) {
            if (I === 6 && (S === 6 || S === W))
              continue;
            if (S === W && I === W)
              continue;
            L._drawAlign(v, S, I, f, pe, Kt, this.options.colorDark, ((A = (p = this.options.components) === null || p === void 0 ? void 0 : p.alignment) === null || A === void 0 ? void 0 : A.protectors) || !1);
          }
        }
      if (E && (v.fillStyle = this.options.backgroundColor, v.fillRect(-y, -y, C, y), v.fillRect(-y, F, C, y), v.fillRect(F, -y, y, C), v.fillRect(-y, -y, y, C)), this.options.logoImage) {
        const B = yield ee(this.options.logoImage);
        let k = this.options.logoScale, S = this.options.logoMargin, I = this.options.logoCornerRadius;
        (k <= 0 || k >= 1) && (k = 0.2), S < 0 && (S = 0), I < 0 && (I = 0);
        const H = F * k, R = 0.5 * (C - H), $ = R;
        v.restore(), v.fillStyle = this.options.logoBackgroundColor, v.save(), L._prepareRoundedCornerClip(v, R - S, $ - S, H + 2 * S, H + 2 * S, I + S), v.clip();
        const tt = v.globalCompositeOperation;
        v.globalCompositeOperation = "destination-out", v.fill(), v.globalCompositeOperation = tt, v.restore(), v.save(), L._prepareRoundedCornerClip(v, R, $, H, H, I), v.clip(), v.drawImage(B, R, $, H, H), v.restore(), v.save(), v.translate(y, y);
      }
      if (q) {
        let B, k, S, I, H, R;
        if (st.forEach(function($) {
          B || (B = new O(w, w), B.setDelay($.delay), B.setRepeat(0));
          const { width: tt, height: X } = $.dims;
          k || (k = new it(tt, X), S = k.getContext("2d"), S.rect(0, 0, k.width, k.height), S.fillStyle = "#ffffff", S.fill()), (!I || !R || tt !== I.width || X !== I.height) && (I = new it(tt, X), H = I.getContext("2d"), R = H.createImageData(tt, X)), R.data.set($.patch), H.putImageData(R, 0, 0), S.drawImage(I.getContext("2d").canvas, $.dims.left, $.dims.top);
          const wt = new it(C, C), mt = wt.getContext("2d");
          mt.drawImage(k.getContext("2d").canvas, 0, 0, C, C), mt.rect(0, 0, C, C), mt.fillStyle = _, mt.fill(), mt.drawImage(N.getContext("2d").canvas, 0, 0, C, C);
          const Et = new it(w, w), Xt = Et.getContext("2d");
          Xt.drawImage(wt.getContext("2d").canvas, 0, 0, w, w), B.addFrame(Xt.getImageData(0, 0, Et.width, Et.height).data);
        }), !B)
          throw new Error("No frames.");
        if (B.finish(), re(this.canvas)) {
          const tt = B.stream().toFlattenUint8Array().reduce((X, wt) => X + String.fromCharCode(wt), "");
          return Promise.resolve(`data:image/gif;base64,${window.btoa(tt)}`);
        }
        return Promise.resolve(Buffer.from(B.stream().toFlattenUint8Array()));
      } else {
        j.drawImage(N.getContext("2d").canvas, 0, 0, C, C), v.drawImage(ft.getContext("2d").canvas, -y, -y, C, C);
        const B = new it(w, w);
        B.getContext("2d").drawImage(N.getContext("2d").canvas, 0, 0, w, w), this.canvas = B;
        const S = this.options.gifBackground ? "gif" : "png";
        return re(this.canvas) ? Promise.resolve(this.canvas.toDataURL(S)) : Promise.resolve(this.canvas.toBuffer(S));
      }
    });
  }
}
L.CorrectLevel = Z;
L.defaultComponentOptions = {
  data: {
    scale: 0.4
  },
  timing: {
    scale: 0.5,
    protectors: !1
  },
  alignment: {
    scale: 0.5,
    protectors: !1
  },
  cornerAlignment: {
    scale: 0.5,
    protectors: !0
  }
};
L.defaultOptions = {
  text: "",
  size: 400,
  margin: 20,
  colorDark: "#000000",
  colorLight: "rgba(255, 255, 255, 0.6)",
  correctLevel: Z.M,
  backgroundImage: void 0,
  backgroundDimming: "rgba(0,0,0,0)",
  logoImage: void 0,
  logoScale: 0.2,
  logoMargin: 4,
  logoCornerRadius: 8,
  whiteMargin: !0,
  components: L.defaultComponentOptions,
  autoColor: !0,
  logoBackgroundColor: "#ffffff",
  backgroundColor: "#ffffff"
};
function re(o) {
  try {
    return o instanceof HTMLElement;
  } catch {
    return typeof o == "object" && o.nodeType === 1 && typeof o.style == "object" && typeof o.ownerDocument == "object";
  }
}
const gr = ["src"], Ot = {
  __name: "vue-qr",
  props: {
    text: {
      type: String,
      required: !0
    },
    qid: {
      type: String
    },
    correctLevel: {
      type: Number,
      default: 1
    },
    size: {
      type: Number,
      default: 200
    },
    margin: {
      type: Number,
      default: 20
    },
    colorDark: {
      type: String,
      default: "#000000"
    },
    colorLight: {
      type: String,
      default: "#FFFFFF"
    },
    bgSrc: {
      type: String,
      default: void 0
    },
    background: {
      type: String,
      default: "rgba(0,0,0,0)"
    },
    backgroundDimming: {
      type: String,
      default: "rgba(0,0,0,0)"
    },
    logoSrc: {
      type: String,
      default: void 0
    },
    logoBackgroundColor: {
      type: String,
      default: "rgba(255,255,255,1)"
    },
    gifBgSrc: {
      type: String,
      default: void 0
    },
    logoScale: {
      type: Number,
      default: 0.2
    },
    logoMargin: {
      type: Number,
      default: 0
    },
    logoCornerRadius: {
      type: Number,
      default: 8
    },
    whiteMargin: {
      type: [Boolean, String],
      default: !0
    },
    dotScale: {
      type: Number,
      default: 1
    },
    autoColor: {
      type: [Boolean, String],
      default: !0
    },
    binarize: {
      type: [Boolean, String],
      default: !1
    },
    binarizeThreshold: {
      type: Number,
      default: 128
    },
    bindElement: {
      type: Boolean,
      default: !0
    },
    backgroundColor: {
      type: String,
      default: "#FFFFFF"
    },
    components: {
      type: Object,
      default: () => ({
        data: {
          scale: 1
        },
        timing: {
          scale: 1,
          protectors: !1
        },
        alignment: {
          scale: 1,
          protectors: !1
        },
        cornerAlignment: {
          scale: 1,
          protectors: !0
        }
      })
    }
  },
  emits: ["generated"],
  setup(o, { expose: t, emit: e }) {
    const r = o, n = e, i = me("");
    async function a() {
      if (r.gifBgSrc) {
        const u = await xe(r.gifBgSrc), h = r.logoSrc;
        s(void 0, h, u);
        return;
      }
      const l = r.bgSrc, c = r.logoSrc;
      s(l, c);
    }
    async function s(l, c, u) {
      const h = await new L({
        gifBackground: u,
        text: r.text,
        size: r.size,
        margin: r.margin,
        colorDark: r.colorDark,
        colorLight: r.colorLight,
        backgroundColor: r.backgroundColor,
        backgroundImage: l,
        backgroundDimming: r.backgroundDimming,
        logoImage: c,
        logoScale: r.logoScale,
        logoBackgroundColor: r.logoBackgroundColor,
        correctLevel: r.correctLevel,
        logoMargin: r.logoMargin,
        logoCornerRadius: r.logoCornerRadius,
        whiteMargin: St(r.whiteMargin),
        dotScale: r.dotScale,
        autoColor: St(r.autoColor),
        binarize: St(r.binarize),
        binarizeThreshold: r.binarizeThreshold,
        components: r.components
      }).draw();
      i.value = h, n("generated", h, r.qid);
    }
    return ve(
      () => r,
      () => {
        a();
      },
      { deep: !0 }
    ), be(() => {
      a();
    }), t({
      imgUrl: i
    }), (l, c) => o.bindElement ? (we(), ye("img", {
      key: 0,
      style: { display: "inline-block" },
      src: i.value
    }, null, 8, gr)) : Ce("", !0);
  }
};
Ot.install = (o) => {
  o.component("VueQr", Ot);
};
function vr(o) {
  o.component("VueQr", Ot);
}
export {
  Ot as VueQr,
  Ot as default,
  vr as install
};
