package com.spring.jamplan2.searchcontroller;

import org.springframework.stereotype.Component;

/**
 * @author wookim
 * @param 
 *   
 */
@Component
public class UserVO {
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

   public String getSnsSite() {
      return snsSite;
   }

   public void setSnsSite(String snsSite) {
      this.snsSite = snsSite;
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

   public int isAdmin() {
      return isAdmin;
   }

   public void setAdmin(int isAdmin) {
      this.isAdmin = isAdmin;
   }

   public String getSignDate() {
      return signDate;
   }

   public void setSignDate(String signDate) {
      this.signDate = signDate;
   }


}