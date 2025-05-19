package com.hamroKarkhana.model;


public class CustomerModel {
	
	private String name;
	private String username;
	private String email;
	private String phoneNumber;
	private String password;
	private String address;
	private String gender;
	private String profilePicture;
	
	
	public CustomerModel(String name, String username, String email, String phoneNumber,
			String address, String gender,String password, String profilePicture) {
		super();
		this.name = name;
		this.username = username;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.address = address;
		this.gender = gender;
		this.profilePicture = profilePicture;
	}
	public CustomerModel(String name, String username, String email, String phoneNumber, String address, String gender) {
		super();
		this.name = name;
		this.username = username;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.gender = gender;

	
	}
	public CustomerModel(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public CustomerModel() {}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProfilePicture() {
		return profilePicture;
	}
	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}
	
	

}
