package com.example.btl1.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity(name = "order_book")
@Data
public class OrderBook {
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

    //số lượng
    private int quantity;

    //tổng tiền
    private Long total;

    //trạng thái
    private int status;

    //ngày mua
    @Column(name="buy_date")
    private Date buyDate;

    //địa chỉ giao hàng
    private String address;




}
