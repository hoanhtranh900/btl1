package com.example.btl1.model;

import com.example.btl1.utils.H;
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

    private String phone;

    @Column(name = "order_history_id")
    private String orderHistoryId;

    //ngày mua
    @Column(name="buy_date")
    private Date buyDate;

    //địa chỉ giao hàng
    private String address;

    @Transient
    private String statusString;

    @Transient
    private String buyDateString;

    @Transient
    private String moneyConvert;

    public String getMoneyConvert() {
        //convert to 1.000.000
        return H.convertMoney(total);
    }

    public String getStatusString() {
        switch (status) {
            case 1:
                return "Đang chờ xử lý";
            case 2:
                return "Đang giao hàng";
            case 3:
                return "Đã giao hàng";
            default:
                return "Đã hủy";
        }
    }

    public String getBuyDateString() {
        return H.date2str(buyDate, "dd/MM/yyyy HH:mm");
    }
}
