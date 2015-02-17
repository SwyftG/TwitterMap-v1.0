package edu.nyu.cloud;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import twitter4j.FilterQuery;
import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterException;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.URLEntity;
import twitter4j.User;
import edu.nyu.*;

public class Stream {
	private Connection con;
	private PreparedStatement pstm;
	public static String dbName = ""; 
	public static String userName = "";
	public static String password = "";
	public static String hostname = "..--1..amazonaws.com";
	public static String port = "";
	static String jdbcUrl = ;
	static String connectionString = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName;
	public static Connection connection ;
	public static Statement command;
	public static TwitterStream twitterStream; 
	
		public static void startCollect() throws SQLException{
		    
			connection =DriverManager.getConnection(jdbcUrl);
			command = connection.createStatement();
			matchHelper mh = new matchHelper();
			StatusListener listener = new StatusListener(){
		    	
		        public void onStatus(Status status) {
		        	if (status.getGeoLocation()!=null) {
		        	User user = status.getUser();
	                

	                String username = status.getUser().getScreenName();

	                Double latitude = status.getGeoLocation().getLatitude();
	                Double longitude = status.getGeoLocation().getLongitude();
	                String content = status.getText();
	                String time = status.getCreatedAt().toString();
	                String keyword = mh.iskeyword(status.getText());
	                content = content.replaceAll("'", "\"");
	                System.out.println(username+"########"+content+"#######" + latitude + "########" + longitude + "####" + time);
	                try {
						command.execute("INSERT INTO Test (Name, Content, Latitude, Longtitude, Time, Keyword) VALUES ('"+ username+"', '" + content+"', '"+latitude + "', '"+ longitude +"','"+ time +"', '"+ keyword +"')");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		        	}
		        }
		        public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
		        public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
		        public void onException(Exception ex) {
		            ex.printStackTrace();
		        }
				@Override
				public void onScrubGeo(long arg0, long arg1) {
					// TODO Auto-generated method stub
					
				}
				@Override
				public void onStallWarning(StallWarning arg0) {
					// TODO Auto-generated method stub
					
				}
		    };
		    
		    twitterStream = new TwitterStreamFactory().getInstance();
		    FilterQuery fq = new FilterQuery();
		    String keywords[] = {"new york"};

		    //fq.track(keywords);
		    fq.locations(new double[][] { { -180, -90 }, { 180, 90 } });
		    
		    twitterStream.addListener(listener);
		    // sample() method internally creates a thread which manipulates TwitterStream and calls these adequate listener methods continuously.
		    //twitterStream.sample();
		    twitterStream.filter(fq); 
		    try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				twitterStream.shutdown();
				e.printStackTrace();
			}
		    finally{
		    	twitterStream.shutdown();
		    }
		}
		public static void streamEnd() {
			twitterStream.shutdown();
		}
}
