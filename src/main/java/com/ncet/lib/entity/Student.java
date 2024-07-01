package com.ncet.lib.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Student {
	private int sId;
    private String name;
    private String rollno;
    private long phno;
    private String department;
    private String gmail;
    private String username;
    private String password;
    private int yearOfJoining;
    private int yearOfEnding;
    

    
}
