//ueditor编辑器
var editor;

/**
 * 初始化
 */
$(document).ready(function() {
    if(message != EMPTY){
        alert(message);
    }
});

/**
 * 初始化
 */
$(document).ready(function() {
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    editor = UE.getEditor('editor');
});

/**
 * 评论
 */
function createReview(){
    var content = editor.getContent();
    document.getElementById("content").value = content;
    //提交表格
    document.forms["createReviewForm"].submit();
}

/**
 * 重新填写
 */
function rewrite(){
    editor.setContent(EMPTY);
}