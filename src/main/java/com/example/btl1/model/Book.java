package com.example.btl1.model;


import com.example.btl1.utils.H;
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
    private Long price;

    //số lượng còn lại
    private int remain = 0;

    @Transient
    private String image;
    @Transient
    private String priceString;

    public String getPriceString() {
        return H.convertMoney(price);
    }
}