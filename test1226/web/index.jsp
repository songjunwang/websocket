<%--
  Created by IntelliJ IDEA.
  User: wsj
  Date: 2015/12/26
  Time: 23:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
    <script>
      window.onload = function(){
        /*alert("this is alert!");
        var pro = prompt("string",true);
        var div = document.createElement("div");
        div.style.borderBottom = "1px,solid,red";
        div.innerHTML = pro;
        document.body.appendChild(div);
        var con = confirm("this is confirm!");
        div.innerHTML = con;
        */
      };
      function theTestTryCatch(a){
        console.group(a);
        try {
          console.log("after throw:"+a);
          throw typeof a;
          console.log("before throw:"+a);
        } catch (e) {
          console.dir(e);
        } finally {
          console.log("the end!")
        }
        console.groupEnd(a);
      }

      function person(name,sex,age){
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.show = function() {
          document.writeln("hello,my name is " + this.name);
          document.writeln("I'm " + this.age + " years old.");
          document.write("hello,my name is " + this.name);
          document.write("I'm " + this.age + " years old.");
          }
        }
    </script>
  </head>
  <body>
      <h4>this is index.jsp</h4>
      <input type="text" onblur="theTestTryCatch(this.value)">
  </body>
</html>
