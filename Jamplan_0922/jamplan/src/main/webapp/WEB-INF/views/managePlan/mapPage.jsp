<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.spring.jamplan.model.MapVO"%> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous">
</script>

<spring:url value="/resources/map/css/semantic.min.css" var="semanticMinCss" />
<spring:url value="/resources/map/css/map.css" var="mapCss" />
<spring:url value="/resources/map/js/semantic.min.js" var="semanticMinJs" />
<spring:url value="/resources/map/js/map2.js" var="mapJs"/>
 
<link href="${semanticMinCss}" rel="stylesheet" />
<link href="${mapCss}" rel="stylesheet" />
<script src="${semanticMinJs}"></script>
<script src="${mapJs}"></script>

<%
   request.setCharacterEncoding("utf-8");
   String id = request.getParameter("id");  
%>

<script
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXzorrjSQ61PxTjiyMHOydxJOq0iEOcaI&libraries=drawing,places" async defer>
</script>
<!-- &callback=initMap -->
<style> 
.map-total{
   position: relative; 
   /* width: 820px;
    height: 500px; */
    left: 400px;
     top: 250px;
     margin:0;
     
} 

.block {
    display: block;
    width: 100%;
    border: none;
    background-color: #f0f5f5;
    color: #244b75;
    padding: 14px 28px;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
}

.block:hover{
    background-color: #b3cccc;
    color: #244b75;
}

.ui.primary.button, .ui.primary.buttons .button, .ui.button {
   width:47%;
   display: inline-block;
}

.ui.button {
margin-bottom:5px;
}

table,td{
   border-spacing: 0px 0px;
}

.colorBtn{
    border: none;
    color:#fff;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 20px 2px 0 0;
    cursor: pointer;

}
</style>

</head>
<body>
<input type="hidden" id="memberId" value=<%=id%> /> 
<input type="hidden" id="color"/>
<input type="hidden" id="pickCount" value=""/>
<input type="hidden" id="lat" value=""/>
<input type="hidden" id="lng" value=""/>
<%-- <input type="text" id="selectDate" value=<%=selectDate[0]%>/> --%>   

<input type="hidden" id="testInput"/>

<div class="map-total" >
<table>
   <tr>
   <td>
   <select class="ui dropdown">
   <% 
      String[] selectDate = request.getParameterValues("selectDate");
      if(selectDate != null){
         for(int i=0;i<selectDate.length;i++){
   %>         
            <option><%=selectDate[i] %></option>
   <%          
   
         }
      }
   %> 
   </select>
   </td>
   
   <td rowspan="2">
      <div id="main-aside">
         <form id="pickPlaceList" name="pickPlaceList" >   
            <input id ="confirmBtn"  class="ui primary button" type="button" value="confirm">
            <input id ="resetBtn"  class="ui button" type="button" value="reset">
         </form>   
         
         <div id="vertical_buttons" style="height:458px; width:200px; overflow-y:scroll">
         <%
             for(int i=0;i<20;i++){
         %>      
               <button class="block" onclick="change1(this)"></button>
               
         <%      
             }
         %>
         </div>   
      </div>
   </td>
   
   </tr>
   <tr>
   <td id='test'>
      <div><input  id="searchInput"  class="controls"  type = "text"  placeholder = "위치 입력" /></div>
      <div id="map" style="border-color:#334d99"></div>
   </td>   
   
</table>

<div>
   <% String[] colorArray = {"#ff4d4d", "#ffa64d", "#ffff4d", "#79ff4d", "#4dffff", "#4d79ff", "#d24dff", "#ff4dd2","#ffcccc","#bfbfbf"};
      for(int i=0;i<10;i++){
   
   %>
      <button class="colorBtn" style="background-color:<%=colorArray[i] %>" value="<%=colorArray[i] %>">♥</button>
   <%
      }
   %>            
</div>
</div>

<div id="infoContent" style="display:none">
   <table >               
      <tr><th align=left id="InfoPlaceName"></th></tr>   
      <tr><td id="address"></td></tr>
      <tr>
         <td>selectMember</td>
         <!--  <td><input id ="pickBtn" class="btn btn-outline-light text-dark" type="button" value="Pick"></td> --> 
          <td><button class="btn btn-outline-light text-dark" type="button" id ="pickBtn" >Pick</button></td> 
          <td><input id="cancelBtn" class="btn btn-outline-light text-dark" type="button" value="Cancel"></td>
      </tr>
   </table>
   <table id="output">
   </table>
</div>

</body>
</html>