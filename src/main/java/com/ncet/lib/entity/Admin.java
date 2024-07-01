package com.ncet.lib.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Admin {
	private int aid;
	private String name;
	private long phno;
	private String gmail;
	private String username;
	private String password;
}