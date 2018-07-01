<div id="icon_add_div" class="modal fade" tabindex="-1" aria-hidden="true" style="height: 1000px">
    <div class="modal-dialog" style="width:900px;">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom:none;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
                <div class="row" id="roletableDatas">
                    <div class="col-md-12">
                        <div class="portlet">
                            <div class="portlet-title">
                                <div class="caption"><i class="fa fa-cogs"></i>图标列表</div>
                                <div class="actions">
                                    <div class="btn-group">
                                        <select class="form-control  input-small select2me" id="_dlgCheckIcon"
                                                onchange="checkIcon()">
                                            <option value="glyphiconsIcons">Glyphicons Icons</option>
                                            <option value="newIcons">10 New Icons in 4.0</option>
                                            <option value="webappIcons">Web Application Icons</option>
                                            <option value="formIcons">Form Control Icons</option>
                                            <option value="currencyIcons">Currency Icons</option>
                                            <option value="textIcons">Text Editor Icons</option>
                                            <option value="directIcons">Directional Icons</option>
                                            <option value="videoIcons">Video Player Icons</option>
                                            <option value="brandIcons">Brand Icons</option>
                                            <option value="medicalIcons">Medical Icons</option>
                                            <option value="simpleLineIcons">Simple Line Icons</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <!-- 必须加上row样式,不然高度为1px,不能显示边框 -->
                                <div id="tab_1_2" class="tab-pane glyphicons-demo active">
                                    <ul id="iconTable" class="bs-glyphicons bs-glyphicons-list">
                                    </ul>
                                </div>
                                <div class="row">
                                    <table id="iconPageBar" class="col-md-8"
                                           style="text-align: center; width: 100%;">
                                        <tr>
                                            <td class="form-inline">
                                                <div class="pagination" id="iconPager"
                                                     style="font-size: 18px; text-align: center; vertical-align: middle;"></div>
                                                <span style="margin-top: 0px; size: 12px; color: #8a8a8a">跳转到</span>
                                                <input type="text" id="toMPage"
                                                       style="font-size: 18px; width: 50px; height: 30px;"
                                                       class="input-inline page_input"
                                                       onkeyup="if(isNaN(value))execCommand('undo');if(event.keyCode==32)execCommand('undo');"
                                                       onafterpaste="if(isNaN(value))execCommand('undo'));if(event.keyCode==32)execCommand('undo');">
                                                <button style="width: 40px; height: 30px;" id="gotoMPage"
                                                        class="btn">
                                                    GO
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="col-md-2"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
/**获取所有的功能****/
var currentPage = 1; //第几页
var pageCount = 32; //每页显示多少条记录数据
var totalPages = 0;
//分页查询
var queryByPage = function () {
   // start_request_load();
    $.ajax({
        dataType: "json",
        cache: true,
        type: "GET",
        url: "${rc.contextPath}/js/icon.json",
        traditional: true,
        success: function (data) {
          //  stop_request_load();
            var checkIcon = $("#_dlgCheckIcon").val();
            data = data[checkIcon];
            //删除所有子项
            $("#iconTable").empty();
            var total = 0, str = '';
            $.each(data, function (i, n) {
                str += '<li onclick="addIconImage(\'' + n + '\');"><span class="' + n + '" style="font-size:24px;margin:5px auto 10px;display:block"></span><span>' + n + ' </span></li>';
                total++;
            });
            if (data == null || data == undefined || total == 0) {
                return;
            }
            if (total <= pageCount) {
                $("#iconPageBar").css({visibility: "hidden"});
            } else {
                $("#iconPageBar").css({visibility: "visible"});
                str = '';
                var start = (currentPage - 1) * pageCount;
                var k = 0;
                $.each(data, function (i, n) {
                    if (i >= start) {
                        str += '<li onclick="addIconImage(\'' + n + '\');"><span class="' + n + '" style="font-size:24px;margin:5px auto 10px;display:block"></span><span>' + n + ' </span></li>';
                        k++;
                    }
                    if (pageCount == k) {
                        return false;
                    }
                });
            }
            $("#iconTable").append(str);
            //总页数
            if (total % pageCount != 0) {
                totalPages = parseInt(total / pageCount) + 1;
            } else {
                totalPages = total / pageCount;
            }
            var options = {
                currentPage: currentPage,
                totalPages: totalPages,
                onPageClicked: function (event, originalEvent, type, page) {
                    currentPage = page;
                    queryByPage(currentPage, pageCount);
                }
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg("网络异常,数据不能成功返回");
        }
    });
}
//初始化列表
queryByPage(currentPage, pageCount);
//翻页
$("#gotoMPage").bind("click", function () {
    if ($("#toMPage").val() == null || "" == $("#toMPage").val()) {
        layer.msg("请输入跳转页码");
        return;
    }
    var thisPage = parseInt($("#toMPage").val());
    if (!( thisPage > 0 && thisPage <= totalPages)) {
        layer.msg("请输入正确跳转页码");
        return;
    }
    //$('#iconPager').bootstrapPaginator("show", thisPage);
    currentPage = thisPage;
    queryByPage(currentPage, pageCount);
});
function showIconModul() {
    $('#icon_add_div').modal('show');
}
function checkIcon() {
    this.currentPage = 1; //第几页
    this.pageCount = 32; //每页显示多少条记录数据
    this.totalPages = 0;
    $('#toMPage').val('');
    queryByPage(1, 32);
}
function addIconImage(data) {
    $('#icon').val(data);
    $('#icon_add_div').modal('hide');
}
</script>