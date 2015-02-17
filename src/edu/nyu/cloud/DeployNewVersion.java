package edu.nyu.cloud;


import java.io.File;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.amazonaws.AmazonClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.services.elasticbeanstalk.AWSElasticBeanstalk;
import com.amazonaws.services.elasticbeanstalk.AWSElasticBeanstalkClient;
import com.amazonaws.services.elasticbeanstalk.model.CreateApplicationVersionRequest;
import com.amazonaws.services.elasticbeanstalk.model.CreateApplicationVersionResult;
import com.amazonaws.services.elasticbeanstalk.model.S3Location;
import com.amazonaws.services.elasticbeanstalk.model.UpdateEnvironmentRequest;
import com.amazonaws.services.elasticbeanstalk.model.UpdateEnvironmentResult;


public class DeployNewVersion {

	private static final Log log = LogFactory.getLog(DeployNewVersion.class);
	
	private AWSCredentials credentials;

	private String versionLabel;
	private String bucketName;
	private String warName;
	

	private AWSElasticBeanstalk beanstalk;

	public DeployNewVersion(String versionLabel, String bucketName, String warName) throws Exception {
		
		// Get credentials from properties file
		credentials = new PropertiesCredentials(DeployNewVersion.class
                .getResourceAsStream("AwsCredentials.properties"));

		beanstalk = new AWSElasticBeanstalkClient(credentials);
		
		this.versionLabel = versionLabel;
		this.bucketName = bucketName;
		this.warName = warName;

	}
	
	

	
	
	/**
	 * Create an Elastic Beanstalk application version for this war,
	 * indicating its location in S3.
	 */
	private void createApplicationVersion() throws AmazonClientException {
		SimpleDateFormat friendlyDateFormat = new SimpleDateFormat("dd MMM yyy HH:mm");
		
		log.info("Creating application version " + versionLabel);

		CreateApplicationVersionRequest request = 
			new CreateApplicationVersionRequest("twittermap", versionLabel);
		request.setDescription("War created by TwitterMap on " + friendlyDateFormat.format(new Date()));
		request.setSourceBundle(new S3Location(bucketName, warName));
		
		CreateApplicationVersionResult result = beanstalk.createApplicationVersion(request);
		
		log.info("Version " + result.getApplicationVersion().getVersionLabel() + " has been created.");
		log.info("Version details: " + result.getApplicationVersion());

	}
	
	
	private void deployVersion() throws AmazonClientException {
		
		String environmentName = "testDeployment";
		log.info("Updating environment "+environmentName+" with version " +versionLabel);
		UpdateEnvironmentRequest request = new UpdateEnvironmentRequest();
		request.setEnvironmentName(environmentName);
		request.setVersionLabel(versionLabel);
		
		UpdateEnvironmentResult result = beanstalk.updateEnvironment(request);
		log.info("SUCCESS! Version deploy requested. Test environment is now " + result.getStatus());
		
	}

    
    
	/**
	 * @param args one argument containing the location of the war to deploy
	 */
	public static void main(String[] args) throws Exception {


		FinishedListener listener = new FinishedListener() {
			@Override
			public void succeeded() {
				System.exit(0);
			}
			@Override
			public void failed(Throwable e) {
				System.exit(1);
			}
		};
		
		String fileName = "/terMap.war";
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd'T'HHmm");
			String versionLabel = "TwitterMap_" + dateFormat.format(new Date());
			
			// the name that we give to the S3 resource containing the war is "heystaq-test_20110520T1450.war"
			// and the S3 bucket where we upload the wars is called "twittermap"
			DeployNewVersion deployer = new DeployNewVersion(
					versionLabel,
					"twittermap",
					versionLabel + ".war");
		
		} catch (FileNotFoundException e) {
        	System.out.println("Sorry, the file "+fileName+" doesn't exist");
        	System.exit(0);
		}

	}
	
	private interface FinishedListener {
		void succeeded();
		void failed(Throwable e);
	}

}