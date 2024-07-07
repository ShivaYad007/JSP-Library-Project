package com.ncet.lib.utils;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyBooks {
	private String name;
	private String author;
	private String edition;
	private LocalDate issuedOn;
	private LocalDate endOn;
	private String remarks;
}
