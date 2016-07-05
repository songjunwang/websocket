<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String WSPath = "ws://"+request.getServerName()+":"+request.getServerPort()+path;
  String basePath = "http://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE HTML>
<html>
<head>
  <base href="<%=basePath%>">
  <title>My WebSocket</title>
</head>

<link rel="icon" href="<%=basePath %>/images/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="<%=basePath %>/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/demo.css">
<script type="text/javascript" src="<%=basePath %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/js/jquery.json-2.4.js"></script>
<script type="text/javascript" src="<%=basePath %>/js/jquery.serializejson.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/js/jquery.easyui.min.js"></script>
<style>
  *{
    list-style: none;
    margin:0;
    padding:0
  }
  #message{
    /* overflow-x:hidden; */
    /* overflow-y:scroll; */
    scrollbar-base-color:#ff6600;
  }
  textarea {
    resize: none;
    border-color:rgb(149,184,231);
    border-radius:5px;
  }
  .content{
    margin: 2px;
    width:100%;
    float:left;
  }
  .inbox{
    background-color: rgb(205,215,246);
    border-radius:8px;
    width: auto;
    height: auto;
    float: left;
    padding:5px;
    margin-right: 20px;
  }
  .outbox{
    background-color: rgb(120,205,248);
    border-radius:8px;
    width: auto;
    height: auto;
    float: right;
    padding:5px;
    margin-left: 20px;
  }
</style>
<body>
Welcome<br/>
<img alt="" src="<%=basePath %>/images/favicon.ico"><br>

<div id="w" class="easyui-window" title=<%=WSPath%> data-options="closable:false,minimizable:false" style="width:600px;height:400px;padding:5px;">
  <div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'east',split:true" style="width:150px">
      <div id="contacts_accordion" class="easyui-accordion" data-options="fit:true,multiple:true,border:false">
        <div title="分组1" data-options="iconCls:'icon-save'" style="overflow:auto;padding:10px;">
          <h3 style="color:#0099FF;">Accordion for jQuery</h3>
        </div>
        <div title="分组2" data-options="iconCls:'icon-reload'" style="padding:10px;">
          content2
        </div>
        <div title="分组3">
          content3
        </div>
      </div>
      <%--<table title="分组一" class="easyui-datagrid">
        <thead>
          <th field="photo" width="50px" title="头像"></th>
          <th field="name" width="100px" title="名称"></th>
        </thead>
      </table>--%>
    </div>
    <div id="message" data-options="region:'center'" style="padding:10px;">

    </div>
    <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
      <form action="javascript:send();">
        <table>
          <tr>
            <td>
              <textarea id="text" rows="4" cols="60" required="required" autofocus="autofocus"></textarea>
            </td>
            <td>
              <a href="javascript:void(0);" class="easyui-linkbutton" onclick="document.getElementById('formsubmit').click();" data-options="">send</a>
              <input type="submit" style="display:none" id="formsubmit">
              <a href="javascript:void(0);" class="easyui-linkbutton" onclick="document.getElementById('formreset').click();" data-options="">reset</a>
              <input type="reset" style="display:none" id="formreset">
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
</body>

<script type="text/javascript">
  var websocket = null;
  var WSPath = "<%=WSPath%>";

  //判断当前浏览器是否支持WebSocket
  if('WebSocket' in window){
    websocket = new WebSocket(WSPath+"/websocket");
  }else{
    alert('Not support websocket')
  }

  //连接发生错误的回调方法
  websocket.onerror = function(){
    setMessageInnerHTML("error");
  };

  //连接成功建立的回调方法
  websocket.onopen = function(event){
    $("#message").append("<div class='content'>与服务器连接成功！现在可以开始聊天了.</div>");
  }

  //接收到消息的回调方法
  websocket.onmessage = function(event){
    console.dir(event);
    setMessageInnerHTML(event.data);
  }

  //将消息显示在网页上
  function setMessageInnerHTML(message){
    $(".content:last").after("<div class='content'><div class='inbox'>"+message+"</div></div>");
    var div = document.getElementById('message');
    div.scrollTop = div.scrollHeight;
  }

  //发送消息
  function send(){
    var message = $("#text").val();
    if(websocket != null && message != ""){
      websocket.send(message);
      $("#text").val(null);
      $(".content:last").after("<div class='content'><div class='outbox'>"+message+"</div></div>");
      var div = document.getElementById('message');
      div.scrollTop = div.scrollHeight;
    }
  }

  $("textarea").keydown(function(event){
    if (event.keyCode == 13) {
      event.returnValue = false;
      return false;
    }
  });
  $("textarea").keyup(function(event){
    if (event.keyCode == 13) {
      document.getElementById('formsubmit').click();
    }
  });

  //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
  window.onbeforeunload = function(){
    websocket.close();
  }

  //关闭连接
  function closeWebSocket(){
    websocket.close();
  }

  //连接关闭的回调方法
  websocket.onclose = function(){
    setMessageInnerHTML("close");
  }

</script>
</html>