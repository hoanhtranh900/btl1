package com.example.btl1.model;


import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    private String author;
    private String title;
    private String description;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date publishedDate;
    private int pages;
    private int type;

    @Transient
    private String image;

}