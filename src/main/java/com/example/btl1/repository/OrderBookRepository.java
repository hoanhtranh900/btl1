package com.example.btl1.repository;

import com.example.btl1.model.OrderBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderBookRepository extends JpaRepository<OrderBook, Long> {
    @Query("select o from order_book o order by o.buyDate DESC")
    List<OrderBook> findByOrderByBuyDateDesc();

    @Query("select o from order_book o where o.user.username = ?1 order by o.buyDate DESC")
    List<OrderBook> findByUser_UsernameOrderByBuyDateDesc(String username);

    @Query("select o from order_book o where o.orderHistoryId = ?1")
    List<OrderBook> findByOrderHistoryId(String orderHistoryId);



    //group by order_history_id

}
