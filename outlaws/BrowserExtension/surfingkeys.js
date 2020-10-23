// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});


// map
map('gt', 'T');
map('J', 'd');//向下滚动一页
map('K', 'e');//向上滚动一页
map('H', 'S');//后退
map('L', 'D');//前进
map('<Ctrl-h>', 'E');//左侧标签
map('<Ctrl-l>', 'R');//右侧标签
map('<Ctrl-q>', 'x');//关闭当前标签页
map('gdt', 'gxt');//关闭左侧标签页
map('gdT', 'gxT');//关闭右侧标签页
map('gd0', 'gx0');//关闭左侧所有标签页
map('gd$', 'gx$');//关闭右侧所有标签页
map('gdd', 'gxx');//关闭当前标签页之外的所有标签页
map('<Ctrl-i>', 'g0');//第一个标签页
map('<Ctrl-a>', 'g$');//最后一个标签页
map('u', 'X');//恢复刚关闭的标签页
map('p', 'cc')//打开剪贴板中的url


// vmap
vmap('H', '0');
vmap('L', '$');


// unmap
unmap('e');
unmap('S');
unmap('d');
unmap('D');
unmap('E');
unmap('R');
unmap('x');
unmap('X');
unmap('g0');
unmap('g$');
unmap('cc');


// search settings
settings.defaultSearchEngine = 'b';
mapkey('os', '#8打开stackoverflow搜索栏', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "s"});
});

addSearchAliasX('z', 'zhihu', 'https://www.zhihu.com/search?type=content&q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
mapkey('oz', '#8打开知乎搜索栏', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "z"});
});

addSearchAliasX('l', 'bilibili', 'https://search.bilibili.com/all?keyword=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
mapkey('ol', '#8打开B站搜索栏', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "l"});
});

addSearchAliasX('v', 'v2ex', 'https://www.sov2ex.com/?q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
mapkey('ov', '#8打开v2ex搜索栏', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "v"});
});

addSearchAliasX('t', '淘宝', 'https://s.taobao.com/search?q=', 's', 'https://duckduckgo.com/ac/?q=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});
mapkey('ot', '#8打开淘宝搜索栏', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "t"});
});


// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;

// Register inline query
Front.registerInlineQuery({
        url: "https://api.shanbay.com/bdc/search/?word=",
        parseResult: function(res) {
            try {
                res = JSON.parse(res.text);
                var exp = res.msg;
                if (res.data.definition) {
                    var pronunciations = [];
                    for (var reg in res.data.pronunciations) {
                        pronunciations.push(`<div>[${reg}] ${res.data.pronunciations[reg]}</div>`);
                        // pronunciations.push(`<div><audio src="${res.data[reg+'_audio']}" controls></audio></div>`);
                    }
                    var definition = res.data.definition.split("\n").map(function(d) {
                        return `<li>${d}</li>`;
                    }).join("");
                    exp = `${pronunciations.join("")}<ul>${definition}</ul>`;
                }
                if (res.data.en_definitions) {
                    exp += "<hr/>";
                    for (var lex in res.data.en_definitions) {
                        var sense = res.data.en_definitions[lex].map(function(s) {
                            return `<li>${s}</li>`;
                        }).join("");
                        exp += `<div>${lex}</div><ul>${sense}</ul>`;
                    }
                }
                return exp;
            } catch (e) {
                return "";
            }
        }
    });
