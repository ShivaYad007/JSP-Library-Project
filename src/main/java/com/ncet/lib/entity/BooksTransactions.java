package com.ncet.lib.entity;

import java.awt.print.Book;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BooksTransactions {
	private int transId;
    private Book book;
    private LocalDate issuedOn;
    private LocalDate endOn;
    private String remarks;
  
}