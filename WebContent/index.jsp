<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.amazonaws.*" %>
<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.services.ec2.*" %>
<%@ page import="com.amazonaws.services.ec2.model.*" %>
<%@ page import="com.amazonaws.services.s3.*" %>
<%@ page import="com.amazonaws.services.s3.model.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils, edu.nyu.cloud.Stream, edu.nyu.cloud.DB, java.util.ArrayList, java.sql.PreparedStatement, java.sql.ResultSet, java.io.IOException, java.sql.Connection, java.sql.DriverManager,java.sql.PreparedStatement, java.sql.SQLException, java.sql.Statement" %>

<%! // Share the client objects across threads to
    // avoid creating new clients for each web request
    private AmazonEC2         ec2;
    private AmazonS3           s3;
    private AmazonDynamoDB dynamo;
	private Connection con;
	private PreparedStatement pstm;
	public static String dbName = "base1"; 
	public static String userName = "user1";
	public static String password = "90289028";
	public static String hostname = "example3.cpfleo5mk9b3.us-east-1.rds.amazonaws.com";
	public static String port = "3306";
	public static String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName +
			"?user=" + userName + "&password=" + password;
	static String connectionString = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
	public static Connection connection ;
	public static Statement command;
	
 %>

<%
    /*
     * AWS Elastic Beanstalk checks your application's health by periodically
     * sending an HTTP HEAD request to a resource in your application. By
     * default, this is the root or default resource in your application,
     * but can be configured for each environment.
     *
     * Here, we report success as long as the app server is up, but skip
     * generating the whole page since this is a HEAD request only. You
     * can employ more sophisticated health checks in your application.
     */
    if (request.getMethod().equals("HEAD")) return;
%>
<%	
	ArrayList<String> nameArray = new ArrayList<String>();
    ArrayList<String> contentArray = new ArrayList<String>();
    ArrayList<String> latitudeArray = new ArrayList<String>();
    ArrayList<String> longtitudeArray = new ArrayList<String>();
    ArrayList<String> timeArray = new ArrayList<String>();
    ArrayList<String> keywordArray = new ArrayList<String>();
    ArrayList<String> infoArray = new ArrayList<String>();
    Class.forName("com.mysql.jdbc.Driver");
    Stream.startCollect();
	nameArray = DB.getNameArray();
	contentArray = DB.getContent();
	latitudeArray = DB.getLatitude();
	longtitudeArray = DB.getLongtitude();
	timeArray = DB.getTimeArray();
	keywordArray = DB.getKeywordArray();
	
    
   	%>
    		 



