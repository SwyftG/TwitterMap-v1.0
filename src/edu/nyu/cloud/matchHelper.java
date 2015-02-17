package edu.nyu.cloud;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class matchHelper {
	    String regex = "[Ll][Oo][Vv][Ee]|[mM][eE]|";
	    Pattern p = Pattern.compile(regex);
	    Pattern p1 = Pattern.compile("[Ll][Oo][Vv][Ee]");
	    Pattern p2 = Pattern.compile("[mM][eE]");
	    public String iskeyword(String text) {
	    	String ret = new String();
	    	Matcher m = p.matcher(text);
			if (m.find()) {
				if (p1.matcher(text).find()) {
					ret = "love";
					return ret;
				} else if (p2.matcher(text).find()) {
					ret = "me";
					return ret;
				}
			}
			ret = "none";
			return ret;
		}
}