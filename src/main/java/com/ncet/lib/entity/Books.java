package com.ncet.lib.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Books {
	private int bookId;
	private String name;
	private String author;
	private String edition;
	private String department;
	private int quantity;
}
