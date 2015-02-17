<%@ page language="java"  pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>TwitterMap by Yulei Liu and Liang Gao</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript">
		function Search(){
			document.getElementById("infospan").innerHTML="Search";
		}
		
		function Start(){
			document.getElementById("infospan").innerHTML="Start";
		}
		function End(){
			document.getElementById("infospan").innerHTML="End";
		}
	</script>
	<script type="text/javascript"  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDq7I_dQ7joWqW2fYFe92DvF8xRyQLlyRE"><!--google map-->
    </script>
    <script type="text/javascript">
      function initialize() {
    	var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
    	var myLatlng2 = new google.maps.LatLng(-28.363882,131.044922);
    	var myLatlng3 = new google.maps.LatLng(-30.363882,120.044922);
        var mapOptions = {
          center: { lat: -34.397, lng: 150.644},
          zoom: 4
        };
        var map = new google.maps.Map(document.getElementById('map-canvas'),
            mapOptions);
     // To add the marker to the map, use the 'map' property
        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title:"Hello World!"
        });
        var marker = new google.maps.Marker({
            position: myLatlng2,
            map: map,
            title:"Hello World!"
        });
        
        
    
        
     	
      }
      google.maps.event.addDomListener(window, 'load', initialize);
    </script>
  </head>
  
  <body>
    	<div style="width: 100%;height: 100%">
    		<table style="width: 100%;height: 100%" border="1px">
			<tr align="center" height="40" style="border: 1px"  >
				<!--tittle -->
				<td colspan="5" align="center" style="height:"><h1>TwitterMap</h1>
				</td>
			</tr>
			<tr>
    				<td style="width: 25%;height: 7%">
    				<!-- search -->
    					<div>
						<input id="inputInfo">
						<button value="Search" onclick="Search(inputInfo)">Search</button>
    					</div>
    					<div>&nbsp;
    						<button value="Start" onclick="Start()">Start</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    						<button value="End" onclick="End()">&nbsp;End&nbsp;</button>
    					</div>
    				</td>
    				<td rowspan="2">
    					<div style="width:100%;height: 100%">
    						<div id="map-canvas" style="width:100%;height: 100%;"></div>
    					</div>	
    				</td>
    			</tr>
    			<tr>
    				<td >
    					<div style="height: 100%;width: 100%">
    						<span id="infospan">twitter text</span>
    					</div>
    				</td>
    			</tr>
    		</table>
    	</div>
  </body>
</html>
