package com.example.btl1.service;

import com.example.btl1.model.Book;
import com.example.btl1.model.FileAttachDocument;
import com.example.btl1.model.OrderBook;
import com.example.btl1.repository.BookRepository;
import com.example.btl1.repository.OrderBookRepository;
import com.example.btl1.utils.H;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;

import java.io.IOException;
import java.util.List;

@org.springframework.stereotype.Service
public class Service {
    private String errorMessage;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private OrderBookRepository orderBookRepository;

    @Autowired
    private FileService fileService;

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
            errorMessage = "Tên tác giả bắt buộc nhập";
            return false;
        }
        if (book.getDescription().isEmpty()) {
            errorMessage = "Mô tả bắt buộc nhập";
            return false;
        }
        if (book.getTitle().isEmpty()) {
            errorMessage = "Tiêu đề bắt buộc nhập";
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
            errorMessage = "Tên đã tồn tại";
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
}
