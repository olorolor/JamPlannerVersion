package com.spring.jamplan.model;

import org.springframework.stereotype.Component;

/**
 * @author wookim
 * @param 
 *	
 */

/*CREATE TABLE USERINFO
	(	ID VARCHAR2(10) PRIMARY KEY, 
	EMAIL VARCHAR2(20), 
	PASS VARCHAR2(20), 
	ISADMIN VARCHAR2(5), 
	SIGNDATE DATE, 
	NATION VARCHAR2(10), 
	GENDER VARCHAR2(10), 
	IMG VARCHAR2(100), 
	AGE VARCHAR2(5), 
	SNSLINK VARCHAR2(100), 
	TRAVELTYPE VARCHAR2(10), 
	HOBBY VARCHAR2(20) 
	);
	  private String id;
   private String email;
   private String pass;
   private String nation;
   private String gender;
   private String snsSite;
   private String travelType;
   private String hobby;
   private String image;
   
   private int age;
   
   private int isAdmin;
   
   private String signDate;
*/

@Component
public class UserVO {
	String id;
	String email;
	String pass;
	String nation;
	String gender;
	String travelType;
	String hobby;
	String authCode;

	String image;
	
	int age;
	
	int isAdmin;//1이 관리자 0이 유저
	
	String signDate;
	
	public void printElement() {
		System.out.println(id);
		System.out.println(pass);
		System.out.println(email);
		System.out.println(nation);
		System.out.println(gender);
		System.out.println(travelType);
		System.out.println(hobby);
		System.out.println(image);
		System.out.println(age);
		System.out.println(isAdmin);
		System.out.println(signDate);

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getSignDate() {
		return signDate;
	}

	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

}
