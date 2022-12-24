package com.example.btl1.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
public class Vote {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //người mua
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    //sách
    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    private int vote;

    private String comment;

    @Column(name="vote_date")
    private Date voteDate;
}
