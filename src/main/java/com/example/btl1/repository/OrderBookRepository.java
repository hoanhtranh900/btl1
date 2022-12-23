package com.example.btl1.repository;

import com.example.btl1.model.OrderBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderBookRepository extends JpaRepository<OrderBook, Long> {
    @Query("select o from order_book o order by o.buyDate DESC")
    List<OrderBook> findByOrderByBuyDateDesc();

    //group by order_history_id

}
