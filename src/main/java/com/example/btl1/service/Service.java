package com.example.btl1.service;

import com.example.btl1.model.*;
import com.example.btl1.repository.BookRepository;
import com.example.btl1.repository.OrderBookRepository;
import com.example.btl1.repository.UserRepository;
import com.example.btl1.repository.VoteRepository;
import com.example.btl1.utils.H;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;

@org.springframework.stereotype.Service
@Transactional(rollbackFor = Exception.class)
public class Service {
    private String errorMessage;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private OrderBookRepository orderBookRepository;

    @Autowired
    private FileService fileService;
    @Autowired private VoteRepository voteRepository;
    @Autowired
    private UserRepository userRepository;

    public void save(Book book) {

        bookRepository.save(book);
    }

    public List<Book> listAll() {
        return (List<Book>) bookRepository.findAll();
    }

    public Book get(Long id) {
        Book book = bookRepository.findOne(id);
        List<FileAttachDocument> fileAttachDocuments = fileService.findByObjectId(id);
        if(H.isTrue(fileAttachDocuments)) {
            book.setImage(fileService.getFile(fileAttachDocuments.get(0)));
        }
        else {
            book.setImage("");
        }
        return book;
    }

    public void delete(Long id) throws IOException {
        List<FileAttachDocument> fileAttachDocuments = fileService.findByObjectId(id);
        for (FileAttachDocument fileAttachDocument : fileAttachDocuments) {
            fileService.delete(fileAttachDocument.getId());
        }
        bookRepository.delete(id);
    }

    public List<Book> search(String keyword) {
        return bookRepository.search(keyword);
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public boolean validate(Book book) {
        //validate exits by name
        if (book.getAuthor().isEmpty()) {
            errorMessage = "T??n t??c gi??? b???t bu???c nh???p";
            return false;
        }
        if (book.getDescription().isEmpty()) {
            errorMessage = "M?? t??? b???t bu???c nh???p";
            return false;
        }
        if (book.getTitle().isEmpty()) {
            errorMessage = "Ti??u ????? b???t bu???c nh???p";
            return false;
        }
        if (book.getPrice() == null) {
            errorMessage = "Gi?? b???t bu???c nh???p";
            return false;
        }
        if(!H.isTrue(book.getRemain())) {
            errorMessage = "S??? l?????ng b???t bu???c nh???p";
            return false;
        }
        if(!H.isTrue(book.getPages())) {
            errorMessage = "S??? trang b???t bu???c nh???p";
            return false;
        }
        if( book.getRemain() < 0 || book.getPages() < 0 || book.getPrice() < 0) {
            errorMessage = "S??? l?????ng, s??? trang, gi?? kh??ng ???????c nh??? h??n 0";
            return false;
        }

        //check exits by name
        List<Book> list = bookRepository.findAllByTitle(book.getTitle());
        //check if have current id remove it from list
        if (book.getId() != null) {
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).getId().equals(book.getId())) {
                    list.remove(i);
                    break;
                }
            }
        }
        if (list.size() > 0) {
            errorMessage = "T??n ???? t???n t???i";
            return false;
        }

        return true;

    }

    public List<Book> findAll() {
        return bookRepository.findAll();
    }

    public void saveOrderBook(OrderBook orderBook) {
        orderBookRepository.save(orderBook);
    }

    public List<OrderBook> findAllOrderBook() {
        //order by buy date desc
        return orderBookRepository.findByOrderByBuyDateDesc();
//        return orderBookRepository.findAll();
    }

    public Vote saveVote(Vote vote) {
        return voteRepository.save(vote);
    }

    public List<Vote> getVoteByBookId(Long id) {
        return voteRepository.findByBook_Id(id);
    }

    public List<OrderBook> findAllOrderBookByLoginUser() {

        String userName = SecurityContextHolder.getContext().getAuthentication().getName();

        return orderBookRepository.findByUser_UsernameOrderByBuyDateDesc(userName);
    }

    public OrderBook findOrderBookById(Long id) {
        return orderBookRepository.findOne(id);
    }

    public List<OrderBook> findAllOrderBookByOrderHistoryId(String concatId) {
        return orderBookRepository.findByOrderHistoryId(concatId);
    }
}
