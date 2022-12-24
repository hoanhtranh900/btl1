package com.example.btl1.web;

import com.example.btl1.DTO.CartDTO;
import com.example.btl1.model.*;
import com.example.btl1.service.FileService;
import com.example.btl1.service.SecurityService;
import com.example.btl1.service.Service;
import com.example.btl1.service.UserService;
import com.example.btl1.utils.H;
import com.example.btl1.validator.UserValidator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.transaction.annotation.Transactional;

@org.springframework.stereotype.Controller
@Transactional(rollbackFor = Exception.class)
public class Controller {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired private Service service;
    @Autowired private FileService fileService;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        //set message to utf-8


        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/list";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(Model model, String error, String logout) {
        ModelAndView modelAndView = new ModelAndView();
        if (error != null)
            modelAndView.addObject("error", "Sai tên tài khoản hoặc mật khẩu.");

        if(logout != null)
            modelAndView.addObject("message", "Đăng xuất thành công.");
        modelAndView.setViewName("login");
        return modelAndView;
    }

    @RequestMapping(value = {"/", "/list"}, method = RequestMethod.GET)
    public ModelAndView welcome(@ModelAttribute("message") String message, @ModelAttribute("messageType") String messageType) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("messageType", messageType);
        modelAndView.setViewName("listbook");

        List<Book> books = service.findAll();
        modelAndView.addObject("books", books);
        return modelAndView;
    }

    @RequestMapping(value = {"/create"}, method = RequestMethod.GET)
    public ModelAndView createProductPage() {
        ModelAndView modelAndView = new ModelAndView();
        Book book = new Book();
        modelAndView.addObject("book", book);
        modelAndView.setViewName("/create-product");
        return modelAndView;
    }

    @RequestMapping(value = {"/logout"}, method = RequestMethod.GET)
    public String logout(HttpSession session ) {
        session.invalidate();
        return "redirect:/login";
    }


    @RequestMapping(value = {"/detailOredit/{id}",}, method = RequestMethod.GET)
    public ModelAndView editProductPage(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("create-product");
        Book book = service.get(id);
        List<Vote> votes = service.getVoteByBookId(id);
        mav.addObject("votes", votes);

        //calculate average vote
        double averageVote = 0;
        if(votes.size() > 0){
            averageVote = votes.stream().mapToDouble(Vote::getVote).average().getAsDouble();
            //round to 1 decimal place
            averageVote = Math.round(averageVote * 10.0) / 10.0;
        }
        mav.addObject("averageVote", averageVote);
        mav.addObject("book", book);

        return mav;
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView saveCustomer(@ModelAttribute("model") Book book, @RequestParam(name = "file", required = false) MultipartFile file) throws IOException {
        if (!service.validate(book)) {
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.addObject("message", service.getErrorMessage());
            modelAndView.addObject("book", book);
            modelAndView.setViewName("/create-product");
            return modelAndView;
        }
        service.save(book);
        if(file.getSize() > 0) {
            //delete current file
            List<FileAttachDocument> fileAttachDocuments = fileService.findByObjectId(book.getId());
            for (FileAttachDocument fileAttachDocument : fileAttachDocuments) {
                fileService.delete(fileAttachDocument.getId());
            }
            fileService.uploadFile(file, book.getId());
        }


        return new ModelAndView("redirect:/list");
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView search(@RequestParam String keyword) {
        List<Book> result = service.search(keyword);
        ModelAndView mav = new ModelAndView("getlist-product");
        mav.addObject("listModel", result);

        return mav;
    }

    @RequestMapping("/delete")
    public String deleteCustomerForm(@RequestParam("id") long id) throws IOException {
        service.delete(id);
        return "redirect:/list";
    }

    @RequestMapping(path = "/downloadFile/{productId}", method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> downloadFile(HttpServletResponse response, @PathVariable Long productId) throws Exception {
        return fileService.downloadFile(response, productId);
    }

    //cart
    //1. get ui
    @RequestMapping(value = {"/cart"}, method = RequestMethod.GET)
    public ModelAndView cart() {

        ModelAndView modelAndView = new ModelAndView();
        //get data cart from local storage and set to model


        modelAndView.setViewName("cart");
        return modelAndView;
    }
    //2. order
    @RequestMapping(value = {"/save-order"}, method = RequestMethod.POST)
    public ModelAndView saveOrder(
            HttpServletRequest request,
            RedirectAttributes resp
    ) throws IOException {
        ModelAndView modelAndView = new ModelAndView();
        System.out.println(request);
        System.out.println("save order");


        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String totalMoney = request.getParameter("totalMoney");
        String cartJSON = request.getParameter("cart");

        List<CartDTO> cartDTOS = H.isTrue(cartJSON)  ? new Gson().fromJson(cartJSON, new TypeToken<List<CartDTO>>(){}.getType()) : new ArrayList<>();

        //save orderbook
        if(cartDTOS.size()>0) {
            //check quantity vs remain
            for (CartDTO cartDTO : cartDTOS) {
                Book book = service.get(cartDTO.getId());
                if(book.getRemain() < cartDTO.getQuantity()) {
                    modelAndView.addObject("message", "Số lượng sách " + book.getTitle() + " không đủ");
                    modelAndView.setViewName("cart");
                    return modelAndView;
                }
            }
            List<OrderBook> orderBooks = new ArrayList<>();
            for (CartDTO cartDTO : cartDTOS) {
                OrderBook orderBook = new OrderBook();
                orderBook.setAddress(address);
                orderBook.setTotal(Long.valueOf(totalMoney));
                orderBook.setStatus(1);
                orderBook.setBook(service.get(cartDTO.getId()));
                orderBook.setUser(userService.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName()));
                orderBook.setBuyDate(new Date());
                orderBook.setPhone(phone);
                orderBook.setQuantity(cartDTO.getQuantity());
                service.saveOrderBook(orderBook);
                orderBooks.add(orderBook);
            }

//            get order histort id = id per order
            String orderHistoryId = orderBooks.stream().map(orderBook -> orderBook.getId().toString()).collect(Collectors.joining("_"));
            for (OrderBook orderBook : orderBooks) {
                orderBook.setOrderHistoryId(orderHistoryId);
                service.saveOrderBook(orderBook);
            }


            resp.addFlashAttribute("messageType", "99");
        }
        else {
            modelAndView.addObject("message", "Giỏ hàng trống");
            modelAndView.setViewName("cart");
            return modelAndView;
        }
        if (!H.isTrue(address) || !H.isTrue(phone)) {
            modelAndView.addObject("message", "Vui lòng nhập địa chỉ hoặc số điện thoại");
            modelAndView.setViewName("cart");
            return modelAndView;
        }


        //redirect
        return new ModelAndView("redirect:/list");
    }


    //history
    @RequestMapping(value = {"/history"}, method = RequestMethod.GET)
    public ModelAndView history() {
        List<OrderBook> orderBooks = service.findAllOrderBook();

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("orderBooks", orderBooks);
        modelAndView.setViewName("history");
        return modelAndView;
    }

    //vote
    @RequestMapping(value = {"/vote"}, method = RequestMethod.POST)
    public String vote(
            HttpServletRequest request,
            RedirectAttributes resp
    ) throws IOException {
        System.out.println(request);
        System.out.println("vote");

        String bookId = request.getParameter("bookId");
        String vote = request.getParameter("voteStar");
        String comment = request.getParameter("voteComment");

        return "redirect:/detailOredit/" + bookId;
    }

    @RequestMapping(value = {"/vote"}, method = RequestMethod.GET)
    public @ResponseBody Object vote1(
            HttpServletRequest request,
            RedirectAttributes resp
    ) throws IOException {
        System.out.println(request);
        System.out.println("vote");



        String ajaxResponse = "";
        ObjectMapper mapper = new ObjectMapper();
        try {
            String bookId = request.getParameter("bookId");
            String voteStar = request.getParameter("voteStar");
            String comment = request.getParameter("voteComment");

            Vote vote  = new Vote();
            vote.setBook(service.get(Long.valueOf(bookId)));
            vote.setComment(comment);
            vote.setVote(Integer.valueOf(voteStar));
            vote.setVoteDate(new Date());
            User userlogin = userService.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
            vote.setUser(userlogin);
            service.saveVote(vote);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ajaxResponse;
    }
}