<!DOCTYPE html>
<html>
  <head>
  <title>TwitterMap by Yulei Liu and Liang Gao</title>
    <style type="text/css">
      html, body, #map-canvas { height: 100%; margin: 0; padding: 0;}
    </style>
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDq7I_dQ7joWqW2fYFe92DvF8xRyQLlyRE&libraries=visualization&sensor=true">
    </script>
    <script type="text/javascript">
    
    
   
    var markers = [];
    var heatmap;
    var map;

    var mapdata = [<% for (int i=nameArray.size()-22; i>nameArray.size()-2998;i--) {
    	String content = StringEscapeUtils.escapeEcmaScript(contentArray.get(i));
    	String name = StringEscapeUtils.escapeEcmaScript(nameArray.get(i));
    	
    	
    	out.print("['"+name+"', '"+content+"', "+latitudeArray.get(i)+", "+longtitudeArray.get(i)+", '"+timeArray.get(i)+"', '"+keywordArray.get(i)+"'],");
	}
    String name1 = StringEscapeUtils.escapeEcmaScript(nameArray.get(nameArray.size()-3000));
	String contentx = StringEscapeUtils.escapeEcmaScript(contentArray.get(nameArray.size()-3000));
		out.print("['"+name1+"', '"+contentx+"', "+latitudeArray.get(nameArray.size()-3000)+", "+longtitudeArray.get(nameArray.size()-3000)+", '"+timeArray.get(nameArray.size()-3000)+"', '"+keywordArray.get(nameArray.size()-3000)+"'],");
	%>
	];  
    
    
      function initialize() {
    	  var mapOptions = {
    	          center: { lat: 0.000, lng: 27.000},
    	          zoom: 2
    	        };
    	         map = new google.maps.Map(document.getElementById('map-canvas'),
    	            mapOptions);
    	
    	    	 
			
    	 
    	  var heatMapData = [ <% for(int i=nameArray.size()-22;i > nameArray.size()-1000;i--){
    		  						String w = "{location: new google.maps.LatLng("+latitudeArray.get(i)+"," +longtitudeArray.get(i)+"), weight: 100},";
    		  								//new google.maps.LatLng("+latitudeArray.get(i)+"," +longtitudeArray.get(i)+"),";
    		  						out.write(w);
    	  }   
    	                  %> new google.maps.LatLng(37.785, -122.435) ];

    	  var heatMapData1 = new google.maps.MVCArray(heatMapData);
         
    	                   
    	                   
    	var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
    	var myLatlng2 = new google.maps.LatLng(-28.363882,131.044922);
    	var myLatlng3 = new google.maps.LatLng(-30.363882,120.044922);
    	var myLatlng4 = new google.maps.LatLng(-32.363882,120.044922);
    	var image = 'images/twitter2.png';
        
     // To add the marker to the map, use the 'map' property
       
        
      
        


       

         heatmap = new google.maps.visualization.HeatmapLayer({
          data: heatMapData
        });
        heatmap.set('radius',30);
        heatmap.setMap(map);
        
        
        <%
        for(int i=nameArray.size()-15;i > nameArray.size()-2800;i--){
		String content1 = contentArray.get(i).replace("\"","*");
		String content2 = content1.replace("“","*");
		String content3 = content2.replace("”","*");
		String content4 = content3.replace("‘","*");
		String content5 = content4.replace("’","*");
		String content6 = content4.replace("'","*");
		String content7 = content4.replace("’","*");
		
		String content = content7.replace("\'","*");
		String h = "var marker"+i+" = new google.maps.Marker({ position:new google.maps.LatLng("+latitudeArray.get(i)+"," +longtitudeArray.get(i)+"), map: map, icon:image , title:\" "+ nameArray.get(i) +" :Time "+timeArray.get(i) + " \"});";
		
        out.write(h);
        infoArray.add("\nUser Name:" +nameArray.get(i)+":"+
        		"Date:" + timeArray.get(i) + ":" +        		
        		"Location: " + latitudeArray.get(i)+", " +longtitudeArray.get(i) +
        		":" + "Content:   " + content );
        		
        contentArray.set(i,content);
        out.write("markers.push(marker"+i+");");
        }
        
        
        %>
        
        

     	
      }
      function setAllMap(map) {
      	for (var i = 0; i < markers.length; i++) {
      		markers[i].setMap(map);
      	}
      }
		function cleanMap() {
			setAllMap(null);
			heatmap.setMap(null);
		}
		function End(){
			<%
			Stream.streamEnd();
			%>
		}
    	function heatMap() {
    		setAllMap(null);
    		heatmap.setMap(map);
    	}
    	function markMap() {
    		heatmap.setMap(null);
    		setAllMap(map);
    	}
        function bothMap(){
        	heatmap.setMap(map);
    		setAllMap(map);
        }
        function NBA(){
        	heatmap.setMap(null);
        	setAllMap(null);
        	for (var i = 5; i < mapdata.length; i++) {
        		if (mapdata[i][5] == "love")
        			markers[i].setMap(map);
        	}
        }
	function allInfo(){
        	setAllMap(map);
        }
	function Game(){
		heatmap.setMap(null);
		setAllMap(null);
		for (var i = 5; i < mapdata.length; i++) {
    		if ( mapdata[i][5] == "me")
    			markers[i].setMap(map);
    	}
	}

     	google.maps.event.addDomListener(window, 'load', initialize);


    </script>

  </head>
 <body>
    	<div style="width: 100%;height: 100%">
    		<table style="width: 100%;height: 100%" border="1px">
			<tr align="center" height="40" style="border: 1px"  >
				<!--tittle -->
				<td colspan="2" align="center" style="height:"><h1>TwitterMap</h1>
				</td>
			</tr>
			<tr>
    				<th style="width: 20%;height: 7%" colspan = "1">
    				<!-- search -->
    					<div>
						Keyword:&nbsp;
						<button value="Search" onclick="allInfo()">All</button>
						<button value="nba" onclick="NBA()">Love</button>
						<button value="game" onclick="Game()">&nbsp;&nbsp;Me&nbsp;&nbsp;</button>
						</div>
    					<div>&nbsp;
    						<button value="End" onclick="End()">Stop Collection</button>
    						<button value="Start" onclick="cleanMap()">CleanMap</button>
    						<button value="heatMap" onclick="heatMap()">HeatMap</button>
    						<button value="markMap" onclick="markMap()">MarkMap</button>
    						<button value="bothMap" onclick="bothMap()">BothMap</button>
    					</div>
    				</th>
    				<td rowspan="2" colspan = "1" style="width:100%;height: 100%">
    					<div style="width:100%;height: 100%">
    						<div id="map-canvas" style="width:100%;height: 100%;"></div>
    					</div>	
    				</td>
    			</tr>
    			<tr>
    				<th colspan = "1" style="width: 20%;height: 100%" >
    					
    						<!-- <span id="infospan">twitter text</span>-->
    						<div align=left; colspan = "1";
style='
color: #000000;
background-color: #ffffff;
border: solid 2px black;
width: 100%;
height: 100%;
overflow: auto;
text-align: left;
font-size:10px;

'> 
<% for(int i = infoArray.size()-5; i>infoArray.size()-1000;i--){
	
	out.write("<br/>"+infoArray.get(i));
}

%> 


</DIV>
    						
    					
    				</th>
    			</tr>
    		</table>
    	</div>
  </body>
</html>